From: nm@ti.com (Nishanth Menon)
Date: Thu, 7 Oct 2010 14:50:13 -0500
Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
	read/write
In-Reply-To: <20101007185630.GA26435@n2100.arm.linux.org.uk>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	<1285063280-4057-10-git-send-email-manjugk@ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
	<20101007185630.GA26435@n2100.arm.linux.org.uk>
Message-ID: <4CAE2475.4090607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux had written, on 10/07/2010 01:56 PM, the following:
> On Thu, Oct 07, 2010 at 07:17:08AM -0500, Menon, Nishanth wrote:
>>> -----Original Message-----
>>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>>> owner at vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
>>> Sent: Tuesday, September 21, 2010 5:01 AM
>>> To: linux-omap at vger.kernel.org
>>> Cc: linux-arm-kernel at lists.infradead.org; linux-mtd at lists.infradead.org
>>> Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
>>> read/write
>>>
>>> Following sparse warnings exists due to use of writel/w and readl/w
>>> functions.
>>>
>>> This patch fixes the sparse warnings by converting readl/w functions usage
>>> into
>>> __raw_readl/__raw_readw functions.
>> Apologies on bringing up an old topic here -> Is'nt it better to fix
>> readl/w or writel/w than replacing it with __raw_readl/w etc?
> 
> No.  If you're getting sparse warnings its because _you_ are using
> readl/writel wrongly.
> 
> They take a void __iomem pointer, not a u32, unsigned long, int, or
> even a void pointer.
void __iomem *p;
...

readl(p);

unrolls to:
({ u32 __v = ({ u32 __v = (( __u32)(__le32)(( __le32) ((void)0, 
*(volatile unsigned int *)((p))))); __v; }); __asm__ __volatile__ ("mcr 
p15,
, %0, c7, c10, 5" : : "r" (0) : "memory"); __v; });

({ u32 __v = ({ u32 __v

seems to be the obvious cause of sparse warnings such as that attempted 
to be fixed in [1]

  warning: symbol '__v' shadows an earlier one

my comment being that by moving {read,write}[wlb] to __raw versions dont 
solve the real issue of namespace here. fix should be in 
arch/arm/include/asm/io.h IMHO. so that there are no overlaps as this.

[1]http://marc.info/?l=linux-omap&m=128506333803725&w=2

-- 
Regards,
Nishanth Menon
