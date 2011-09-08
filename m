From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 Sep 2011 14:48:35 +0800
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <CAGsJ_4zF0hPKmYYETPGEgHHeyZUfjPUFkrTk--yPuuNy_M=DJA@mail.gmail.com>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-4-git-send-email-shawn.guo@linaro.org>
	<1711465.COqYbTSZES@wuerfel>
	<20110907060501.GE8148@S2100-06.ap.freescale.net>
	<CAGsJ_4zF0hPKmYYETPGEgHHeyZUfjPUFkrTk--yPuuNy_M=DJA@mail.gmail.com>
Message-ID: <20110908064834.GL8148@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 08:43:06PM +0800, Barry Song wrote:
> 2011/9/7 Shawn Guo <shawn.guo@freescale.com>:
> > Hi Arnd,
> >
> > On Tue, Sep 06, 2011 at 09:14:29PM +0200, Arnd Bergmann wrote:
> >> On Tuesday 06 September 2011 17:58:37 Shawn Guo wrote:
> >> > It adds a number of core drivers support for imx6q, including clock,
> >> > General Power Controller (gpc), Multi Mode DDR Controller(mmdc) and
> >> > System Reset Controller (src).
> >> >
> >> > Signed-off-by: Ranjani Vaidyanathan <ra5478@freescale.com>
> >> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> >> > ---
> >> > ?arch/arm/mach-imx/Kconfig ? ? ? | ? 13 +
> >> > ?arch/arm/mach-imx/Makefile ? ? ?| ? ?4 +
> >> > ?arch/arm/mach-imx/clock-imx6q.c | 1990 +++++++++++++++++++++++++++++++++++++++
> >> > ?arch/arm/mach-imx/gpc.c ? ? ? ? | ?110 +++
> >> > ?arch/arm/mach-imx/mmdc.c ? ? ? ?| ? 71 ++
> >> > ?arch/arm/mach-imx/src.c ? ? ? ? | ? 52 +
> >> > ?6 files changed, 2240 insertions(+), 0 deletions(-)
> >>
> >> This is unfortunately still a major problem.
> >
> > It's so sad to still get this comment. ?Back to Linaro Connect on
> > Cambridge, I believe I asked for your opinion on new SoC clock support
> > without waiting for the clock framework. ?You said you do not have a
> > strong position on this and would defer to others' judgement. ?Then
> > I talked to Russell and Grant respectively, and they both agree that
> > we should not be blocked by the clock framework. ?That's why I decided
> > to start upstreaming imx6q.
> >
> >> I realize that we don't
> >> yet have a good framework to do this with significantly less code,
> >> but adding a platform that is mostly consisting of stupid additions
> >> of clock descriptions that really should be in the device tree does
> >> not scale much longer.
> >
> > I definitely agree this does not scale for long term. ?And I would
> > immediately migrate it to clock framework once it gets ready and put
> > the description into device tree when clock binding is ready. ?Before
> > we get there, we need a way out. ?It's unreasonable for us to hold
> > the new soc support for an unspecified time. ?It's been 20 months since
> > we saw the common clock patches[1] from Jeremy, and we do not know yet
> > how many months we still have to wait. ?Grant worked out the auxdata to
> > remove the device tree dependency on clock framework. ?I think we
> > should not get new soc support blocked by clock framework either.
> >
> >> We decided to let this still get in for prima2,
> >> which was also ugly in this regard but much simpler than imx6.
> >>
> > It's unfair to me that you reject imx6q clock code just because it's
> > an implementation for a hardware complexer than prima2.
> 
> i understand your feeling.
> 
No, you do not :)  With the talking at Cambridge, I thought I'm allowed
to add new platform support without being blocked by clock framework.
That's why I have been worked very hard for 3 weeks to come up with
this patch series.  Now I'm getting a "no", which really frustrates me.

> actually i am also waiting for the common clock framework to finish
> the whole prima2 clock tree driver. now prima2 only includes a little
> part of clock trees, actually if i list all of them, the file will be
> large too. And codes are ugly too.
> 
I did not hear "ugly" from Arnd on imx6q-clock.c.  Instead, he said
the description of the clocks and the tree should be migrated to clock
frame and device tree clock bindings, which unfortunately have not been
available yet.

> auxdata is really a temp solution, it really brings many details to
> kernel, which should not be in kernel at all.
> 
The auxdata was originally designed to be a temp solution.  But we
will see if it's really temp, considering it could also be used to
carry platform callbacks and attach device id.  There are some other
cases beside clock lookup that we have not been able to sort out just
by device tree and will probably have to use auxdata as well.

-- 
Regards,
Shawn
