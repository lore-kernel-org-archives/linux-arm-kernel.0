From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Nov 2015 00:21:13 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <4519802.lamVCN5F0B@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <yw1x4mgfc89z.fsf@unicorn.mansr.com> <4519802.lamVCN5F0B@wuerfel>
Message-ID: <12750898.0A5czJmNqv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 November 2015 00:14:14 Arnd Bergmann wrote:
> On Saturday 21 November 2015 22:11:36 M?ns Rullg?rd wrote:
> > Arnd Bergmann <arnd@arndb.de> writes:
> > > On Saturday 21 November 2015 20:45:38 M?ns Rullg?rd wrote:
> > >> On 21 November 2015 20:39:58 GMT+00:00, Arnd Bergmann <arnd@arndb.de> wrote:
> > >> 
> > >> The ARM ARM says anything with virt has idiv, lpae doesn't matter.
> > >
> > > Ok, and anything with virt also has lpae by definition. The question is
> > > whether we care about using idiv on cores that do not have lpae, or that
> > > have neither lpae nor virt.
> > 
> > The question is, are there any such cores?  GCC doesn't know of any, but
> > then it's missing most non-ARM designs.
> 
> Exactly. Stephen should be able to find out about the Qualcomm cores,
> and http://comments.gmane.org/gmane.linux.ports.arm.kernel/426289 has
> some information about the others:
>  * Brahma-B15 supports all three.
>  * Dove (PJ4) reports idiv only in thumb mode, which I'm tempted to ignore
>    for the kernel, as it supports neither lpae nor idiva.
>  * Armada 370/XP (PJ4B) reports support for idiva and idivt, but according to
>    https://groups.google.com/a/dartlang.org/forum/#!topic/reviews/9wvsJvq0YYY
>    that may be a lie.
>  * According to the same source, Krait fails to report idiva and idivt,
>    but supports both anyway. However, I found reports on the web where
>    /proc/cpuinfo correctly contains the flags on the same SoC (APQ8064)
>    that was mentioned there, so maybe they were just running an old
>    kernel.

This has some more information: 

commit 120ecfafabec382c4feb79ff159ef42a39b6d33b
Author: Stepan Moskovchenko <stepanm@codeaurora.org>
Date:   Mon Mar 18 19:44:16 2013 +0100

    ARM: 7678/1: Work around faulty ISAR0 register in some Krait CPUs
    
    Some early versions of the Krait CPU design incorrectly indicate
    that they only support the UDIV and SDIV instructions in Thumb
    mode when they actually support them in ARM and Thumb mode. It
    seems that these CPUs follow the DDI0406B ARM ARM which has two
    possible values for the divide instructions field, instead of the
    DDI0406C document which has three possible values.
    
    Work around this problem by checking the MIDR against Krait CPUs
    with this faulty ISAR0 register and force the hwcaps to indicate
    support in both modes.
    
    [sboyd: Rewrote commit text to reflect real reasoning now that
        we autodetect udiv/sdiv]
    
    Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
    Acked-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

so Krait clearly supports them, and this also explains why some
machines misreport it depending on the CPU version and kernel
release running on it.

Regarding PJ4, it's still unclear whether that has the same
problem and it only reports idivt when it actually supports idiva,
or whether the lack of idiva support on PJ4 is instead the reason
why the ARM ARM was updated to have separate flags.

	Arnd
