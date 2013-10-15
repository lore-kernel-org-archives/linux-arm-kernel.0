From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Oct 2013 11:35:00 +0100
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-wandboard: Add HDMI support
In-Reply-To: <20131015091830.GW25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <1380826287-30253-2-git-send-email-fabio.estevam@freescale.com>
 <20131014174030.GU25034@n2100.arm.linux.org.uk>
 <20131014225029.GV25034@n2100.arm.linux.org.uk>
 <20131015074618.GG30088@pengutronix.de>
 <20131015091830.GW25034@n2100.arm.linux.org.uk>
Message-ID: <20131015103500.GY25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 10:18:30AM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 15, 2013 at 09:46:18AM +0200, Sascha Hauer wrote:
> > This sounds like the wrong clock polarity. Could you try inverting
> > sig_cfg.clk_pol in imx-drm/ipuv3-crtc.c?
> 
> I tweaked it a different way - I used devmem2 to directly poke at the
> register.  Inverting bit 17 (iow, clearing it) seems to fix the
> problem.

As a follow-up, the driver says this:

        unsigned clk_pol:1;     /* true = rising edge */

This is interpreted by the ipu-di.c driver as:

        if (!sig->clk_pol)
                di_gen |= DI_GEN_POLARITY_DISP_CLK;

note the inversion.  U-boot does something slightly different here
(apparantly it describes clk_pol in the same way though):

                if (sig.clk_pol)
                        di_gen |= DI_GEN_POL_CLK;

It's also reported that u-boot sets sig.clk_pol when
FB_SYNC_CLK_LAT_FALL bit is not set (which confirms that clk_pol
indicates rising edge active.)

Now, the confusing bit.  The docs for the imx6s/dl say that bit 17
when set is "active high" vs clear "active low".  This appears to
define a level active state.  The code seems to define an edge
instead.  What's more is that u-boot and the kernel seem to describe
'clk_pol' in the same way yet interpret it differently.

Should that inversion in the kernel be there?
