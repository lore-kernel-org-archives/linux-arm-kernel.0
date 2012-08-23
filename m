From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 23 Aug 2012 21:11:08 +0200
Subject: [PATCH] pwm: Call pwm_enable() before pwm_config()
In-Reply-To: <50366464.4070801@metafoo.de>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
 <50366464.4070801@metafoo.de>
Message-ID: <20120823191108.GB8127@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 07:12:04PM +0200, Lars-Peter Clausen wrote:
> On 08/23/2012 06:57 PM, Beno?t Th?baudeau wrote:
> > On Thursday, August 23, 2012 5:43:32 PM, Lars-Peter Clausen wrote:
> >> On 08/23/2012 04:19 PM, Beno?t Th?baudeau wrote:
> >>> Some PWM drivers enable the clock of the PWM peripheral in
> >>> pwm_enable(). Hence,
> >>> for these drivers, a call to pwm_config() does not have any effect
> >>> before
> >>> pwm_enable() has been called.
> >>>
> >>> This patch fixes the PWM users to make sure that they call
> >>> pwm_enable() before
> >>> pwm_config().
> >>>
> >>> This fixes the first setting of brightness through sysfs that had
> >>> no effect with
> >>> leds-pwm and the i.MX PWM driver.
> >>
> >> But isn't this a bug in the PWM peripheral driver? With this change
> >> the PWM
> >> will start with the old settings first. While this is not so much of
> >> a problem
> >> for a backlight (although it might cause a short flickering) it might
> >> cause
> >> problems for other applications, like using the PWM pin as a timing
> >> generator.
> >> In my opinion it's better to fix the PWM peripheral drivers which
> >> have this
> >> problem instead of trying to work around it in every user of the PWM
> >> API.
> > 
> > I don't know. See my detailed description of this issue here:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/115667.html
> > 
> > Where the bug is depends on the detailed definition of the PWM API, which I
> > don't find documented anywhere.
> > 
> > If pwm_enable() means "start PWM timer with the configured settings", then the
> > bug is in the drivers. If it means "enable the PWM peripheral so that we can
> > work with it", then the bug is in the PWM users.
> 
> It really is the former. See the description of pwm_enable() in drivers/pwm/core.c

Yes. pwm_enable() is only for starting the PWM and *not* the peripheral.
I should update the documentation to make this clearer.

> > I don't really have time to work on this, so I suggested this patch as a simple
> > solution. Otherwise, it means reworking several PWM drivers for different
> > hardware that is not available to everyone for testing.
> > 
> > If we decide to only change the i.MX PWM driver, the fix would be:
> > pwm_config()
> > {
> >         save passed config in private data;
> >         if (pwm enabled)
> >                 apply passed config;
> > }
> > 
> > pwm_enable()
> > {
> >         if (!(pwm enabled)) {
> >                 enable pwm ip clk;
> >                 apply config from private data;
> >         }
> > }
> 
> Another option is to enable the clock if it is disabled when the device is
> configured. E.g. that's what tegra does.

Yes, that would have been my proposal as well.

> > If we fix only this driver, we must not forget that the same issue probably
> > exists with several other PWM drivers.
> 
> Since this seems to be a common pattern in a number of PWM drivers it might
> make sense to simply add support for enabling/disabling a clk to the pwm core.
> Or maybe just use the runtime pm API for this. This probably makes even more
> sense and grab a reference to the pm context when the enable() is called,
> release it when disable() is called and also grab it before calling the
> device's config callback and release it afterward.

The problem with adding this kind of support in the core is that the
device or platform doesn't necessarily support runtime PM. Perhaps
adding a flag to mark compatible drivers would be an option. If the
runtime PM API gracefully handles cases where no callbacks are
implemented (and therefore assumed unneeded) things should also work.

On the other hand this really is very driver-specific stuff. A lot of
hardware doesn't require an explicit clock being enabled to write
registers so those wouldn't need the implicit PM calls either.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/c9e9b436/attachment.sig>
