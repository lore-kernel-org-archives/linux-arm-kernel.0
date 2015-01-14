From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Jan 2015 11:04:19 -0800
Subject: [PATCH 6/7] ARM: OMAP2+: Fix reboot for 81xx
In-Reply-To: <20150114012447.GF18523@saruman>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-7-git-send-email-tony@atomide.com>
 <20150114012447.GF18523@saruman>
Message-ID: <20150114190419.GO2419@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150113 17:28]:
> On Tue, Jan 13, 2015 at 03:13:56PM -0800, Tony Lindgren wrote:
> > +
> > +#define TI81XX_PRM_DEVICE_RSTCTRL	0x00a0
> > +#define TI81XX_GLOBAL_RST_COLD		BIT(1)
> > +
> > +/**
> > + * ti81xx_restart - trigger a software restart of the SoC
> > + * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
> > + * @cmd: passed from the userspace program rebooting the system (if provided)
> > + *
> > + * Resets the SoC.  For @cmd, see the 'reboot' syscall in
> > + * kernel/sys.c.  No return value.
> > + */
> > +void ti81xx_restart(enum reboot_mode mode, const char *cmd)
> > +{
> > +	omap2_prm_set_mod_reg_bits(TI81XX_GLOBAL_RST_COLD, 0,
> > +				   TI81XX_PRM_DEVICE_RSTCTRL);
> 
> do you need to check that mode == REBOOT_COLD here ?

Looks like not, trying to use the warm reset bit does not seem to do
anything and probably requires manually resetting clocks into bypass
mode or something.

I'll just add a comment about that.

Regards,

Tony
