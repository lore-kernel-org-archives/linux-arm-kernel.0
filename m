From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 11:02:12 -0700
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <CACRpkdYwGHMznjoJqf5bX_74pmeKSiWtTwpNF1_4GSEk+KwrZA@mail.gmail.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org> <20130617072021.GB4465@atomide.com>
 <CACRpkdYwGHMznjoJqf5bX_74pmeKSiWtTwpNF1_4GSEk+KwrZA@mail.gmail.com>
Message-ID: <20130617180212.GU20992@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [130617 09:11]:
> On Mon, Jun 17, 2013 at 9:20 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > First, I think the concept of remuxing (or even checking) _all_ the pins
> > for a consumer device is wrong on most if not all hardware. For past 10
> > years I have not seen a case where _all_ the pins for a device would need
> > to be remuxed for any reason.
> 
> We may be talking past each other here. On the ux500 we use a lot
> of runtime pincontrol, but none of this is *remuxing*.
> 
> We are only *reconfiguring*.

Hmm routing the signal to a different device is certainly
remuxing but yeah configuring pulls etc does not change the
mux.
 
> Now I know that Haojian only recently added pin config to the
> pinctrl-single.c driver so maybe you have mostly seen muxing
> in your driver so far, so you view of the world is a bit different.
> 
> On the Nomadik pin controller we do mostly hogged muxing
> at boot time, but a lot of runtime reconfiguration. So our
> needs are very different.
> 
> Bear in mind that struct pinctl * forks effects in two paths,
> one is muxing the other is config, like pull-ups etc.

I also thought the plan was to merge pinmux and pinconf and
do things based the named modes?

The last time I tried using the pinconf functions it involved
knowing the name of the pin in the consumer driver. The name
may not be very descriptive in the device tree cases at least
for the pinctrl-single. So I did not pay much attention to
the pinconf functions.

Sorry if I'm confused, but maybe you can try to help me
understand how you would handle the following:

Let's assume you'd want to reconfigure MMC DAT lines with pulls
for idle and not touch the CLK and CMD lines.

How does the MMC driver know the DAT lines to configure with
pinconf?

And then how would you do set up the pins so that we can set
them up automatically for consumer drivers in
drivers/base/pinctrl.c?

Regards,

Tony
