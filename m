From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 8 Oct 2012 07:45:42 +0200
Subject: [PATCH] pwm: Get rid of HAVE_PWM
In-Reply-To: <CAMPhdO-PiKwYstKrGwdhrUG3+KWhPioAtzPVqtk52vss-4M+iw@mail.gmail.com>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
 <506DA487.9070400@metafoo.de>
 <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
 <506DDA16.8070604@metafoo.de>
 <20121004191308.GB7228@avionic-0098.mockup.avionic-design.de>
 <CAMPhdO-PiKwYstKrGwdhrUG3+KWhPioAtzPVqtk52vss-4M+iw@mail.gmail.com>
Message-ID: <20121008054542.GA14907@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 10:45:44AM +0800, Eric Miao wrote:
> On Fri, Oct 5, 2012 at 3:13 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Thu, Oct 04, 2012 at 08:48:54PM +0200, Lars-Peter Clausen wrote:
> >> On 10/04/2012 08:29 PM, Thierry Reding wrote:
> >> > On Thu, Oct 04, 2012 at 05:00:23PM +0200, Lars-Peter Clausen wrote:
> >> >> On 10/04/2012 08:06 AM, Thierry Reding wrote:
> >> >>> [...]
> >> >>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> >> >>> index 331d574..b38f23d 100644
> >> >>> --- a/arch/mips/Kconfig
> >> >>> +++ b/arch/mips/Kconfig
> >> >>> @@ -219,7 +219,8 @@ config MACH_JZ4740
> >> >>>   select GENERIC_GPIO
> >> >>>   select ARCH_REQUIRE_GPIOLIB
> >> >>>   select SYS_HAS_EARLY_PRINTK
> >> >>> - select HAVE_PWM
> >> >>> + select PWM
> >> >>> + select PWM_JZ4740
> >> >>>   select HAVE_CLK
> >> >>>   select GENERIC_IRQ_CHIP
> >> >>
> >> >> I'm not sure if this is such a good idea, not all jz4740 based board
> >> >> necessarily require PWM.
> >> >
> >> > This really only restores previous behaviour. But I agree that this is
> >> > potentially not what we want. Maybe we should just not select this for
> >> > any boards but rather leave it up to some default configuration. If so
> >> > the patch can be made simpler by just removing the HAVE_PWM entries.
> >>
> >> At least for JZ4740 I think that is the better solution.
> >
> > Okay, I'll give other people the chance to comment on this. Especially
> > for PXA there are many boards that use the PWM for backlight and it
> > would be interesting to hear from them how they want this to be handled.
> 
> I'd say the original intention to introduce HAVE_PWM (although PXA
> makes a lot use of this, but I remember Russell was the first to propose
> this), is for board config to indicate its potential usage of the PWM or
> rather if PWM is available for use on the board, and then leave the
> developer another config option to build or not-to-build.

But with HAVE_PWM there was never a different configuration option to
enable the PWM driver. All architectures that used the HAVE_PWM symbol
built the driver based on its selection. The meaning seemed more like
"the PWM API is available" rather than anything else.

Given that, HAVE_PWM would now be replaced by just PWM since that makes
the API available. Client drivers would still be able to compile
properly but fail at runtime if no driver actually provided any PWM
devices.

Note that starting with 3.7 the API will even be available in the form
of dummy implementations if PWM is not selected.

> Personally I think removing HAVE_PWM will simplify the code a bit
> and that's a good thing, on the other hand, how to keep a certain level
> of flexibility mentioned above remains a small question. I guess with
> device tree, this can be mitigated a bit.

I think, given the above, that the best solution would be to not select
any PWM-related symbols from boards and handle this via the board
default configurations. I was just worrying that we were changing
existing behaviour. On the other hand behaviour was already changed by
making the drivers no longer conditional on HAVE_PWM.

If nobody has any objections, my tendency would be to just not replace
HAVE_PWM but just get rid of it. Of course, as I mentioned above, it
would require the board default configurations to be updated and select
the PWM and corresponding driver symbol in order to restore previous
behaviour.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121008/cd02ed20/attachment.sig>
