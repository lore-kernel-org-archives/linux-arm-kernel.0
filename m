From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Sep 2012 13:44:57 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <201209191325.50048.marex@denx.de>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
 <201209191250.54418.marex@denx.de> <5059A660.9080302@free-electrons.com>
 <201209191325.50048.marex@denx.de>
Message-ID: <5059B039.2050406@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/09/2012 13:25, Marek Vasut a ?crit :
>> Le 19/09/2012 12:50, Marek Vasut a ?crit :
>>>> Le 19/09/2012 05:15, Shawn Guo a ?crit :
>>>>> On Wed, Sep 19, 2012 at 12:37:17AM +0200, Marek Vasut wrote:
>>>>>> Don't load the FEC MAC address from OCOTP, but use the one supplied
>>>>>> via device tree by U-Boot. This is the preferred way, every DT-capable
>>>>>> bootloader does set up "mac-address" and "local-mac-address"
>>>>>> properties into the DT passed to the kernel.
>>>>>
>>>>> Ok, since you are the maintainer of m28evk board, it could be your call
>>>>> to do so.  While for imx28-evk, the kernel at least runs with bootlets
>>>>> which is not DT capable.
>>>>>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>>>>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>>>>> ---
>>>>>>
>>>>>>  arch/arm/mach-mxs/mach-mxs.c |    2 --
>>>>>>  1 file changed, 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/mach-mxs/mach-mxs.c
>>>>>> b/arch/arm/mach-mxs/mach-mxs.c index 170a930..71d47f5 100644
>>>>>> --- a/arch/arm/mach-mxs/mach-mxs.c
>>>>>> +++ b/arch/arm/mach-mxs/mach-mxs.c
>>>>>> @@ -255,8 +255,6 @@ static void __init imx28_evk_post_init(void)
>>>>>>
>>>>>>  static void __init m28evk_init(void)
>>>>>>  {
>>>>>>
>>>>>> -	update_fec_mac_prop(OUI_DENX);
>>>>>> -
>>>>>
>>>>> Since it's the only user of OUI_DENX, can we remove enum mac_oui
>>>>> completely and make update_fec_mac_prop a fsl specific call?
>>>>
>>>> I have a patch on the way that adds the Crystalfontz OUI for the
>>>> CFA-10049, so it will be quite useful to me in the future.
>>>
>>> Do you use U-Boot on that board?
>>
>> No, we use barebox for it. And since the CFA-10049 is an expansion board
>> to the CFA-10036, we only have support for the CFA-10036 in barebox, and
>> support the devices present in the CFA-10049 through loading a different
>> device tree.
>>
>> So basically, I'd like to avoid to get the mac from the ocotp in
>> barebox, since I won't need it if the CFA-10049 isn't plugged in.
>>
>> Moreover, I've found no clue that barebox adds the local-mac-address or
>> the mac-address fields to the device tree, so this assumption seems
>> quite u-boot specific.
> 
> I dunno what barebox is, but it seems really crap. Don't use crap. The "mac-
> address" and "local-mac-address" nodes must be set up by the bootloader, if 
> barebox or whatever doesn't set it, it's broken.

I'm pretty sure this will bring a nice troll :)

> U-Boot did that since PPC days (so basically all PPCs do that). And the FDT got 
> onto ARM from PPCs. And FEC was used on PPCs too, thus I see no point to diverge 
> on ARM from this method that was coined by years of development. It's no recent 
> whim nor in any way non-standard.

This is a good feature, I don't doubt that. But by removing the ocotp
reading from linux, you also remove the ability for a vendor to store
the MAC in the OCOTP if it's board uses a bootloader that doesn't read
the OCOTP and doesn't handle the device tree properly.

Basically, every bootloader except U-boot. Even the bootlets from
Freescale, even another random bootloader using an appended device tree,
etc.

I'm sorry, I disagree on the total removal of the update_fec_mac_prop
function. But I get your point, and I have no objection to your current
patch actually. The only thing I'm saying is please, don't remove it for
everyone.

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
