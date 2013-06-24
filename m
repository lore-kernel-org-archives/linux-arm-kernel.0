From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Jun 2013 03:10:55 -0700
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <51C4A593.6000900@wwwdotorg.org>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org> <20130617072021.GB4465@atomide.com>
 <51C20E3A.8090304@wwwdotorg.org>
 <20130620063823.GD5523@atomide.com>
 <51C3577E.6040709@wwwdotorg.org>
 <20130621062552.GI5523@atomide.com>
 <51C4A593.6000900@wwwdotorg.org>
Message-ID: <20130624101055.GT5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130621 12:18]:
> On 06/21/2013 12:25 AM, Tony Lindgren wrote:
> > * Stephen Warren <swarren@wwwdotorg.org> [130620 12:32]:
> >>
> >> I assume you mean there shouldn't be any issue *modifying* the pinctrl
> >> API to allow multiple states to be active at once? And where you're
> >> talking about having multiple sets active at once already, you're
> >> talking about some other API?
> > 
> > Nope, the standard pinctrl API. At least I have not seen issues with
> > having multiple states active the same time in a single driver.
> 
> Please take a look at the implementation of pinctrl_select_state(). It
> very explicitly performs the following steps:
> 
> 1) Find all pins(groups) that are used in the current state but not the
> new state, and execute pinctrl_disable_setting() on them. (For mux
> settings only, not pin config, since the core doesn't have any idea how
> to reverse config settings).
>
> 2) For all settings in the new state, apply those settings.
> 
> So, it very explicitly only allows a single state to be set at a time.
> Equally, p->state (the field which stores the currently selected state)
> is a single item, not a set/list/array.

OK thanks I get now what you're saying. I did not see the p->state
issue as the disable function won't do anything for the SoCs that I
mostly deal with.

> So, this code needs rework if you want the core to support the concept
> of having multiple states active at once, since it needs separate
> pinctrl_activate_state() and pinctrl_deactivate_state() APIs, in order
> to avoid step (1) above. And of course, p->state would need to be a
> set/list/array.

I'll think about it a bit and do a patch to fix this. It seems that
that we need just two entries in the p->state array: static (default),
and dynamic. Then the dynamic would be typically one of: active, idle,
rx, tx.

Regards,

Tony
