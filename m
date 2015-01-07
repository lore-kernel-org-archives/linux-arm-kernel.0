From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 7 Jan 2015 18:58:24 +0800
Subject: [PATCH] arm64: mm: support instruction SETEND
In-Reply-To: <54AD061A.6090602@arm.com>
References: <1420609930-1689-1-git-send-email-leo.yan@linaro.org>
 <54AD061A.6090602@arm.com>
Message-ID: <20150107105824.GA13620@leoy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 10:10:34AM +0000, Suzuki K. Poulose wrote:
> On 07/01/15 05:52, Leo Yan wrote:
> >Currently kernel has set the bit SCTLR_EL1.SED, so the SETEND
> >instruction will be treated as UNALLOCATED; this error can be
> >reproduced when ARMv8 cpu runs with EL1/aarch64 and EL0/aarch32
> >mode, finally kernel will trap the exception if the userspace
> >libs use SETEND instruction.
> >
> >So this patch clears bit SCTLR_EL1.SED to support SETEND instruction.
> >
> The best way to do this, is via the instruction emulation framework
> added by Punit, which handles the armv8 deprecated/obsoleted
> instructions. This is now queued for 3.19.
> I have a patchset which adds the 'SETEND' emulation support to the
> framework. This will enable better handling of the feature,
> including finding out the users of the deprecated instruction (when
> we switch to the emulation mode).
> 

i'm a little confuse for this point:

if the deprecated instructions cannot be supported by CPU, then only
can use emulation; on the other hand, if CPU can natively support the
deprecated instruction, why we cannot directly enable this h/w feature?
if use the emulation mode, suppose here will have performance penalty.

how about u think for this? :-)

> >Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >Signed-off-by: Xiaolong Ye <yexl@marvell.com>
> >---
> >  arch/arm64/mm/proc.S | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> >index 4e778b1..66a7363 100644
> >--- a/arch/arm64/mm/proc.S
> >+++ b/arch/arm64/mm/proc.S
> >@@ -249,9 +249,9 @@ ENDPROC(__cpu_setup)
> >  	 *       CE0      XWHW CZ     ME TEEA S
> >  	 * .... .IEE .... NEAI TE.I ..AD DEN0 ACAM
> >  	 * 0011 0... 1101 ..0. ..0. 10.. .... .... < hardware reserved
> >-	 * .... .1.. .... 01.1 11.1 ..01 0001 1101 < software settings
> >+	 * .... .1.. .... 01.1 11.1 ..00 0001 1101 < software settings
> >  	 */
> >  	.type	crval, #object
> >  crval:
> >-	.word	0x000802e2			// clear
> >-	.word	0x0405d11d			// set
> >+	.word	0x000803e2			// clear
> >+	.word	0x0405d01d			// set
> >
> 
> 
