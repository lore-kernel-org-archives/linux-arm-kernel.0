From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Mar 2012 17:40:18 -0700 (MST)
Subject: [PATCHv5 2/6] ARM: OMAP3 PM: Move IO Daisychain function to
 omap3 prm file
In-Reply-To: <1331046702-2472-3-git-send-email-t-kristo@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
 <1331046702-2472-3-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1203091737390.30879@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc Rajendra

Hi Tero,

a few comments:

On Tue, 6 Mar 2012, Tero Kristo wrote:

...

> +/* OMAP3 Daisychain enable sequence */
> +void omap3_trigger_io_chain(void)
> +{
> +	int i = 0;
> +
> +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +				   PM_WKEN);
> +	/* Do a readback to assure write has been done */
> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);

Looks like this barrier shouldn't be needed?  The write is immediately 
followed by another read from the same IP block.

> +
> +	omap_test_timeout(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
> +			  OMAP3430_ST_IO_CHAIN_MASK,
> +			  MAX_IOPAD_LATCH_TIME, i);
> +
> +	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
> +				     PM_WKEN);
> +
> +	omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK, WKUP_MOD,
> +				     PM_WKST);
> +
> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST);
> +}

I see that you removed the second timeout test from this code, but not 
from the OMAP4 version.  Any reason why?  Seems like if the second timeout 
can be removed from one, then it can also be removed from the other?


- Paul
