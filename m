From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 13:12:19 -0600
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <20130621062552.GI5523@atomide.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org> <20130617072021.GB4465@atomide.com>
 <51C20E3A.8090304@wwwdotorg.org> <20130620063823.GD5523@atomide.com>
 <51C3577E.6040709@wwwdotorg.org> <20130621062552.GI5523@atomide.com>
Message-ID: <51C4A593.6000900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 12:25 AM, Tony Lindgren wrote:
> * Stephen Warren <swarren@wwwdotorg.org> [130620 12:32]:
>> On 06/20/2013 12:38 AM, Tony Lindgren wrote:
>>> * Stephen Warren <swarren@wwwdotorg.org> [130619 13:08]:
>>>> On 06/17/2013 01:20 AM, Tony Lindgren wrote:
>> ...
>>>>> Below are the pin remuxing cases I'm aware of:
>>>> ...
>>>>> Then for dealing with the above examples, I think we already have a
>>>>> pretty good setup in pinctrl framework to deal with this with the
>>>>> named modes. But I think that to do this properly with the named
>>>>> modes we should have named modes like the following:
>>>>>
>>>>> "static" && ("active" || "idle")
>>>>> "static" && ("rx" || "tx")
>>>>>
>>>>> Here the "static" pins would be set during driver probe and never
>>>>> need to change until the driver is unloaded. This is close to what we
>>>>> currently call "default". But we should probably make it clear that
>>>>> these will not change to avoid confusion. See below for more info.
>>>>>
>>>>> The the non-static states like "active"/"idle", or "rx"/"tx", can
>>>>> be set in addition to "static", but they should not be subsets of
>>>>> "static" to avoid the issues Stephen described earlier. This way we
>>>>> allow the named modes to do the work for us while protecting the
>>>>> claimed pins.
>>>>
>>>> Yes, I think this can certainly work conceptually. It's equivalent to
>>>> pre-computing which parts of the overall state don't change between the
>>>> currently-defined "global" active/idle states and then applying the
>>>> diffs at runtime - rather like what I suggested before, but without the
>>>> pinctrl code having to do the diff at runtime. I'm not sure if I have
>>>> (yet) a strong opinion on whether allowing multiple states to be active
>>>> at once (i.e. static plus active) is the correct way to go. Maybe once
>>>> I've finished reading the thread...
>>>
>>> I don't think there's any issue for having multiple sets active the same
>>> is an issue, we're already doing it quite a bit although for different
>>> device drivers so we have the framework ready for that already.
>>
>> I assume you mean there shouldn't be any issue *modifying* the pinctrl
>> API to allow multiple states to be active at once? And where you're
>> talking about having multiple sets active at once already, you're
>> talking about some other API?
> 
> Nope, the standard pinctrl API. At least I have not seen issues with
> having multiple states active the same time in a single driver.

Please take a look at the implementation of pinctrl_select_state(). It
very explicitly performs the following steps:

1) Find all pins(groups) that are used in the current state but not the
new state, and execute pinctrl_disable_setting() on them. (For mux
settings only, not pin config, since the core doesn't have any idea how
to reverse config settings).

2) For all settings in the new state, apply those settings.

So, it very explicitly only allows a single state to be set at a time.
Equally, p->state (the field which stores the currently selected state)
is a single item, not a set/list/array.

So, this code needs rework if you want the core to support the concept
of having multiple states active at once, since it needs separate
pinctrl_activate_state() and pinctrl_deactivate_state() APIs, in order
to avoid step (1) above. And of course, p->state would need to be a
set/list/array.

>> Right now, pinctrl_select_state() de-activates the old state while
>> activating the new state, so it's not possible to have more than one
>> active at once.
> 
> That should be fine if the hardware needs it. The "static" (or "default")
> state can stay active continuously, and "active" and "idle" states are
> not subsets of "static".
> 
> Then flipping between "active" and "idle" states is fine as they cover
> the same pins, and only either "active" or "idle" state is selected at
> a time.
> 
> If the hardware needs to de-activate the old state inbetween the change
> from "active" to "idle", that should be just fine.

Well, I'm not saying the code couldn't be written to do that. It may
even be the right thing to do. However, I'm just pointing out that it
would need conceptual/semantic changes to the pinctrl API and
implementation.

> If there are other issues with de-activating pins, then let me know.
> I'm not be seeing the issue with de-activating states as pinctrl-single
> does not de-activate anything for omap. The disable call gets called
> between the state changes though, so hardware needing de-activating
> can specify it.
