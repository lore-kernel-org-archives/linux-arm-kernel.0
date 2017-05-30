From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 May 2017 11:10:28 -0700
Subject: [PATCHv3b 4/5] ARM: OMAP4: cminst: add support for
 clkdm_xlate_address
In-Reply-To: <1496155669-1677-5-git-send-email-t-kristo@ti.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
 <1496155669-1677-5-git-send-email-t-kristo@ti.com>
Message-ID: <20170530181028.GA3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Tero Kristo <t-kristo@ti.com> [170530 07:51]:
> This function gets the physical base address of a clockdomain.
..
> +static u32 omap4_clkdm_xlate_address(struct clockdomain *clkdm)
> +{
> +	u32 addr = (u32)_cm_bases[clkdm->prcm_partition] - OMAP2_L4_IO_OFFSET +
> +		clkdm->cm_inst + clkdm->clkdm_offs;
> +
> +	return addr;
> +}
> +

Hmm this will be flakey as it assumes fixed mappings
for all these which we do not have on all SoCs.

It would be best to pass the domain bases around as
struct resource then just ioremap locally.

It might be enough if we changed _cm_bases[] locally
to be an array of:

struct omap_domain_base {
       struct resource res;
       void __iomem *va;
};

Or do you have better ideas?

Regards,

Tony
