From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Apr 2015 20:19:26 +0100
Subject: [PATCH 2/6] ARM: keystone2: move update of the phys-to-virt
 constants into generic code
In-Reply-To: <552541B1.2000501@linaro.org>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmXq-0006Wr-M7@rmk-PC.arm.linux.org.uk>
 <552541B1.2000501@linaro.org>
Message-ID: <20150408191926.GS12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 05:56:49PM +0300, Grygorii.Strashko at linaro.org wrote:
> > +
> > +	/* Re-set the phys pfn offset, and the pv offset */
> > +	__pv_offset = PHYS_OFFSET + offset - PAGE_OFFSET;
> 
> So, here now:
> 
> __pv_offset = 0x8000 0000 + 0x7 8000 0000 - 0xC000 0000;
> 
> __pv_offset == 0x8 0000 0000 (KEYSTONE_HIGH_PHYS_START) - 0xC000 0000
> 
> code if offset will eq (new)PHYS_OFFSET == KEYSTONE_HIGH_PHYS_START:
> 
>   __pv_offset = offset - PAGE_OFFSET;

BTW, this could simply be changed to:

	__pv_offset += offset;

keeping the existing "delta" implementation.

> > +	__pv_phys_pfn_offset = PFN_DOWN(PHYS_OFFSET + offset);

and this to:

	__pv_phys_pfn_offset += PFN_DOWN(offset);

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
