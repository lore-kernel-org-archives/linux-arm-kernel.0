From: dhobsong@igel.co.jp (Damian Hobson-Garcia)
Date: Thu, 30 Aug 2012 11:03:43 +0900
Subject: [PATCH 0/2] Renesas IPMMU driver for sh7372
In-Reply-To: <20120825071344.GI29755@verge.net.au>
References: <1343197742-13630-1-git-send-email-hdk@igel.co.jp>
 <20120825071344.GI29755@verge.net.au>
Message-ID: <503EC9FF.1090100@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 2012/08/25 16:13, Simon Horman wrote:
> On Wed, Jul 25, 2012 at 03:29:00PM +0900, Hideki EIRAKU wrote:
>> This is the Renesas IPMMU driver, IOMMU API implementation and IPMMU
>> device support for sh7372 (AP4EVB and Mackerel).
>>
>> The IPMMU module supports the MMU function and the PMB function.  The
>> MMU function provides address translation by pagetable compatible with
>> ARMv6.  The PMB function provides address translation including
>> tile-linear translation.  This is implementation of the MMU function.
> 
> Hi,
> 
> I am wondering if anyone has had a chance to review this short series.
> It seems reasonable to me with the minor exception that I would
> be happier the second patch to update the relevant defconfigs
> to either enable or disable the driver.
> 
> I am also curious to know how this driver may be tested.

Since this patch series configures the LCDC, and CEU to use the IPMMU,
checking the memory addresses that those blocks are using are properly
registered in the IPMMU, and verifying that they actually function seems
like the best way to test this driver. I'll take a look at doing that.

That said, there currently isn't any way to use this with UIO devices,
since enabling the IPMMU with break direct accesses to physical memory
from all of the IP blocks on the ICB (LCDC, CEU, VPU, VEU, etc.)
For these devices, memory allocated with the dma-mapping API *must* be
used with IPMMU enabled.  The current uio_pdrv_genirq driver isn't set
up to deal with this right now.

Damian
