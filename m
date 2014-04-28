From: mgr@pengutronix.de (Michael Grzeschik)
Date: Mon, 28 Apr 2014 23:43:49 +0200
Subject: [PATCH v4 00/17] ASoC: fsl-ssi: Driver cleanup
In-Reply-To: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140428214349.GE12596@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:54:41PM +0200, Markus Pargmann wrote:
> Hi,
> 
> This series is a cleanup of the fsl-ssi driver.
> 
> v4 includes the changes I made to fix the baudclock handling. I moved the
> baudclock enable/disable function calls into hw_params()/hw_free(). To avoid
> inconsistent reference counters for the baudclock I use a variable
> baudclk_streams which describes the active streams to be able to decide if
> we have to enable/disable the clock and set the rate. I currently don't have a
> board to test i2s-master, maybe I am able to test it next week. The new patch
> which includes these changes is "ASoC: fsl-ssi: Fix baudclock handling".
> 
> Best regards,
> 
> Markus
> 
> 
> Changes in v4:
>  - New patch to fix baudclock handling (enable/disable/set_rate)
> 
> Changes in v3:
>  - Some new patches to improve/fix i2s master mode by Sascha
>  - baudclock is enabled/disabled in startup/shutdown now
>  - bitclock setup moved to a seperate function (not set_dai_sysclk)
>  - Regmap config changed to NATIVE now.
> 
> 
> Markus Pargmann (12):
>   ASoC: fsl-ssi: Fix register values when disabling
>   ASoC: fsl-ssi: Move debugging to seperate file
>   ASoC: fsl-ssi: Use dev_name for DAI driver struct
>   ASoC: fsl-ssi: Move imx-specific probe to seperate function
>   ASoC: fsl-ssi: Remove useless DMA code
>   ASoC: fsl-ssi: Cleanup probe function
>   ASoC: fsl-ssi: Remove unnecessary variables from ssi_private
>   ASoC: fsl-ssi: make fsl,mode property optional
>   ASoC: fsl-ssi: Transmit enable synchronization
>   ASoC: fsl-ssi: Fix baudclock handling
>   ASoC: fsl-ssi: reorder and document fsl_ssi_private
>   ASoC: fsl-ssi: Use regmap
> 
> Sascha Hauer (5):
>   ASoC: fsl-ssi: introduce SoC specific data
>   ASoC: fsl-ssi: Move fsl_ssi_set_dai_sysclk above fsl_ssi_hw_params
>   ASoC: fsl-ssi: set bitclock in master mode from hw_params
>   ASoC: fsl-ssi: remove unnecessary spinlock
>   ASoC: fsl-ssi: Set framerate divider correctly for i2s master mode
> 
>  sound/soc/fsl/Kconfig       |    1 +
>  sound/soc/fsl/Makefile      |    3 +-
>  sound/soc/fsl/fsl_ssi.c     | 1259 +++++++++++++++++++------------------------
>  sound/soc/fsl/fsl_ssi.h     |  112 +++-
>  sound/soc/fsl/fsl_ssi_dbg.c |  163 ++++++
>  5 files changed, 815 insertions(+), 723 deletions(-)
>  create mode 100644 sound/soc/fsl/fsl_ssi_dbg.c

For the whole series:

Tested-By: Michael Grzeschik <mgr@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
