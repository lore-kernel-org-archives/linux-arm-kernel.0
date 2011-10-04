From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Oct 2011 11:54:15 -0700
Subject: [PATCH 1/4] ARM: OMAP3 PM: Fix IO Daisychain sequence
In-Reply-To: <1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
	<1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
Message-ID: <20111004185415.GV6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vishwanath BS <vishwanath.bs@ti.com> [111004 10:25]:
> @@ -105,7 +105,7 @@ static void omap3_enable_io_chain(void)
>  		/* Do a readback to assure write has been done */
>  		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>  
> -		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
> +		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
>  			 OMAP3430_ST_IO_CHAIN_MASK)) {
>  			timeout++;
>  			if (timeout > 1000) {

Checking for PM_WKST here makes sense..

> @@ -114,7 +114,7 @@ static void omap3_enable_io_chain(void)
>  				return;
>  			}
>  			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
> -					     WKUP_MOD, PM_WKEN);
> +					     WKUP_MOD, PM_WKST);
>  		}
>  	}
>  }

..but are you sure you also want to write into PM_WKST?

Tony
