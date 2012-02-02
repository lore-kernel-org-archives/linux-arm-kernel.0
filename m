From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Feb 2012 17:11:34 +0800
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120202085521.GB9773@S2101-09.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202085521.GB9773@S2101-09.ap.freescale.net>
Message-ID: <20120202091132.GD9773@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 04:55:23PM +0800, Shawn Guo wrote:
> On Thu, Feb 02, 2012 at 10:12:05AM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  arch/arm/mach-imx/mach-mx31ads.c      |   10 ++++++++++
> >  arch/arm/plat-mxc/include/mach/mx31.h |    1 +
> >  2 files changed, 11 insertions(+), 0 deletions(-)
> > 
> Hmm, let's see who are actually using mxc_audmux_v2_configure_port().
> 
> $ git grep -n mxc_audmux_v2_configure_port arch/arm/
> arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:246:     mxc_audmux_v2_configure_port(0,
> arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:254:     mxc_audmux_v2_configure_port(4,
> arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:257:     mxc_audmux_v2_configure_port(0,
> arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:265:     mxc_audmux_v2_configure_port(3,
> arch/arm/mach-imx/mach-pcm043.c:365:    mxc_audmux_v2_configure_port(3,
> arch/arm/mach-imx/mach-pcm043.c:371:    mxc_audmux_v2_configure_port(0,
> 
As we are moving audmux into sound/soc/imx, it makes less sense to
still keep these calls in board files.  Instead, I prefer to call it
from machine driver like what wm1133-ev1 does below.  Or we can simply
make the it a audmux-self call with 3 parameters it needs retrieved
from platform_data or device tree, so that machine driver does not
even bother with the call.  Makes sense?

Regards,
Shawn

> $ git grep -n mxc_audmux_v2_configure_port sound/soc/imx/
> sound/soc/imx/wm1133-ev1.c:277: mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0, ptcr, pdcr);
> sound/soc/imx/wm1133-ev1.c:281: mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT5_SSI_PINS_5, ptcr, pdcr);
> 
> I guess audmux device needs to be added for all these users.  And for
> sake of bisect, it should be added as part of patch #5.
> 
