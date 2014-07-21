From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jul 2014 17:46:34 +0100
Subject: [PATCH RFC 5/9] ARM: Add L1 PTE non-secure mapping
In-Reply-To: <1405954040-30399-6-git-send-email-daniel.thompson@linaro.org>
References: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
 <1405954040-30399-6-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140721164634.GF21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 03:47:16PM +0100, Daniel Thompson wrote:
> From: Marek Vasut <marex@denx.de>
> 
> Add new device type, MT_DEVICE_NS. This type sets the NS bit in L1 PTE [1].
> Accesses to a memory region which is mapped this way generate non-secure
> access to that memory area. One must be careful here, since the NS bit is
> only available in L1 PTE, therefore when creating the mapping, the mapping
> must be at least 1 MiB big and must be aligned to 1 MiB. If that condition
> was false, the kernel would use regular L2 page mapping for this area instead
> and the NS bit setting would be ineffective.

Right, so this says that PTE mappings are not permissible.

> +	[MT_DEVICE_NS] = {	  /* Non-secure accesses from secure mode */
> +		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_SHARED |
> +				  L_PTE_SHARED,
> +		.prot_l1	= PMD_TYPE_TABLE,

However, by filling in prot_pte and prot_l1, you're telling the code that
it /can/ setup such a mapping.  This is screwed.

If you want to deny anything but section mappings (because they don't work)
then you omit prot_pte and prot_l1.  With those omitted, if someone tries
to abuse this mapping type, then this check in create_mapping() will
trigger:

        if (type->prot_l1 == 0 && ((addr | phys | length) & ~SECTION_MASK)) {
                printk(KERN_WARNING "BUG: map for 0x%08llx at 0x%08lx can not "
                       "be mapped using pages, ignoring.\n",
                       (long long)__pfn_to_phys(md->pfn), addr);
                return;
        }

ioremap doesn't have that check; it assumes that it will always be setting
up PTE mappings via ioremap_page_range().  In fact, on many platforms
that's the only option.

So making this interface available via ioremap() seems pointless - but
more importantly it's extremely error-prone.  So, MT_DEVICE_NS shouldn't
be using 4 at all, shouldn't be in asm/io.h, but should be with the
private MT_* definitions in map.h.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
