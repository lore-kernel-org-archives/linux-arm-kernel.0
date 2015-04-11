From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Apr 2015 08:52:20 +0100
Subject: [RESEND][PATCH] ARM errata, 430973: update the affected revisions
In-Reply-To: <552840A9.8070406@myspectrum.nl>
References: <1418131842-6752-1-git-send-email-jhofstee@victronenergy.com>
 <54EE2453.9080301@myspectrum.nl> <552840A9.8070406@myspectrum.nl>
Message-ID: <20150411075220.GK12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:29:13PM +0200, Jeroen Hofstee wrote:
> Hi again,
> 
> On 25-02-15 20:36, Jeroen Hofstee wrote:
> >Hi,
> >
> >On 09-12-14 14:30, Jeroen Hofstee wrote:
> >>From: Jeroen Hofstee <linux-arm@myspectrum.nl>
> >>
> >>Update the list of revisions subject to this errata.
> >>
> >>Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> >>Cc: Andreas Bie?mann <andreas.devel@googlemail.com>
> >>Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> >>---
> >>I don't have access to the AT400/AT401/AT490 document, but
> >>Andreas was kind enough to provide this information, see
> >>https://www.mail-archive.com/u-boot at lists.denx.de/msg156620.html
> >>
> >>Resending from an address which is subscribed to the ML...
> >>---
> >>  arch/arm/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>index 89c4b5c..a2202fa 100644
> >>--- a/arch/arm/Kconfig
> >>+++ b/arch/arm/Kconfig
> >>@@ -1063,7 +1063,7 @@ config ARM_ERRATA_430973
> >>      depends on CPU_V7
> >>      help
> >>        This option enables the workaround for the 430973 Cortex-A8
> >>-      (r1p0..r1p2) erratum. If a code sequence containing an ARM/Thumb
> >>+      (r1p0..r1p3, r1p7) erratum. If a code sequence containing an
> >>ARM/Thumb
> >>        interworking branch is replaced with another code sequence at
> >>the
> >>        same virtual address, whether due to self-modifying code or
> >>virtual
> >>        to physical address re-mapping, Cortex-A8 does not recover from
> >>the
> >
> >It seems this is not applied yet. For completeness, this only updates the
> >description
> >of the workaround, so should be safe to apply. At the moment people might
> >disable
> >this workaround (since the description says its not applicable) even if
> >the cpu does
> >need this workaround.
> >
> >Please consider applying this,
> >
> 
> ping
> 
> This still seems not be be applied. Please do update the documentation
> because it
> causes segfaults when disabled wrongly. Below is a discussion about the
> topic as well.

No.  If you read the discussion that the OMAP people are having, it is
unclear whether r3p2 is actually affected by this errata or not.

In the discussion with OMAP people, we've come up with a potentially
better solution to this, which is to rearrange the code so that only
Cortex-A8 executes this workaround, and the BTB flush is always
present (which Tony says fixes the problem.)

However, due to the lack of audience participation in that thread,
Tony's patch to do the last bit is still sitting around.  I quote
from April 8th:

  "Boots just fine for me on n900, but let's wait for comments
  from Sebastian."

and we're doing just that, we're waiting...

Meanwhile, OMAP people are seeing about updating uboot to set/clear
the auxiliary control register bit appropriately for the revision of
the core.

In any case, adding the patch and suggesting people enable this for
more Cortex-A8's (eg, non-OMAP) won't actually do anything in a
multiplatform kernel.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
