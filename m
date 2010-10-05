From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 5 Oct 2010 03:57:02 -0600 (MDT)
Subject: [PATCH 07/10] OMAP: McBSP: implement functional clock switching
	via clock framework
In-Reply-To: <201010051135.36436.peter.ujfalusi@nokia.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
	<20101001213531.1408.87922.stgit@twilight.localdomain>
	<201010051135.36436.peter.ujfalusi@nokia.com>
Message-ID: <alpine.DEB.2.00.1010050349450.13816@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On Tue, 5 Oct 2010, Peter Ujfalusi wrote:

> What is the fclk source by default.
> What I mean is that most of the machine drivers are not calling the 
> snd_soc_dai_set_sysclk for the cpu_dai.
> It has been by default to prcm_fclk (core_96 or per_96).
> Is this still the case after this series?

These patches shouldn't cause any change in behavior in this regard.  So 
if the ASoC machine driver does not explicitly tell it which clock to use, 
it will use whatever the bootloader or board file configured.  If the 
bootloader or board file didn't configure anything, probably it will use 
the chip's default reset setting, which for CONTROL_DEVCONF0.MCBSP1_CLKS 
on 34xx, should be the 96MHz "prcm_fclk"[1].

In other words, the clock framework won't change the parent clock unless 
the code explicitly tells it to do so, as in the case of the OMAP3 Pandora 
ASoC machine driver.

> Do we need to go through the ASoC machine drivers, and need to select 
> explicitly the prcm_fclk from now on?

It is a wise thing to do, since one never knows what the bootloader will 
do.  Probably also wise to explicitly set the CLKR/FSR muxes also.

best regards,


- Paul

1. OMAP34xx TRM rev. ZH, Table 7-79, "CONTROL_DEVCONF0"
