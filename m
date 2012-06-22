From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jun 2012 16:40:17 +0000
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120622140210.GA32097@avionic-0098.mockup.avionic-design.de>
References: <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
 <201206221348.39346.arnd@arndb.de>
 <20120622140210.GA32097@avionic-0098.mockup.avionic-design.de>
Message-ID: <201206221640.18014.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 June 2012, Thierry Reding wrote:
> Actually this is from of_translate_address(). The calling sequence looks
> like this:
> 
>         of_address_to_resource()
>           __of_address_to_resource()
>             of_translate_address()
>               __of_translate_address()
>                 of_translate_one()
>                   of_bus_default_map()
>                     of_read_number()

Ok, I see.

This looks like a problem in of_bus_default_map, which expects to
see only 64 bit addresses at most. of_bus_pci_map by comparison
handles the pci addresses with three cells.

If I read this correctly, this fix is to make sure we compare the
upper cells of the address in of_bus_default_map:

static u64 of_bus_default_map(u32 *addr, const __be32 *range,
                int na, int ns, int pna)
{
        u64 cp, s, da;

        cp = of_read_number(range, na);
        s  = of_read_number(range + na + pna, ns);
        da = of_read_number(addr, na);

        pr_debug("OF: default map, cp=%llx, s=%llx, da=%llx\n",
                 (unsigned long long)cp, (unsigned long long)s,
                 (unsigned long long)da);

        if (da < cp || da >= (cp + s))
                return OF_BAD_ADDR;
        return da - cp;
}

How about adding code like:

	if ((na > 2) && memcmp(range, addr, na * 4) != 0)
		return OF_BAD_ADDR;

This won't handle entries with #size-cells>2 or those that
span a 64-bit boundary, but I think it will work for all
relevant cases.

	Arnd
