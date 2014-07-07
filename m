From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Jul 2014 08:51:41 +0200
Subject: [PATCH 3/3] ARM: only select ARM_PATCH_PHYS_VIRT if MMU is enabled
In-Reply-To: <20140702103512.GG32514@n2100.arm.linux.org.uk>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1404295043-6661-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140702103512.GG32514@n2100.arm.linux.org.uk>
Message-ID: <20140707065141.GC7827@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

(adding Yann and linux-kbuild to recipents)

On Wed, Jul 02, 2014 at 11:35:12AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 02, 2014 at 11:57:23AM +0200, Uwe Kleine-K?nig wrote:
> > This fixes the following warning:
> > 
> > 	warning: (ARCH_MULTIPLATFORM && ARCH_INTEGRATOR && ARCH_SHMOBILE_LEGACY) selects ARM_PATCH_PHYS_VIRT which has unmet direct dependencies (!XIP_KERNEL && MMU && (!ARCH_REALVIEW || !SPARSEMEM))
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > I'm not sure why ARCH_MULTIPLATFORM appears here. It depends on MMU,
> > isn't selectable at the same time as ARCH_REALVIEW and XIP_KERNEL
> > depends on !ARCH_MULTIPLATFORM.
> 
> The message is extremely confusing.  It would read better if those
> && were || - because ARM_PATCH_PHYS_VIRT is selected by
> ARCH_MULTIPLATFORM _or_ ARCH_INTEGRATOR _or_ ARCH_SHMOBILE_LEGACY:
right, so there are two things that could be improved here. The
resolution I'd prefer is to make this two warnings:

   ARCH_INTEGRATOR selects ARM_PATCH_PHYS_VIRT which has unmet direct dependencies (!XIP_KERNEL && MMU)
   ARCH_SHMOBILE_LEGACY selects ARM_PATCH_PHYS_VIRT which has unmet direct dependencies (!XIP_KERNEL && MMU)

ARCH_REALVIEW cannot be selected at the same time as ARCH_INTEGRATOR or
ARCH_SHMOBILE_LEGACY, so that can be dropped. And as stated above
ARCH_MULTIPLATFORM isn't an issue.

This doesn't have the natural language problem that ARCH_MULTIPLATFORM
*and* ARCH_INTEGRATOR *and* ARCH_SHMOBILE_LEGACY all select
ARM_PATCH_PHYS_VIRT.

> config ARCH_MULTIPLATFORM
>         select ARM_PATCH_PHYS_VIRT
> 
> config ARCH_INTEGRATOR
>         select ARM_PATCH_PHYS_VIRT
> 
> config ARCH_SHMOBILE_LEGACY
>         select ARM_PATCH_PHYS_VIRT
> 
(For reference, the patch did:

	-       select ARM_PATCH_PHYS_VIRT
	+       select ARM_PATCH_PHYS_VIRT if MMU

for ARCH_INTEGRATOR and ARCH_SHMOBILE_LEGACY)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
