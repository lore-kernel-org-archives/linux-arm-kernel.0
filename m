From: tony@atomide.com (Tony Lindgren)
Date: Fri, 3 Feb 2012 14:37:41 -0800
Subject: [PATCH v2] pinctrl: pin configuration states
In-Reply-To: <CACRpkdYEjdX+nNb=fhU3ANFeJwMguEsbGC7Rsqq7g2F-tmE4Sw@mail.gmail.com>
References: <1328124889-9780-1-git-send-email-linus.walleij@stericsson.com>
 <20120202230317.GA1426@atomide.com>
 <CACRpkdYEjdX+nNb=fhU3ANFeJwMguEsbGC7Rsqq7g2F-tmE4Sw@mail.gmail.com>
Message-ID: <20120203223741.GH20333@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [120203 13:46]:
> On Fri, Feb 3, 2012 at 12:03 AM, Tony Lindgren <tony@atomide.com> wrote:
> > [Me]
> >> +For simple systems that just configure the pins on boot and then forget about
> >> +them, the first configuration table may be sufficient. However some systems
> >> +may need to switch configuration states at runtime, and in that case the
> >> +system may want to ground both pins by simply calling:
> >> +
> >> +ret = pinconf_activate_state("pinctrl-foo", "idle");
> >
> > For dynamic changing of pin states during runtime we should not change
> > the states based on string parsing. This is because some of these pins
> > may need to be changed every time when entering and exiting idle.
> 
> So pinmuxes get a handle back using a get/put pair, and
> have enable/disable semantics as well.
> 
> I avoided this for pin config since it would mean that you have
> to keep some opaque cookie around, like we currently do with
> pinmux. And pin config states are simpler in that you simply
> move from one state to the other, no bookkeeping is involved.
> 
> I never took into consideration that it may be a performance
> issue to do that string parsing and you have a point there.
> 
> So would you prefer something like:
> 
> astat = pinconf_get_state("pinctrl-foo", "idle");
> istat = pinconf_get_state("pinctrl-foo", "idle");
> 
> pinconf_activate_state(astat);
> pinconf_activate_state(istat);
> ...
> 
> If this is what people want I can sure do it like that instead.

OK that sounds good to me.

Regards,

Tony
