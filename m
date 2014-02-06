From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Feb 2014 18:41:53 +0000
Subject: [PATCH] ARM: mm: Fix the memblock allocation for LPAE machines
In-Reply-To: <52F2DC6F.8070005@ti.com>
References: <1391285687-20534-1-git-send-email-santosh.shilimkar@ti.com>
 <52F2CBC0.3030305@ti.com> <20140205234815.GU26684@n2100.arm.linux.org.uk>
 <52F2DC6F.8070005@ti.com>
Message-ID: <20140206184153.GV26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 07:50:55PM -0500, Santosh Shilimkar wrote:
> On Wednesday 05 February 2014 06:48 PM, Russell King - ARM Linux wrote:
> > On Wed, Feb 05, 2014 at 06:39:44PM -0500, Santosh Shilimkar wrote:
> >> Russell,
> >>
> >> On Saturday 01 February 2014 03:14 PM, Santosh Shilimkar wrote:
> >>> Commit ad6492b8 added much needed memblock_virt_alloc_low() and further
> >>> commit 07bacb3 {memblock, bootmem: restore goal for alloc_low} fixed the
> >>> issue with low memory limit thansk to Yinghai. But even after all these fixes,
> >>> there is still one case where the limit check done with ARCH_LOW_ADDRESS_LIMIT
> >>> for low memory fails. Russell pointed out the issue with 32 bit LPAE machines
> >>> in below thread.
> >>> 	https://lkml.org/lkml/2014/1/28/364
> >>>
> >>> Since on some LPAE machines where memory start address is beyond 4GB,
> >>> the low memory marker in memblock will be set to default
> >>> ARCH_LOW_ADDRESS_LIMIT which is wrong. We can fix this by letting
> >>> architectures set the ARCH_LOW_ADDRESS_LIMIT using another export
> >>> similar to memblock_set_current_limit() but am not sure whether
> >>> its worth the trouble. Tell me if you think otherwise.
> >>>
> >>> Rather am just trying to fix that one broken case using memblock_virt_alloc()
> >>> in setup code since the memblock.current_limit is updated appropriately
> >>> makes it work on all ARM 32 bit machines.
> >>>
> >>> Cc: Yinghai Lu <yinghai@kernel.org>
> >>> Cc: Russell King <linux@arm.linux.org.uk>
> >>> Cc: Strashko, Grygorii <grygorii.strashko@ti.com>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>> ---
> >> Whats you say here ? We should get the fix for the
> >> issue. If you are ok, I can drop the patch in patch system.
> > 
> > Is this still an issue, or has Tejun fixed it by some other means?  I've not
> > noticed anything being broken at the moment.
> > 
> > Can you confirm whether we still have an issue without this patch please?
> > 
> Fixes for all cases exist except 'LPAE + memory start beyond 4 GB'.
> This case is still broken and  hence I posted the $subject patch.

Okay.  Patch system please then.  Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
