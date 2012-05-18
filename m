From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 12:00:53 +0100
Subject: [PATCH 12/18] ARM: ux500: Disable platform setup of the ab8500
 when DT is enabled
In-Reply-To: <201205181038.36949.arnd@arndb.de>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <201205172122.05611.arnd@arndb.de> <4FB57482.5060609@linaro.org>
 <201205181038.36949.arnd@arndb.de>
Message-ID: <4FB62BE5.7030003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/12 11:38, Arnd Bergmann wrote:
> On Thursday 17 May 2012, Lee Jones wrote:
>>> I think the two options you have here are to either remove the ab8500 device from
>>> mop500_platform_devs[] too (essentially registering mop500_gpio_keys_device
>>> and ab8500_device separately when you need them, instead of doing the loop),
>>> or to split u8500_local_bus_nodes so you use a different table for snowball
>>> from the one you use for the other boards.
>>
>> It's late here, so if I have the wrong end of the stick, just tell me ..
>>
>> I figure that at the same time as enabling the other machines we'll be
>> stripping out the platform registrations in the same way as be have done
>> with Snowball. This will prevent two of anything from being registered
>> at any time.
>>
>> Or am I mistaken?
>
> Well, as far as I can tell, you duplicated a lot of functions or
> data structures so you can remove the parts one by one, but when you
> duplicated snowball_platform_devs[] you did not also duplicate
> mop500_platform_devs[].

That's true, but why would I have done? I would think that whoever 
writes the DT for that platform would do that?

So I see four ways round this: 1) disable all the nodes in db8500.dtsi 
and force snowball.dts and mop500.dts et. al to re-enable them as 
appropriate. 2) duplicate mop500_platform_devs[] for DT booting and 
strip out the ab8500 entry, essentially only leaving in only
mop500_gpio_keys_device, 3) DT gpio-keys for the mop500 and do away with 
platform_add()ing mop500_platform_devs[] in u8500_init_machine() 
altogether. Or my personal favorite 4) as there is no DT or compatible 
entry for st-ericsson,mop500 or st-ericsson,hrefv60+ yet, don't worry 
about it and let whoever enables DT for those platforms (me?) to deal 
with at a later date.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
