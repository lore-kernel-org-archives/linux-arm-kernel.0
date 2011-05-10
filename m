From: bones@secretlab.ca (John Bonesio)
Date: Tue, 10 May 2011 15:33:29 -0700
Subject: [RFC 1/2] ARM: Tegra: Device Tree Support: Update how sdhci
	devices are initialized
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04986AA077@HQMAIL01.nvidia.com>
References: <20110510201108.22693.50319.stgit@riker>	<20110510201414.22693.7427.stgit@riker>	<74CDBE0F657A3D45AFBB94109FB122FF04986AA06A@HQMAIL01.nvidia.com>
	<BANLkTingm7PCJPC-xCremYg_Ab7qFvPSag@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AA077@HQMAIL01.nvidia.com>
Message-ID: <4DC9BD39.30108@secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2011 03:16 PM, Stephen Warren wrote:
> Olof Johansson wrote at Tuesday, May 10, 2011 4:07 PM:
>>> On Tue, May 10, 2011 at 3:03 PM, Stephen Warren <swarren@nvidia.com> wrote:
>>> John Bonesio wrote at Tuesday, May 10, 2011 2:14 PM:
>>>> This patch changes how sdhci devices are initialized so that a later
>>>> patch can easily add support for i2c devies.
>>>>
>>>> +static struct tegra_sdhci_platform_data sdhci_pdata1 = {
>>>> +     .cd_gpio        = -1,
>>>> +     .wp_gpio        = -1,
>>>> +     .power_gpio     = -1,
>>>> +};
>>>> +
>>> So I understand why board-dt is itself registering the SDHCI platform
>>> devices itself; so that the pdev initialization path is identical
>>> between fully hard-coded boards and board-dt.c.
>>>
>>> However, I'm surprised that we would include the platform data for
>>> those devices within that argument; if we do that, we'll end up needing
>>> different platform data for every board, and devicetree won't have
>>> bought us anything.
>>>
>>> In other words, I understood that board-dt would register all the
>>> platform devices within Tegra, but not set up any of the plataform
>>> data, and the device drivers for those devices would be updated to
>>> get their platform data from devicetree if available, then fall back
>>> to old-style platform data. In other words, the way the SDHCI drivers
>>> work today in the devicetree/test branch.
>>>
>>> If my understanding is correct, shouldn't the chunk above and the
>>> one below be removed?
>>
>> That's if we cut everything over, I think. until then, this code should
>> fill in the platform_device and register it. But the values should come
>> from the device tree, and it should only register the controllers that are
>> in the tree (and not marked as disabled).
> 
> But doesn't that require board-dt.c to walk and parse the devicetree,
> extract the platform data from the DT, and fill in the platform data
> structures? I thought we'd explicitly talked about that and decided that
> was a bad idea, since it'd duplicate each driver's DT parsing into
> board-dt.c?
> 

The goal I'm working towards right now is to have the platform specific
code continue to register the devices that are inside the SoC. Then use
the device tree to register all other on board devices.

This patch doesn't accomplish the whole goal in one step, but gets the
code a little closer toward this goal.

To accomplish the goal, nodes need to be in the device tree for the
devices inside the SoC. This is then used to attach device tree nodes to
the existing devices - gives us a "hook" on which to "hang" the board
specific devices. There is only one device tree used, so everything
needs to be connected into the same device tree.

These patches just get the i2c controller and driver instantiated. This
includes having the platform code to register the i2c controller in the
"normal" fashion. This patch also gets a device tree node attached to
the i2c device.

A following patch, which I'll send later this week/early next week, will
instantiate the wm8903 audio codec device solely from the device tree.

Hopefully this makes the plan a little clearer. Let me know if you have
any questions.

- John
