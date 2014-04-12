From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Apr 2014 09:46:30 +0100
Subject: commit b3a977b224 {ARM: Better virt_to_page() handling} breaks
 Keystone boot
In-Reply-To: <534893F8.30309@ti.com>
References: <53487A9E.70805@ti.com>
 <alpine.LFD.2.11.1404112011320.980@knanqh.ubzr>
 <20140412002401.GS16119@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1404112036470.980@knanqh.ubzr> <534893F8.30309@ti.com>
Message-ID: <20140412084630.GT16119@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 09:16:40PM -0400, Santosh Shilimkar wrote:
> +	if (mem_start < KEYSTONE_HIGH_PHYS_START ||
> +	    mem_end   > KEYSTONE_HIGH_PHYS_END) {
> +		pr_crit("Invalid address space for memory (%08llx-%08llx)\n",
> +		      (u64)mem_start, (u64)mem_end);
> +	}
> +
> +	offset += KEYSTONE_HIGH_PHYS_START;
> +	__pv_phys_offset = offset;

Right, so this will create a link error, and needs to become:

	__pv_phys_pfn_offset = offset >> PAGE_SHIFT;

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
