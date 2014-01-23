From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Jan 2014 19:31:37 +0000
Subject: [PATCH 3/3] ARM: allow kernel to be loaded in middle of phymem
In-Reply-To: <alpine.LFD.2.11.1401231357520.1652@knanqh.ubzr>
References: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>
 <1390389916-8711-4-git-send-email-wangnan0@huawei.com>
 <alpine.LFD.2.11.1401231357520.1652@knanqh.ubzr>
Message-ID: <20140123193137.GA15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 02:15:07PM -0500, Nicolas Pitre wrote:
> On Wed, 22 Jan 2014, Wang Nan wrote:
> 
> > This patch allows the kernel to be loaded at the middle of kernel awared
> > physical memory. Before this patch, users must use mem= or device tree to cheat
> > kernel about the start address of physical memory.
> > 
> > This feature is useful in some special cases, for example, building a crash
> > dump kernel. Without it, kernel command line, atag and devicetree must be
> > adjusted carefully, sometimes is impossible.
> 
> With CONFIG_PATCH_PHYS_VIRT the value for PHYS_OFFSET is determined 
> dynamically by rounding down the kernel image start address to the 
> previous 16MB boundary.  In the case of a crash kernel, this might be 
> cleaner to simply readjust __pv_phys_offset during early boot and call 
> fixup_pv_table(), and then reserve away the memory from the previous 
> kernel.  That will let you access that memory directly (with gdb for 
> example) and no pointer address translation will be required.

We already have support in the kernel to ignore memory below the calculated
PHYS_OFFSET.  See 571b14375019c3a66ef70d4d4a7083f4238aca30.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
