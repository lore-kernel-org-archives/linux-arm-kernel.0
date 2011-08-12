From: lacombar@gmail.com (Arnaud Lacombe)
Date: Fri, 12 Aug 2011 17:41:42 -0400
Subject: [PATCH] ARM: zImage: Skip relinking if nothing changes
In-Reply-To: <20110812205520.GL4775@n2100.arm.linux.org.uk>
References: <4E457682.5020107@codeaurora.org>
	<1313175602-21834-1-git-send-email-sboyd@codeaurora.org>
	<CACqU3MUq5M-XPOxV=8GKyEzjEzpmdeaF+mGrXJrK+ZZxa4SdeQ@mail.gmail.com>
	<20110812205520.GL4775@n2100.arm.linux.org.uk>
Message-ID: <CACqU3MX=-10ouxCqWcBP7MW3_O4_RSLG9wRY8X4iEh5ydQa1AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 12, 2011 at 4:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Aug 12, 2011 at 04:48:12PM -0400, Arnaud Lacombe wrote:
>> You should be able to avoid the extra copy altogether by doing something ala:
>>
>> $(obj)/lib1funcs.o: $(srctree)/arch/arm/lib/lib1funcs.S
>> ? ? ? ? $(call cmd,as_o_S)
>>
>> note that I also remove the $(SRCARCH), as there is no other
>> `arch/*/lib/lib1funcs.S' than `arch/arm/lib/lib1funcs.S'
>
> We tried such things, but it results in kbuild arguing over building
> lib1funcs.S in arch/arm/lib and arch/arm/boot/compressed. ?You end up
> with it rebuilding the arch/arm/lib one, followed by a rebuild of the
> arch/arm/boot/compressed one.
>
hum... I tried this approach on a reduced testcase with an object in
arch/x86/boot/ using a prerequisite in arch/x86/lib/ and it seemed to
behave as I would expect. From what I can find online, this comes from
http://lkml.org/lkml/2009/11/13/246. Albin's original is broken
because it refers to object in the source tree. I suspect Martin's
change to work only because he had a stale
`arch/$(SRCARCH)/lib/lib1funcs.o' in his tree. Sebastian's change is
broken because he was badly using $(obj), he should have used
$(objtree). All case are otherwise broken because of
cross-subdirectory object dependency do not work.

The commit I think you refer to should be:

commit 4486b86368d72bcac76439638b36667b1c6a1360
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Sun Jun 3 18:54:42 2007 +0100

    [ARM] riscpc: fix decompressor font file handling

    font_acorn_8x8.o was being built in drivers/video/console/ twice
    during a build _in the same location_ - once for the kernel proper,
    and once for the decompressor.  The result is when you came to run an
    install target, the kernel was always rebuilt due to this file
    apparantly having been built with different compiler arguments.

    Solve this by making a local copy at build time in the decompressor's
    directory.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I suspect this would have done the job:

$(obj)/font.o: $(srctree)/drivers/video/console/font_acorn_8x8.c
        $(cmd,cc_o_c)

rather than abusing `cmd_shipped'. font.o would not have been built
twice in the _same_ location, but respectively in
`drivers/video/console/font_acorn_8x8.o' and
`arch/arm/boot/compressed/font.o'

 - Arnaud

> We've ended up with what we have because its about the only way to get
> kbuild to behave.
>
