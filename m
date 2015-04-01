From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Apr 2015 18:00:33 +0100
Subject: [PATCH v1] ata: ahci_xgene: Add AHCI Support for second
 generation of APM X-Gene SoC
In-Reply-To: <20150401163956.GE24899@n2100.arm.linux.org.uk>
References: <1427899682-10912-1-git-send-email-stripathi@apm.com>
 <1427899682-10912-2-git-send-email-stripathi@apm.com>
 <20150401161336.GS9974@htj.duckdns.org>
 <20150401163116.GT9974@htj.duckdns.org>
 <20150401163956.GE24899@n2100.arm.linux.org.uk>
Message-ID: <20150401170032.GC28616@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 05:39:56PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 01, 2015 at 12:31:16PM -0400, Tejun Heo wrote:
> > On Wed, Apr 01, 2015 at 12:13:36PM -0400, Tejun Heo wrote:
> > > > Signed-off-by : Suman Tripathi <stripathi@apm.com>
> > > 
> > > Applied to libata/for-4.1 w/ minor edit.
> > 
> > Reverted due to build failure from missing asm/cputype.h.
> 
> I'm guessing this is some kind of ARM driver, which is why
> linux-arm-kernel has been Cc'd - though I haven't seen the original
> patch.
> 
> ARM has asm/cputype.h, and has had for a long time, so "missing
> asm/cputype.h" doesn't make sense as a reason to revert it.  Maybe
> it's trying to be built on x86 when it should be restricted to
> only ARM?
> 
> Dunno without seeing the original patch.

First search result leads here:

https://www.mail-archive.com/devicetree at vger.kernel.org/msg67774.html

The driver in general should not be ARM specific, though it runs on an
ARMv8 platform. But looking at the patch it has some errata workarounds
triggered based on the CPU id (MIDR). That looks dodgy as it doesn't
even check the full ID, only the variant part.

But if they don't have any other way of identifying the hardware
version (ideally some SoC or device identification), the driver should
at least be made dependent on ARM64. Looking at the Kconfig entries,
PHY_XGENE depends on (ARM64 || COMPILE_TEST). The COMPILE_TEST part
should be dropped (I would still prefer a different way to handle this
than checking MIDR but I'm not familiar with the hardware).

-- 
Catalin
