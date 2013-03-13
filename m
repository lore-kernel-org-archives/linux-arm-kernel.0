From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 12:22:45 -0600
Subject: [PATCH] pinctrl: move subsystem mutex to pinctrl_dev struct
In-Reply-To: <1363189479-11240-1-git-send-email-linus.walleij@stericsson.com>
References: <1363189479-11240-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5140C3F5.9030406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 09:44 AM, Linus Walleij wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This mutex avoids deadlock in case of use of multiple pin
> controllers. Before this modification, by using a global
> mutex, deadlock appeared when, for example, a call to
> pinctrl_pins_show() locked the pinctrl_mutex, called the
> ops->pin_dbg_show of a particular pin controller. If this
> pin controller needs I2C access to retrieve configuration
> information and I2C driver is using pinctrl to drive its
> pins, a call to pinctrl_select_state() try to lock again
> pinctrl_mutex which leads to a deadlock.
> 
> Notice that the mutex grab from the two direction functions
> was moved into pinctrl_gpio_direction().
> 
> For two cases, we can't replace pinctrl_mutex by
> pctldev->mutex, because at this stage, pctldev is
> not accessible :
> 	- pinctrl_get()/pinctrl_put()
> 	- pinctrl_register_maps()
> 
> So add respectively pinctrl_list_mutex and
> pinctrl_maps_mutex in order to protect
> pinctrl_list and pinctrl_maps list instead.

I can't see how this would be safe, or even how it would solve the
problem (and still be safe).

In the scenario described above, pinctrl_pins_show() would need to lock
the list mutex since it's interacting with the list of pinctrl devices.
Then, the I2C drivers'c pinctrl_select() also needs to acquire that same
lock, since it's interacting with another entry in that same list in
order to re-program the other pinctrl device to route I2C to the correct
location.

So, I can't see how separating out the map lock would make any difference.

Also, why is the map lock relevant here at all anyway? The I2C mux's
probe() should have executed pinctrl_get(), and isn't the map parsed at
that time, and converted to a struct pinctrl, and hence any later call
to pinctrl_select() doesn't touch the map?

Is there a recursive lock type that could be used instead? I'm not sure
if that'd still be safe though.

Finally, a long while ago when I removed these separate locks and
created the single lock, I raised a slew of complex points re: why it
was extremely hard to split up the locking. I talked about a number of
AB/BA deadlock cases IIRC mostly w.r.t pinctrl device registration. Were
those considered when writing this patch? What's the solution?
