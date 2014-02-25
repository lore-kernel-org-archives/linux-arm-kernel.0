From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Feb 2014 15:38:50 -0700
Subject: [PATCH] ARM: tegra: add device tree for SHIELD
In-Reply-To: <530BFC58.6020003@nvidia.com>
References: <1393237593-28121-1-git-send-email-acourbot@nvidia.com>
 <530B952D.2000006@wwwdotorg.org> <530BFC58.6020003@nvidia.com>
Message-ID: <530D1B7A.9070209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2014 07:13 PM, Alexandre Courbot wrote:
> On 02/25/2014 03:53 AM, Stephen Warren wrote:
>> On 02/24/2014 03:26 AM, Alexandre Courbot wrote:
>>> Add a device tree for NVIDIA SHIELD. The set of enabled features is
>>> still minimal with no display option (although HDMI should be easy
>>> to get to work) and USB requiring external power.

>>> diff --git a/arch/arm/boot/dts/tegra114-roth.dts
>>> b/arch/arm/boot/dts/tegra114-roth.dts
>>
>>> +    memory {
>>> +        reg = <0x80000000 0x79600000>;
>>
>> It might be worth a comment here pointing out that the rest of RAM is
>> reserved for some carveouts/..., or at least that these values are set
>> this way in order to match what the bootloader usually passes to
>> downstream kernels in the command-line?
> 
> Yes, absolutely right. On a more general note I feel like DTs could gain
> clarity if they had more comments (e.g. for pinmuxing which are a quite
> heavy block otherwise), do you have any objection to this? (I guess not,
> but so far the rule seems to be "no comment in DT" :P )

I have no objection in particular. Specifically for pinmux, the values
seem pretty obvious, so I'm not sure what extra the comment could
convey, but I'll take a look at any proposed patch:-)

>>> +    /* Wifi */
>>> +    sdhci at 78000000 {
>>> +        status = "okay";
>>> +        bus-width = <4>;
>>> +        broken-cd;
>>> +        keep-power-in-suspend;
>>> +        cap-sdio-irq;
>>
>> Is non-removable better than broken-cd, or are they entirely unrelated?
> 
> They are unrelated actually. With non-removable the driver expects the
> device to always be there since boot, and does not check for the card to
> be removed/added after boot. broken-cd indicates there is no CD line and
> the device should be polled regularly.

It doesn't sound like that's what we want either; we should know exactly
when the device is added/removed, based on when the relevant
clocks/supplies/... are turned on/off.

> For the Wifi chip, non-removable would be the correct setting
> hardware-wise, but there is a trap: the chip has its reset line asserted
> at boot-time, and you need to set GPIO 229 to de-assert it. Only after
> that will the device be detected on the SDIO bus. Since it lacks a CD
> line, it must be polled, hence the broken-cd property.

How does that GPIO get manipulated right now? I assume you must be
manually configuring it via sysfs after boot or something? If so,
perhaps it's best to just leave out the WiFi node until it works
automatically.

> This also raises another, redundant problem with DT bindings: AFAIK we
> currently have no way to let the system know the device will only appear
> after a given GPIO is set. It would also be nice to be able to give some
> parameters to the Wifi driver through the DT (like the OOB interrupt).
> Right now the Wifi chip is brought up by exporting the GPIO and writing
> to it from user-space, and the OOB interrupt is not used.

There was a thread on this topic on LAKML recently. I didn't really
follow it, so I don't know if there was a useful resolution. I think it
was "mmc: add support for power-on sequencing through DT", although
there may have been other related threads. It was possibly tangentially
related to power-sequences-in-DT...

...
> I'm not sure about cap-sdio-irq, it doesn't seem to make a difference
> for SHIELD Wifi.

I'd tend to leave it out then.
