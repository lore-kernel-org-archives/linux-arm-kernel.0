From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 8 Sep 2016 11:18:08 +0200
Subject: [PATCH 3/3] soc: ti: Add ti_sci_pm_domains driver
In-Reply-To: <57CF26DB.4020807@ti.com>
References: <20160819235653.26355-1-nm@ti.com>
 <20160819235653.26355-4-nm@ti.com>
 <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ@mail.gmail.com>
 <57C0D2C9.1030801@ti.com> <57C5E1DA.2040405@ti.com>
 <CAPDyKFqszM48nXnnA9D8iCp34k-ZmNvOkHPCc=Fya4nJA7PvBQ@mail.gmail.com>
 <57CF26DB.4020807@ti.com>
Message-ID: <CAPDyKFrjJYMX_+JT_L8hO75hDnKm+LYuQY6rGTDO02s2Z5vcOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>> Here are some ideas which could be used to solve the problem differently.
>>
>> *)
>> Assuming each platform device has a driver for it!?
>> Then why don't you implement the ->runtime_suspend|resume() callbacks
>> on the driver level and call the SCI interface to power on/off the
>> device from there? This ought to be the most straight forward
>> solution.
>
>
> Straightforward yes but not a realistic option as we are using shared
> drivers from other platforms so sticking in platform specific code won't
> work.

Agree, but...

Historically, I think this was *one* of the reasons to why omap's
hw_mod PM domain was invented.
At that point we did not have the common clk framework, the pinctrl
framework, the phy framework, syscon, etc. These device resources can
now be handled by the drivers themselves via generic interfaces and
thus they remains to be portable.

My point is, let's be sure you don't drop this approach unless it's
really SoC specific code needed to deal with the device.

>
>>
>>
>> **)
>> You may also use genpd's (struct generic_pm_domain)
>> ->attach|detach_dev() callbacks to create the device specific data
>> (the SCI device ID). The ->attach_dev() callback are invoked when a
>> device gets attached to its PM domain (genpd) at probe time.
>>
>> Currently these callbacks are already being used by SoCs that uses the
>> PM clk API from a genpd client. That is needed to create the device
>> specific PM clock list. We would have to do something similar here for
>> the SCI device IDs.
>>
>> Then, you must also assign/implement the ->start() and ->stop()
>> callbacks of the struct gpd_dev_ops, which is a part of the genpd
>> struct. These callbacks can then easily invoke SoC specific code/APIs
>> and perhaps that is the issue with my first suggested approach!?
>
>
> I've taken a look at what you have suggested here and I think it could work
> for us, thanks for the suggestion, I will give it a shot, I think that this
> will work just as well from a functional perspective.

Okay, great!

>
>>
>>>
>>> Based on the ID set provided in patch 2 of this series I see 12 gaps, so
>>> we'd be wasting space the size of 12 genpds. The ID mapping will change
>>> on
>>> future SoCs, so this number could be larger. Do you think this is an
>>> acceptable solution? It allows us to play nice with the new genpd
>>> framework
>>> changes at the cost of wasting some space allocated to filler genpds.
>>
>>
>> There are other issues as well, which mostly has do to with a
>> unnecessary long execution path, involving taking mutexes etc in
>> genpd.
>>
>> All you actually need, is to be able to power on/off a device from a
>> driver's ->runtime_suspend|resume() callback. Don't you think?
>
>
> Yes, but I thought the point of these frameworks was that they let us avoid
> doing it manually with platform specific code inside the drivers. I'll look
> at the callbacks in the genpd framework instead, that seems like a good
> place to do it.

BTW, as you would need to store your device specific data somewhere,
we probably need to extend the struct pm_subsys_data or the "struct
pm_domain_data", to hold a "void *data".

Kind regards
Uffe
