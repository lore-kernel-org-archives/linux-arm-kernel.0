From: sjg@chromium.org (Simon Glass)
Date: Tue, 20 Sep 2011 10:00:06 -0700
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110920075916.GD16381@n2100.arm.linux.org.uk>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919200317.GC16381@n2100.arm.linux.org.uk>
	<CAPnjgZ3+b=nhApZxV1aBGejxEr7MGN1e8neP-ychtVO2Ego2yQ@mail.gmail.com>
	<20110920075916.GD16381@n2100.arm.linux.org.uk>
Message-ID: <CAPnjgZ2-Ttmoa8zwSVqL70vXDoJv=-Z2XyVBuTi-bm4-0c6E-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Sep 20, 2011 at 12:59 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 20, 2011 at 12:06:22AM -0700, Simon Glass wrote:
>> Hi Russell,
>>
>> On Mon, Sep 19, 2011 at 1:03 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Sep 19, 2011 at 01:09:54PM +0100, Mark Brown wrote:
>> >> I'm seeing linker failures in -next as of today:
>> >>
>> >> `.exit.text' referenced in section `__bug_table' of fs/built-in.o:
>> >> defined in discarded section `.exit.text' of fs/built-in.o
>> >> `.exit.text' referenced in section `__bug_table' of crypto/built-in.o:
>> >> defined in discarded section `.exit.text' of crypto/built-in.o
>> >> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
>> >> defined in discarded section `.exit.text' of net/built-in.o
>> >> `.exit.text' referenced in section `__bug_table' of net/built-in.o:
>> >> defined in discarded section `.exit.text' of net/built-in.o
>> >>
>> >> which appears to be due to the chnage to use generic BUG() introduced in
>> >> commit 5254a3 (ARM: 7017/1: Use generic BUG() handler), reverting that
>> >> commit resolves the issue for me.
>>
>> Gosh this does seem a bit odd. Ordering seems to be clearly implied by
>> the file syntax and I agree we should seek guidance from binutils
>> people.
>
> I'm not sure that there's any value in seeking guidance from the linker
> folk - we can see what's going on with a few experiments. ?That's fine
> to find out what current linker behaviour is, but unless the manual
> documents it, its something that shouldn't be relied upon.
>
> Here's where I researched what the manual says and what practically happens
> with the linker:
>
> http://lists.arm.linux.org.uk/lurker/message/20110808.195805.a073e07d.en.html

Yes that was what I read first (at least twice :-). It is
counter-intuitive given the way the linker encourages us to lay out
scripts - as I said I believe that some sort of ordering is at least
implied by the docs.

>
>> I added the BUG condition to CONFIG_SMP_ON_UP and
>> CONFIG_DEBUG_SPINLOCK which were already there. If BUG is causing
>> problems, I wonder why these are not? Have we just been lucky, or have
>> I crossed a line? Or perhaps there are no spinlocks in exit text?
>
> The other stuff is also having problems. ?Rob Herring's report was about
> the SMP alternatives causing the same problem:
>
> http://lists.arm.linux.org.uk/lurker/message/20110808.184931.a38e1c4e.en.html

OK I see.

>
>> One option is to keep all exit text around - i.e. never discard it at
>> link time. From memory it is only 4-8KB. Doubtless many would be upset
>> with this, but it could be an option until this binutils behaviour is
>> resolved.
>
> We are trying to keep .exit.text around (when certain config options are
> set - and they are set - but the linker is deciding to discard it for us
> anyway, because asm-generic/vmlinux.lds.S always lists .exit.text in its
> discard section.

Yes what I meant was to not discard it - i.e. remove it from that link
script altogether.

>
> As we have a discard section at the beginning of the file to discard the
> unwinder information for other sections, the one from the generic file
> gets merged at the _start_ of the linker file, which results in .exit.text
> first appearance to be in the discard section.
>
> It's not that simple though - if you read the quote from the linker manual,
> the implication is that the linker would be entirely free to discard an
> input section as a priority if it appears in a discard section anywhere
> in the linker script. ?There's nothing to say future linkers won't do
> this. ?It would still be conformant to the linker manual.

Oh dear. That is why it might be a good idea to hassle the linker
people, since relying on experiments on how things currently work
might be risky if someone leaps in and changes the algorithm.

>
>> Another is to declare that it is a bug to use BUG in an exit section.
>> I was thinking about that at the time, but decided it was probably too
>> radical. There are only a small number of references in the kernel I
>> think (again from memory - this was back in April I think). Not
>> trivial to enforce, and the error you get is not exactly informative.
>
> When a BUG() is inside an inline function which is used in an exit path,
> it becomes non-trivial to eliminate. ?That means there will be hidden
> BUG() instances and we really can't ask people to avoid inline functions.
>

You mean that the BUG() call is not obvious. However, it can be found,
if necessary by inspection of assembler output :-) An easy workaround
is to put that code into a non-__exit function and call it from the
__exit function. If we enforced that then I think it would be one
solution to the problem. Given the tiny size of exit code in the
kernel it can be hoped that the impact would be minimal. My main
concern with this approach is that it introduces a build problem which
will only occur on some machines and builds, which can be painful.

Sorry if I restate the obvious, but with generic BUG patch, BUG inside
an inline function (or anywhere else) just becomes an undef
instruction. There is no function call. The only reason we have a
problem at all is that we want to eliminate the code section
containing this undef instruction, but every one of these instructions
also creates an entry in the bug table (which exists in its own
separate section), and we cannot selectively eliminate those entries
in the linker. Specifically there is an entry which points to the PC
of the undef instruction. If this could be made a weak reference then
perhaps it might fix things.

It is easy enough for the handler to just not report the information
if it doesn't have it. This is hypothetical anyway since if you are
eliminating exit code it is presumably because you will never exit.

Hmm even more out there, I wonder if we can modify the BUG macro to
put the bug table entry into one of two separate depending on whether
BUG is in an __exit function or not? Then at link time, either concat
the two tables, or just ignore the exit one...

In any case, it sounds from the next email in this thread that your
patch has fixed the problem! So, where does that leave us?

Regards,
Simon
