From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jul 2014 11:48:16 +0200
Subject: CPU1 fails to boot on Armada 375 DB with 3.16.0-rc6
In-Reply-To: <53D6F564.5070803@opengear.com>
References: <53D6F564.5070803@opengear.com>
Message-ID: <20140729114816.72bb556d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ken Wilson,

On Tue, 29 Jul 2014 11:14:12 +1000, Ken Wilson wrote:
> Hi Thomas,

Hello. Please Cc: me next time if you want to reply.

> We're running 3.16.0-rc6 on our Rev 2 Armada 375 DB, and we've found 
> that the second CPU is not coming up.
> Are there any known issues here?

Yes, issue known.

> Booting CPU 1
> CPU1: failed to come online
> Brought up 1 CPUs
> SMP: Total of 1 processors activated.
> CPU: All CPU(s) started in SVC mode.

This is caused by a bug in Marvell's bootloader, which has been fixed
by them since then, but I'm not sure the fix is already part of a
released version of their U-Boot. If you're interested, I can provide
you with the U-Boot patches, or if you want a kernel-only hack to fix
the problem, apply this patch:

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 2c35f0f..87f6c2e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -506,6 +506,7 @@ __fixup_smp:
 	@ below address check will need to be #ifdef'd or equivalent
 	@ for the Aegis platform.
 	mrc	p15, 4, r0, c15, c0	@ get SCU base address
+	ldr	r0, =0xf100c000
 	teq	r0, #0x0		@ '0' on actual UP A9 hardware
 	beq	__fixup_smp_on_up	@ So its an A9 UP
 	ldr	r0, [r0, #4]		@ read SCU Config

It basically overrides the SCU address read from the CP15 register,
which the Marvell U-Boot fails to update after changing the internal
register base address.

Let me know if that fix the problem for you. Of course, the above hack
is not upstreamable, and not meant to be upstreamed in any way.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
