From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2017 12:24:07 +0000
Subject: [PATCH] mm: free reserved area's memmap if possiable
In-Reply-To: <20170213121659.GM1512@arm.com>
References: <1486987349-58711-1-git-send-email-zhouxianrong@huawei.com>
 <20170213121659.GM1512@arm.com>
Message-ID: <20170213122407.GX27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 12:17:00PM +0000, Will Deacon wrote:
> Adding linux-arm-kernel and devicetree (look for "raw-pfn"), since this
> impacts directly on those.
> 
> On Mon, Feb 13, 2017 at 08:02:29PM +0800, zhouxianrong at huawei.com wrote:
> > From: zhouxianrong <zhouxianrong@huawei.com>
> > 
> > just like freeing no-map area's memmap we could free reserved
> > area's memmap as well only when user of reserved area indicate
> > that we can do this in dts or drivers. that is, user of reserved
> > area know how to use the reserved area who could not memblock_free
> > or free_reserved_xxx the reserved area and regard the area as raw
> > pfn usage. the patch supply a way to users who want to utilize the
> > memmap memory corresponding to raw pfn reserved areas as many as
> > possible.
> 
> I don't really understand this. Can you point me at a specific use-case,
> please? Is CMA involved here?

You don't need "dt permission" to free the memmap page array for the
regions between memory areas.  In fact, adding a DT property for that
goes against the "DT describes the hardware not the implementation"
requirement, since the memmap page array is a Linux implementation
detail.

32-bit ARM has been freeing the memmap page array between memory areas
for years since pre-DT days, and continues to do so.  See
free_unused_memmap().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
