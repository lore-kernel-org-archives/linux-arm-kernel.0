From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Feb 2012 22:11:26 +0800
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120202132618.GL7428@opensource.wolfsonmicro.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202120900.GC7428@opensource.wolfsonmicro.com>
 <20120202131716.GF9773@S2101-09.ap.freescale.net>
 <20120202132618.GL7428@opensource.wolfsonmicro.com>
Message-ID: <20120202141124.GG9773@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 01:26:18PM +0000, Mark Brown wrote:
> On Thu, Feb 02, 2012 at 09:17:18PM +0800, Shawn Guo wrote:
> > On Thu, Feb 02, 2012 at 12:09:01PM +0000, Mark Brown wrote:
> 
> > > Since the audmux is a part of the SoC silicon shouldn't the SoC just
> > > register the device without individual boards having to do anything
> > > (possibly conditional on ASoC being selected in Kconfig or something)?
> > > It's going to be connected in exactly the same fashion on any system
> > > using the SoC.
> 
> > Hmm, we are trying to save adding the device for those boards which do
> > not route any audmux pins out at all.
> 
> That's why I'm saying perhaps make it conditional on having ASoC built
> (or even on having the AUDMUX driver built).

Do you mean by having the below in some place like function
imx31_soc_init()?

#ifdef CONFIG_SND_MXC_SOC_AUDMUXV2
	imx_add_platform_device("audmux-v2", 0,
		audmux_res, ARRAY_SIZE(audmux_res), NULL, 0);
#endif

I do not think it's nice and consistent to the way that imx
sub-architecture adds platform device.

Furthermore, when a DT based board boots here, the code is broken.
Explicitly adding the device by individual board as needed can easily
align with DT based boards.  By default, the audmux node in <soc>.dtsi
file has status = "disabled", and any board that needs audmux device
only need to overwrite status property of audmux node as 'okay' in its
<board>.dts.  Then DT core will add the audmux device when the board
boots.

-- 
Regards,
Shawn
