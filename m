From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 7 Jul 2011 23:13:32 +0800
Subject: [PATCH v3 2/3] ARM: mxc: use ARCH_NR_GPIOS to define gpio number
In-Reply-To: <20110707074755.GX6069@pengutronix.de>
References: <1309970263-13239-1-git-send-email-shawn.guo@linaro.org>
	<1309970263-13239-3-git-send-email-shawn.guo@linaro.org>
	<20110707074755.GX6069@pengutronix.de>
Message-ID: <20110707151331.GB12722@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 09:47:55AM +0200, Sascha Hauer wrote:
> On Thu, Jul 07, 2011 at 12:37:42AM +0800, Shawn Guo wrote:
> > The patch removes MXC_GPIO_IRQS and instead uses ARCH_NR_GPIOS to
> > define gpio number.  This change is need when we change mxc gpio
> > driver to be device tree aware.  When migrating the driver to device
> > tree, pdev->id becomes unusable.  It requires driver get gpio range
> > from gpio core, which will dynamically allocates number from
> > ARCH_NR_GPIOS to 0.
> > 
> > As a bonus point, it removes lines of '#if' and make the code a
> > little bit cleaner.  The side effect is the waste of number.  But
> > this is not a point when we go single image.
> 
> I'm not sure whether we really should depend on an externally defined
> ARCH_NR_GPIOS. Someone might get the idea to change this to a lower
> value. Maybe we should define this ourselves instead.
> 
Good point.  We should not depend on the externally defined one.  But
the reason in my mind is different from yours.  Right now, i.mx50 gets
192 and i.mx6 gets 224 gpios.  I do not see the point to lower the
value (no lower than 224), since we will go single image soon.  The
thing concerning me is that someday we may have a soc coming out with
more than 256 gpios.  Then we have to override ARCH_NR_GPIOS with our
own definition.

Please take a look at the updated patch below.  If it looks fine to
you, I will resend the patch.

8<----
