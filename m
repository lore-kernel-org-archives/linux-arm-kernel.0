From: chunkeey@gmail.com (Christian Lamparter)
Date: Thu, 26 Apr 2018 23:47:30 +0200
Subject: [PATCH v2] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <CACRpkda6nD_nb7D1s7KHX3CxzmAw3qzdEe6m+V+TbaZ5gaZhaA@mail.gmail.com>
References: <20180402121005.10080-1-chunkeey@gmail.com>
 <2820412.JxDUeWI2ec@debian64>
 <CACRpkda6nD_nb7D1s7KHX3CxzmAw3qzdEe6m+V+TbaZ5gaZhaA@mail.gmail.com>
Message-ID: <3524410.JrO1DEFpQ1@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 11:12:21 CEST Linus Walleij wrote:
> On Thu, Apr 5, 2018 at 6:35 PM, Christian Lamparter wrote:
> > On Montag, 2. April 2018 17:04:47 CEST Bjorn Andersson wrote:
> >> @Linus, I count 24 callers of gpiochip_add_pin_range(). Is this
> >> suggestion reasonable?
> >>
> >> Can we make gpiochip_add_pin_range() check if there's already a
> >> gpio-range and return ok in some way?
> 
> I think I replied in some other mail that I think we need to
> be backwards compatible and it's not too hard to do
> both. (Correct me if I'm wrong.)
I think so too, I looked around and found that the nvidia pinctrl was
doing something similar with of_find_property():
<https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/pinctrl/tegra/pinctrl-tegra.c#L652>
|	has_prop = of_find_property(np, "gpio-ranges", NULL);

However this looks kinda funny, since "has_prob" is declared as a bool
and of_find_property() returns a pointer to a "struct property"....
Tell you what: If nobody beats me to it, I'll sent a patch for this after
the pinctrl-msm's gpio-hog has been dealt with. :)

> > Looks like Linus is currently really busy updating the gemini
> > target (a lot of work went into it) for OpenWrt.
> > <https://lists.openwrt.org/pipermail/openwrt-devel/2018-April/043752.html>
> > (Kinda funny, because I do help to maintain the apm821xx and the new
> > ipq40xx target over there.)
> 
> Yeah it was more of a hobby, partly research for a lecture
> on maintaining old ARM systems and all dangerous aftermarket
> devices that is littering the world.
> 
> Since I have noticed that the adoption of OpenWRT/LEDE goes
> far beyond routers and it is one of the most prevalent
> distributions that is existing in the IoT of darkness on the
> planet being the most deployed OS for bitcoin mining and
> being picked up for functional safety (such as automotive)
> because of its minimalist userspace.
> 
> I'm still amazed by the weirdness of our business.
I think I can add something to this thought as well. Albeit, it's a
more traditional, less zany story.

I started with the apm821xx (a PowerPC 464 derivative SoC) back
in 2015-2016 because of the wide availabilty of cheap (as low as $5 ~ $10)
secondhand enterprise accesspoints like the Cisco Meraki MR24
<https://openwrt.org/toh/meraki/mr24>. 

What happen was that cooperations ditched all the outdated 802.11n
devices and upgraded to the shiny new wave1 802.11ac gear. Now, the
old 802.11n devices still worked perfectly fine but the firmware on
the device requires the user to have a valid subscription to a 
"Meraki Cloud License".

And as you can probably guess: The License is sold as a yearly subscription
starting from $150 for a single device. So, these devices became practically
e-waste since nobody in their right mind would buy a used device and then
fork over the ~$150 fee per annum.

The MR24 craze is mostly over by now. You can still find a few. However
some listings are now selling them with OpenWrt/LEDE for ~$40.

And obviously, this cycle will continue on, but now with the old wave1
802.11ac gear that gets replaced. In fact this business has spawned
companies that are actively working on supporting "old" enterprise gear
via their own OpenWrt/LEDE derivatives.

> > In any case, I implemented your suggestion and it does look reasonable.
> > The gpiolib already uses the gpio_offset as an ID of some sorts. For
> > now I went with a simple ID value check, but this could be extended to
> > a range/intersection check if necessary. But then again, let's not
> > overengineer it. Comments are welcome, I'll wait around till sometime
> > next week before I post v3.
> 
> I'm going through my mailbox now, sorry for delays in feedback
> and review :(
I see you skipped v3 and replied to v4.

Best Regards,
Christian Lamparter
