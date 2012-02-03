From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 3 Feb 2012 10:15:54 +0800
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120202135805.GB3015@richard-laptop>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202085521.GB9773@S2101-09.ap.freescale.net>
 <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
Message-ID: <20120203021554.GE32403@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adding Eric B?nard.

On Thu, Feb 02, 2012 at 09:58:07PM +0800, Richard Zhao wrote:
> On Thu, Feb 02, 2012 at 09:09:03PM +0800, Shawn Guo wrote:
> > On Thu, Feb 02, 2012 at 05:24:28PM +0800, Richard Zhao wrote:
> > > On Thu, Feb 02, 2012 at 05:11:34PM +0800, Shawn Guo wrote:
> > > > On Thu, Feb 02, 2012 at 04:55:23PM +0800, Shawn Guo wrote:
> > > > > On Thu, Feb 02, 2012 at 10:12:05AM +0800, Richard Zhao wrote:
> > > > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > > > > ---
> > > > > >  arch/arm/mach-imx/mach-mx31ads.c      |   10 ++++++++++
> > > > > >  arch/arm/plat-mxc/include/mach/mx31.h |    1 +
> > > > > >  2 files changed, 11 insertions(+), 0 deletions(-)
> > > > > > 
> > > > > Hmm, let's see who are actually using mxc_audmux_v2_configure_port().
> > > > > 
> > > > > $ git grep -n mxc_audmux_v2_configure_port arch/arm/
> > > > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:246:     mxc_audmux_v2_configure_port(0,
> > > > > arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:254:     mxc_audmux_v2_configure_port(4,
> > > > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:257:     mxc_audmux_v2_configure_port(0,
> > > > > arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c:265:     mxc_audmux_v2_configure_port(3,
> > > > > arch/arm/mach-imx/mach-pcm043.c:365:    mxc_audmux_v2_configure_port(3,
> > > > > arch/arm/mach-imx/mach-pcm043.c:371:    mxc_audmux_v2_configure_port(0,
It's machine specific code, though audmux driver is common. Might be ok?
The asoc machine file for the above 3 boards is not platform driver, and
don't get any plat info.

Sascha, Any suggestion? I saw pcm043 board was added by you. 
> > > I didn't grep arch/arm. where is pc043 asoc machine file?
> > 
> > It seems to be sound/soc/imx/phycore-ac97.c.
> You see, we're not famaliar with the boards.
> > 
> > > > > 
> > > > As we are moving audmux into sound/soc/imx, it makes less sense to
> > > > still keep these calls in board files.
> > > It don't corrupt git bisect. We don't have to include it in this patch.
> > 
> > It's logically part of this series.
> I don't know much about the above boards and I can not test either. I think I
> have to leave it to other volunteers. I mainly focus on audmux itself.
> > 
> > > >  Instead, I prefer to call it
> > > > from machine driver like what wm1133-ev1 does below.
> > > Maybe pass the info as asoc machine driver pdata.
Sorry, they're not platform drivers.
> > 
> > Sounds good.
> > 
> > > >  Or we can simply
> > > > make the it a audmux-self call with 3 parameters it needs retrieved
> > > > from platform_data or device tree, so that machine driver does not
> > > > even bother with the call.  Makes sense?
> > > audux configuration may change after initial set. For example, it may use
> > > one configuration for audio playback, but use another when you connect a
> > > BT audio device.
> > 
> > Right.  I forgot this point.
> > 
> > -- 
> > Regards,
> > Shawn
> 
