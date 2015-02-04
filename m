From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Feb 2015 15:24:14 +0100
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <CAL_JsqLSHrbQq2qFSpZyoiZ757xs8MHjNFD8+PKBGBTPmEatwA@mail.gmail.com>
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <CAL_JsqL8iahGwkPyDuB+2j_SvkH0TYYNDErgLOgHOgHvERU-9A@mail.gmail.com>
 <CAL_JsqLSHrbQq2qFSpZyoiZ757xs8MHjNFD8+PKBGBTPmEatwA@mail.gmail.com>
Message-ID: <4228990.Thq3aQIjz2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 February 2015 07:49:25 Rob Herring wrote:
> On Wed, Feb 4, 2015 at 7:44 AM, Rob Herring <robh@kernel.org> wrote:
> > On Wed, Feb 4, 2015 at 7:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Tuesday 03 February 2015 17:22:53 Rob Herring wrote:
> >>> SA1100 and PXA differ only in register offsets which are currently
> >>> hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
> >>> have this RTC block also.
> >>>
> >>> Convert the driver to use ioremap and set the register offsets dynamically.
> >>> Since we are touching all the register accesses, convert them all to
> >>> readl/writel.
> >>>
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>> Cc: Alessandro Zummo <a.zummo@towertech.it>
> >>> Cc: rtc-linux at googlegroups.com
> >>
> >> Hmm, I really should have sent out my version of the patch ages ago. 
> >
> > Got any others? 

Look at the whole branch, it converts a couple of platforms
to CONFIG_MULTIPLATFORM: msm, mmp, realview, s3c64xx, versatile (your
patches), ep93xx (partially), gemini.

The patches are in different states and at least need proper
review, in some cases rewrite. The mmp patches should be
pretty much ready but I never got around to submit them.

> >> Can you have a look at
> >>
> >> http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/commit/?h=multiplatform-3.19-next&id=4d9727883a363fb839e7d1633599166c0a08d644
> >>
> >> to see compare the approaches and see if there is anything I did that you
> >> missed?
> >
> > You used the relaxed variants seems to be the main difference. Yours
> > won't build on arm64 either.
> 
> Also, I noticed the rtc-puv3 driver appears to be the same programming
> model. The quirks around interrupt clearing seem to be a bit different
> though.

Yes, I noticed before that not only is arch/unicore32 more or less a clone
of arch/arm (aside from cleanups that I asked for when it was submitted),
but the pkunity is also modeled around some IP blocks from sa1100/pxa.
According to http://mprc.pku.edu.cn/eng/intro.html, the work on that
SoC was done in a university lab with funding from Intel.

The CPU instruction set apparently has some differences, and the same
is likely true for the peripherals, it might be interesting to look at
drivers/video/fbdev/fb-puv3.c, drivers/i2c/busses/i2c-puv3.c,
drivers/pwm/pwm-puv3.c, arch/unicore32/kernel/gpio.c and
arch/unicore32/kernel/irq.c for more similarities. I don't think anyone
would bother changing those to use a common driver though, given the
state of unicore32.

	Arnd
