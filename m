From: tony@atomide.com (Tony Lindgren)
Date: Thu, 29 Aug 2013 22:48:58 -0700
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
In-Reply-To: <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
Message-ID: <20130830054858.GR7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* zhangfei gao <zhangfei.gao@gmail.com> [130829 04:03]:
> On Thu, Aug 29, 2013 at 4:58 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Aug 28, 2013 at 11:57 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> On Tue, Aug 20, 2013 at 04:32:28PM +0800, Zhangfei Gao wrote:
> >
> >>> Instead of use platform_driver_probe, use module_platform_driver
> >>> To support deferred probing
> >>> Also subsys_initcall may too early to auto set pinctl
> >>>
> >>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >>> Acked-by: Baruch Siach <baruch@tkos.co.il>
> >>
> >> This patch is tougher than it looks. You need it, because
> >> subsys_initcall may be too early for pinctrl.
> >
> > pinctrl is initialized very early, core_initcall().
> >
> > This is more a question of individual pin control drivers
> > and when they probe, and dependencies trying to take
> > a pinctrl handle before the pin controller is available
> > will be deferred. Even by those grabbed in the core
> > by drivers/base/pinctrl.c.
> 
> Thanks Linus.
> Your explanation is really make sense.
> 
> We use drivers/pinctrl/pinctrl-single.c, if subsys_initcall for
> pinctrl-single, no issue at all.

So far we've seen that if you have issues with this, the real
problem is that some other driver is trying to initialize way
too early probably because of legacy reasons that no longer
apply.

FYI, it's best to have all the drivers initialize with just
module_init and make them work as loadable modules because of
the following reasons:

1. You will get real console error messages when something
   goes wrong with no need for debug_ll and earlyprintk

2. By creating loadable driver modules you're already getting
   some protection from spaghetti code as the interfaces
   are defined

3. It will be easier for distros to support various ARM SoCs
   with loadable driver modules

Regards,

Tony
