From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Jun 2013 14:06:22 -0600
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <20130617180212.GU20992@atomide.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org> <20130617072021.GB4465@atomide.com>
 <CACRpkdYwGHMznjoJqf5bX_74pmeKSiWtTwpNF1_4GSEk+KwrZA@mail.gmail.com>
 <20130617180212.GU20992@atomide.com>
Message-ID: <51C20F3E.5060302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2013 12:02 PM, Tony Lindgren wrote:
> * Linus Walleij <linus.walleij@linaro.org> [130617 09:11]:
>> On Mon, Jun 17, 2013 at 9:20 AM, Tony Lindgren <tony@atomide.com> wrote:
>>
>>> First, I think the concept of remuxing (or even checking) _all_ the pins
>>> for a consumer device is wrong on most if not all hardware. For past 10
>>> years I have not seen a case where _all_ the pins for a device would need
>>> to be remuxed for any reason.
>>
>> We may be talking past each other here. On the ux500 we use a lot
>> of runtime pincontrol, but none of this is *remuxing*.
>>
>> We are only *reconfiguring*.
> 
> Hmm routing the signal to a different device is certainly
> remuxing but yeah configuring pulls etc does not change the
> mux.
>  
>> Now I know that Haojian only recently added pin config to the
>> pinctrl-single.c driver so maybe you have mostly seen muxing
>> in your driver so far, so you view of the world is a bit different.
>>
>> On the Nomadik pin controller we do mostly hogged muxing
>> at boot time, but a lot of runtime reconfiguration. So our
>> needs are very different.
>>
>> Bear in mind that struct pinctl * forks effects in two paths,
>> one is muxing the other is config, like pull-ups etc.
> 
> I also thought the plan was to merge pinmux and pinconf and
> do things based the named modes?

Yes, pinctrl_select_state() simply applies a certain named state. A
named state can include values for both mux settings and pin
configuration values. So, everything is unified under this top-level
API. There's certainly no need (nor allowance for really) drivers to be
touching and pin_config API directly.
