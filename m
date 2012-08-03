From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Aug 2012 12:45:32 +0100
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <20120803090452.GE2626@pengutronix.de>
References: <20120803090452.GE2626@pengutronix.de>
Message-ID: <20120803114532.GB26925@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 03, 2012 at 10:04:52AM +0100, Uwe Kleine-K?nig wrote:
> Hello,

Hi Uwe,

> in both arch/arm/kernel/head.S and arch/arm/kernel/head-nommu.S we have
> 
> 	.arm
>  THUMB( adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
>  THUMB( bx      r9              )       @ If this is a Thumb-2 kernel,
>  THUMB( .thumb                  )       @ switch to Thumb now.
>  THUMB(1:                       )
> 
> as first instructions at the entry point. This is a problem for
> thumb2-only cpus (e.g. Cortex-M3).

Yup, Documentation/arm/Booting mentions this too.

> Up to now I commented out the first three lines for the Cortex-M3 port.
> What should we do about that. There are two possibilities I see:
> 
>  a) introduce a kconfig symbol for thumb2-only builds and #ifdef the
>     first three lines out if it is given.
>  b) expect the bootloader to directly jump to the label 1.
> 
> The downside of a) is that a boot loader on a cpu that is capable to
> execute the tradtional instructions would need to detect if the switch
> to thumb is there or not and react accordingly. (In fact it needs to
> distringuish three cases:
> 
>  - traditional kernel
>  - thumb2 kernel with ARM entry
>  - thumb2 kernel without ARM entry
> 
> .) So I think b) is the more sensible option in the long run.
> 
> What do you think?

How about something like:


diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 835898e..9f07be2 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -86,6 +86,7 @@
        __HEAD
 ENTRY(stext)
 
+ THUMB(        .inst   0xe200e004      )       @ ARM: and lr, r0, #4 T2: b 1f
  THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is always entered in ARM.
  THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
  THUMB(        .thumb                  )       @ switch to Thumb now.


[thanks to Leif Lindholm for doing this in one instruction]

Will
