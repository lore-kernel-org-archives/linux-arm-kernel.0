From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 24 May 2012 09:22:13 -0600
Subject: [PATCH RFC v3 3/3] pinctrl: add pinctrl gpio binding support
In-Reply-To: <20120524051946.GA14953@shlinux2.ap.freescale.net>
References: <1337779362-31259-1-git-send-email-b29396@freescale.com>
 <1337779362-31259-3-git-send-email-b29396@freescale.com>
 <4FBD4C13.8080209@wwwdotorg.org>
 <CAA+hA=Rb1Qix67QBthPjo_4d5ATWjA7pePembZRwJkPMtQNpjg@mail.gmail.com>
 <4FBDBC2B.3090300@wwwdotorg.org>
 <20120524051946.GA14953@shlinux2.ap.freescale.net>
Message-ID: <4FBE5225.301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2012 11:19 PM, Dong Aisheng wrote:
> On Thu, May 24, 2012 at 12:42:19PM +0800, Stephen Warren wrote:
>> On 05/23/2012 07:42 PM, Dong Aisheng wrote:
>>> On Thu, May 24, 2012 at 4:44 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> On 05/23/2012 07:22 AM, Dong Aisheng wrote:
>>>>> From: Dong Aisheng <dong.aisheng@linaro.org>
>>>>>
>>>>> This patch implements a standard common binding for pinctrl gpio ranges.
>>>>> Each SoC can add gpio ranges through device tree by adding a gpio-maps property
>>>>> under their pinctrl devices node with the format:
>>>>> <&gpio $gpio_offset $pin_offset $npin>.
>>>>>
>>>>> Then the pinctrl driver can call pinctrl_dt_add_gpio_ranges(pctldev, node)
>>>>> to parse and register the gpio ranges from device tree.
...
>>>> Re: your locking comments in your other email: ranges[i].gc doesn't
>>>> appear to be used anywhere else in pinctrl, so I think it's OK not to
>>>> lock the GPIO chip for any more time than between the above two blocks
>>>> of code.
>>>
>>> So i will add lock between them like:
>>> ranges[i].gc = of_node_to_gpiochip(np_gpio);
>>> if (!try_module_get(ranges[i].gc->owner))
>>>     err...
>>
>> I think that module_get() needs to happen inside of_node_to_gpiochip(),
>> so that it executes inside any lock that function takes.
>
> Can you please help explain a bit more?
> I did not quite understand.
> It looks to me of_node_to_gpiochip is only convert the gpio node to gpio chip.
> Why need get the module inside this function?
> For gpio_request function, it also calls try_module_get(gc) after find the gpio
> chip.

The problem is this:

Thread 1: Call of_node_to_gpiochip(), returns a gpio_chip.
Thread 2: Unregisters the same gpio_chip that was returned above.
Thread 1: Accesses the now unregistered (and possibly free'd) gpio_chip
-> at best, bad data, at worst, OOPS.

In order to prevent this, of_node_to_gpiochip() should take measures to
prevent another thread from unregistering the gpio_chip until thread 1
has completed its step above.

The existing of_get_named_gpio_flags() is safe from this, since
gpiochip_find() acquires the GPIO lock, and all accesses to the fouond
gpio chip occur with that lock held, inside the match function. Perhaps
a similar approach could be used here.

>>>> Finally, just a minor nit:
...
>>>> could be slightly simpler:
...
>>> Because here still uese np_gpio,  Can i still use it after of_node_put?
>>
>> Oh right, that makes sense, yes.
>>
> I guess you mean no(can not use the node after of_node_put), right?

I mean the original code in your patch is fine.
