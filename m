From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 29 Aug 2013 11:59:51 +0200
Subject: 3.11-rc7 big-endian support
In-Reply-To: <521D21D9.8020106@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <521D21D9.8020106@codethink.co.uk>
Message-ID: <20130829115951.4d6df89b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Tue, 27 Aug 2013 23:02:01 +0100, Ben Dooks wrote:
> On 27/08/13 22:38, Ben Dooks wrote:
> > This is a new series of the core work for getting big-endian working
> > nicely on ARM. This is mainly a rebase on 3.11-rc7 and has not had
> > a lot of testing on it.
> >
> > It is available on:
> >
> > 	git://git.baserock.org/delta/linux.git baserock/311-rc7/be/core-v1
> >
> > Since the previous version:
> >
> > - Added Victor's atomic64 patch
> > - Fixed BUG() patch to use<asm/opcodes.h>
> >
> > I would like to get as much of this merged as possible, so would
> > it be possible
> 
> Is it possible to get all or some of this series pulled before the
> next merge window? Do I need to remove the machine specific parts
> of the series?

I believe your patch series would get more attention if the cover
letter was a bit better. It lacks a version number and a changelog. The
new posting you made as "re-send patch series due to mta issues" does
not even have a cover letter.

Also, none of the patches are Cc'ed to the relevant maintainers, so I'm
not sure how you expect those maintainers to look at your patches?

Would it be possible to Cc me on future postings of this patch set?

Considering the Acked-by and Reviewed-by you had, I would suggest that
you push the following patches in Russell King's patch system:

 [PATCH 02/19] ARM: asm: Add ARM_BE8() assembly helper
 [PATCH 03/19] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
               (after adding Dave Martin Reviewed-by)
 [PATCH 04/19] ARM: set BE8 if LE in head code
               (after adding Dave Martin Reviewed-by and removing the
               merge line conflict)
 [PATCH 05/19] ARM: pl01x debug code endian fix
 [PATCH 06/19] ARM: twd: data endian fix
 [PATCH 07/19] ARM: smp_scu: data endian fixes
 [PATCH 11/19] ARM: alignment: correctly decode instructions in BE8 mode.
               (after adding Dave Martin Reviewed-by)
 [PATCH 12/19] ARM: traps: use <asm/opcodes.h> to get correct instruction order
               (after fixing the typo pointed by Dave Martin)
 [PATCH 13/19] ARM: module: correctly relocate instructions in BE8
               (after adding Dave Martin Reviewed-by)
 [PATCH 14/19] ARM: set --be8 when linking modules
               (after adding Dave Martin Reviewed-by)
 [PATCH 15/19] ARM: hardware: fix endian-ness in <hardware/coresight.h>
 [PATCH 16/19] ARM: net: fix arm instruction endian-ness in bpf_jit_32.c
               (after adding Dave Martin Reviewed-by)
 [PATCH 17/19] ARM: Correct BUG() assembly to ensure it is endian-agnostic
               (after adding Dave Martin Reviewed-by)
 [PATCH 18/19] ARM: kdgb: use <asm/opcodes.h> for data to be assembled as intruction
               (after adding Dave Martin Reviewed-by)
 [PATCH 19/19] ARM: atomic64: fix endian-ness in atomic.h

Considering the release timing, you should really submit those either
today or tomorrow into Russell's patch system if you want them to be
merged for 3.12.

Regarding mvebu, the below patch is needed to get the secondary CPUs to
boot. Other than that, on Armada XP:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

It doesn't work yet on Armada 370, but I'm not sure it's due to your
patches and anyway isn't a regression since LE continues to work fine
on Armada 370.

diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index 3109df0..be067b7 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -29,13 +29,13 @@
  * startup
  */
 ENTRY(armada_xp_secondary_startup)
+ARM_BE8(setend be )                    @ go BE8 if booted LE
+
        /* Get coherency fabric base physical address */
        adr     r0, 1f
        ldr     r1, [r0]
        ldr     r0, [r0, r1]
 
- ARM_BE8(setend        be )                    @ go BE8 if booted LE
-
        /* Read CPU id */
        mrc     p15, 0, r1, c0, c0, 5
        and     r1, r1, #0xF

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
