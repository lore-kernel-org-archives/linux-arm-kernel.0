From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 10:36:41 +0100
Subject: [PATCH] ARM: ux500: Register pinctrl from platform code until
 it's been DT:ed
In-Reply-To: <CACRpkdb1rZQWpuUxQoxqg2eYanf4tnm0SmFkQQBwvSuyYV00Gw@mail.gmail.com>
References: <1341412452-3808-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdb1rZQWpuUxQoxqg2eYanf4tnm0SmFkQQBwvSuyYV00Gw@mail.gmail.com>
Message-ID: <4FF56029.2060007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 09:55, Linus Walleij wrote:
> On Wed, Jul 4, 2012 at 4:34 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> There are some inconsistencies with the way pinctrl devices are named
>> when registered from platform code to the ones registered by Device
>> Tree. Platform devices look like 'pinctrl-db8500', whereas the ones
>> registered from Device Tree look more like 'pinctrl.2'. This leads to
>> failure when carrying out name-based searches for known devices.
>>
>> Until the correct DT bindings have been applied to the pinctrl driver
>> it will fail to function correctly. For instance, during a Device
>> Tree boot on Snowball no bootlog is visible due to a UART port probe
>> failure. Regulators fail in a similar way.
>
> The problem is *NOT* any missing device tree bindings. The place
> where the problem appear is in the pin control mapping table, which
> uses the string "pinctrl-db8500"
>
> The bindings to pass in the pinctrl mapping from the devcie tree
> is generic and already exist:
> Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Yes I saw these, but that still doesn't help our situation. A way to 
link the mapping tables registered with a platform device to the driver 
started with Device Tree is missing. This can be over-come by several 
methods:

a) Create a binding which takes a device name to tag onto a mapping. 
This can be used in the name based searches currently employed by 
pinctrl. This is the binding I was talking about in the commit log. In 
retrospect, I can see that this is not the correct solution.

b) Continue using Device Tree and force the 'pinctrl-db8500' device name 
which any string based searches will be expecting with AUXDATA(). We do 
similar things for clock-names already. However, this must be seen as a 
hacky work-around and it to be removed after full enablement has been 
taken place.

c) Prevent the pinctrl driver from being started by Device Tree and 
allow platform code to register the device until we can populate the 
device tree with all of the mappings. This is the way you advised me to 
do it [see below] and it's what this patch tries to achieve.

Linus said:
> In my eyes the problem is introduced by that commit ["pinctrl-nomadik:
> Allow Device Tree driver probing"]. So I'll revert it and go for a
> complete approach for v3.6

Hopefully now you can see where I'm coming from.

> The stuff in the file:
> arch/arm/mach-ux500/board-mop500-pins.c
>
> Need to be moved over to the device tree.

Agreed, but this patch aims to fix an -rc bug. The full Device Tree 
implementation isn't likely to reach Mainline until at least v3.6, as 
you already mentioned.

 > There are plenty of
> examples of how to do this in for example:
> arch/arm/boot/dts/tegra-seaboard.dts

I don't see this file anywhere?

> So what is needed is that someone augment the device tree
> with the pinctrl data and disable the registration of the static
> maps from the above file if the node exists.

Right, future work.

>> This patch prevents Device Tree from probing the pinctrl driver and
>> ensures registration is completed from platform code instead.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Is the DT machinery really incapable of specifying
> the device name to anything else than the bus name?
> Can't you do this with AUX_DATA()? I've seen that done in the
> past. For example you do:
>
> OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e000, "gpio.0", NULL),
>
> Can't you just:
> OF_DEV_AUXDATA("stericsson,nmk_pinctrl", 0, "pinctrl-db8500", NULL),
>
> And it will happily assign the "pinctrl-db8500" name to it's instantiated
> device?

Yes, this will work, see option 'b' above.

I'll submit another patch.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
