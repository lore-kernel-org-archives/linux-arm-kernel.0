From: sjg@chromium.org (Simon Glass)
Date: Thu, 10 Mar 2011 14:19:20 -0800
Subject: [RFC PATCH V2] ARM: Use generic BUG() handler
In-Reply-To: <AANLkTinTfHqrbVFh6Q68kP=UKJjye8J+iDhRHTcm8BPF@mail.gmail.com>
References: <1299639325-10384-1-git-send-email-sjg@chromium.org>
	<AANLkTinTfHqrbVFh6Q68kP=UKJjye8J+iDhRHTcm8BPF@mail.gmail.com>
Message-ID: <AANLkTinh4-rvhDGesy=STFsiLGyjBb8Scb+BR7tfXQ+G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2011 at 1:51 AM, Dave Martin <dave.martin@linaro.org> wrote:
> On Wed, Mar 9, 2011 at 2:55 AM, Simon Glass <sjg@chromium.org> wrote:
>> +#ifdef CONFIG_THUMB2_KERNEL
>> +#define BUG_INSTR_VALUE 0xf7f2
>
> This isn't an undefined instruction... it's actually half of some
> 32-bit Thumb instruction. Did you mean 0xdexx instead?

Yes, will fix.

>> +#define BUG_INSTR_TYPE ".hword "
>> +#else
>> +#define BUG_INSTR_VALUE 0xe7f001f2
>> +#define BUG_INSTR_TYPE ".word "
>> +#endif
>> +
>
> This works, but do we really need to split the definition of the bug
> instruction into two macros?

This is so that I can test for the correct instruction word in valid_bug_addr().

>
> Unless you can see a use for calling _BUG() directly with a different
> instruction value, of course...
>

>> + ? ? ? /*
>> + ? ? ? * .exit.text is discarded at runtime, not link time, to deal with
>> + ? ? ? * ?references from bug_table
>> + ? ? ? */
>> + ? ? ? .exit.text : AT(ADDR(.exit.text)) {
>> + ? ? ? ? ? ? ? EXIT_TEXT
>> + ? ? ? }
>> +
>> + ? ? ? .exit.data : AT(ADDR(.exit.data)) {
>> + ? ? ? ? ? ? ? EXIT_DATA
>> + ? ? ? }
>
> This is the same unfortunate hack we have to do for other fixups,
> because there's no way to separate out some of these entries in such a
> way that they can be discarded at link time... ?I did have an idea for
> an extention to gas which would allow fixups and similar data to be
> emitted in separate ancillary sections which the linker can handle
> sensibly, so that bug entries referencing .exit.text (for example) can
> be discarded at link time.
>
> See http://sourceware.org/ml/binutils/2011-02/msg00004.html
>
> I haven't received any support for the idea so far though...

Well yes, and some might even argue that calling BUG() in __exit code
is not a great idea. Here we are adding in all exit data again which
is about 8.5KB in my kernel. These two pages are then reclaimed at
runtime.

However, at present I don't see any alternative to this, and this is
what is done on other architectures to support BUG().

>
> Cheers
> ---Dave
>

I will tidy this up, test it properly on Thumb and submit a patch.

Regards,
Simon
