From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 11:33:45 -0700
Subject: [PATCH] drivers: pinctrl: add active state to core
In-Reply-To: <CACRpkdYQSO0+9tQkS=df-kpL=XL+DpnY1ijp6_Zeg0MvmFujyw@mail.gmail.com>
References: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
 <51B75148.5080701@wwwdotorg.org>
 <CACRpkdYQSO0+9tQkS=df-kpL=XL+DpnY1ijp6_Zeg0MvmFujyw@mail.gmail.com>
Message-ID: <20130612183345.GU8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [130611 12:59]:
> On Tue, Jun 11, 2013 at 6:33 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 06/11/2013 02:16 AM, Linus Walleij wrote:
> >> From: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> In addition to the recently introduced pinctrl core
> >> control, the PM runtime pin control for the OMAP platforms
> >> require a fourth state in addtition to the default, idle and
> >> sleep states already handled by the core: an explicit "active"
> >> state. Let's introduce this to the core in addition to the
> >> other states already defined.
> >
> > Surely "default" /is/ "active"? That's what it's meant so far.
> 
> I thought so too, until Tony informed us that in the OMAP world
> this state is not always the active one.
> 
> But I don't know the exact reasons for.
> 
> I guess that some "default" states on the OMAP may mean these
> are configured as decoupled, inactive, until explicitly activated
> or something like that.

The main reason is that remuxing all the pins for a device for
PM runtime suspend and resume is not necessary. Most pins are
static and configured once during the consumer driver probe.
And in most cases, remuxing only one pin for the rx line is
needed. This is performance critical as it may need to be done
constantly while entering and exiting idle, and remuxing all the
pins is just a waste of cycles.

Regards,

Tony 
