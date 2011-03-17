From: sjg@chromium.org (Simon Glass)
Date: Thu, 17 Mar 2011 09:15:42 -0700
Subject: Questions about this patch: [PATCH] ARM: Use generic BUG() handler
In-Reply-To: <92C2E94F6F494872A3D66D05E1AB76B7@your6c359a3bdc>
References: <1300307259-834-1-git-send-email-sjg@chromium.org>
	<92C2E94F6F494872A3D66D05E1AB76B7@your6c359a3bdc>
Message-ID: <AANLkTinirdHHprbAanw=jG03dFDUTySqs5y3TDE8QNwK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 7:57 AM, anish kumar
<anish198519851985@gmail.com> wrote:
> https://lkml.org/lkml/2011/2/28/565
>
> I have tested this patch on my system(linux 2.6.35-android) and it is
> working
> perfectly fine so wanted to understand this patch.Will this patch be
> included in
> mainline?

That is my intent.

> I have few question from this thread.As my understanding of assembly is
> bit limited I would appreciate if someone can just say yes/no and probably
> add
> bit of words.
>
>> This implementation uses an undefined instruction to implement BUG, and
>> sets up
>> a bug table containing the relevant information. Many version of gcc do
>> not
>> support %c properly for ARM (inserting a # when they shouldn't) so we work
>> around this using distasteful macro magic.
>
> This undefined instruction should cause data abort ?

Actually it causes an undefined instruction exception (data abort is
when a data access fails).
>
>
>> +#define BUG() _BUG(__FILE__, __LINE__, BUG_INSTR_VALUE)
>> +#define _BUG(file, line, value) __BUG(file, line, value)
>> +#define __BUG(__file, __line, __value) \
>> +do { \
>> + BUILD_BUG_ON(sizeof(struct bug_entry) != 12); \
>> + asm volatile("1:\t" BUG_INSTR_TYPE #__value "\n" \
>> + ".pushsection .rodata.str, \"aMS\", 1\n" \
>> + "2:\t.asciz " #__file "\n" \
>> + ".popsection\n" \
>> + ".pushsection __bug_table,\"a\"\n" \
>> + "3:\t.word 1b, 2b\n" \
>> + "\t.hword " #__line ", 0\n" \
>> + ".popsection"); \
>> + unreachable(); \
>> +} while (0)
>
> Above piece of code i couldn't understand.As i understand this should do
> same as
> original BUG() definition plus it should print the function where BUG() had
> originally
> happened instead of "PC at _bug".I think in this code some
> data(guess:function name
> ,line no) is pushed on the stack and then popped but how this data is
> printed on console?

It adds an entry to the bug table, which is just data stored in a
__bug_table section. Each entry is of the format struct bug_entry -
see include/asm-generic/bug.h. We store the address of the BUG (i.e.
the undef instruction), a pointer to the filename string, the line
number and some flags.

This macro adds a single instruction to the code (the undef
instruction), and then adds another 12 bytes to the bug table. The
linker collects all the bug table data into one place. Another piece
of code - report_bug() in lib/bug.c - does the actual bug reporting.
It searches the bug table until it finds the relevant address, and
prints out the filename and number.

We could store the bug information actually in the code - in a sense
this is what the current ARM implementation does. It just calls the
__bug() function with appropriate arguments. The advantage of the
table approach is that this debugging / verbose info doesn't bloat the
code, and can in principle be removed at link time if not needed,
without losing the bug reporting. I suspect on most architectures
there is an overall kernel size reduction - sizeof(1 instruction + 12
bytes) < sizeof(marshalling 3 args and calling a function) - but on
ARM this may come out even depending on the line number.

There is probably a better explanation of this somewhere.

Regards,
Simon

>
> So kindly enlighten me on this piece of code or some pointers.Is there any
> thread which
> explains about kernel fault process?
>
