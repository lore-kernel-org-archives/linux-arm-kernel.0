From: arend@broadcom.com (Arend van Spriel)
Date: Wed, 26 Feb 2014 22:10:12 +0100
Subject: [PATCH] ARM: tegra: add device tree for SHIELD
In-Reply-To: <530D731B.5050305@nvidia.com>
References: <1393237593-28121-1-git-send-email-acourbot@nvidia.com>
 <530B952D.2000006@wwwdotorg.org> <530BFC58.6020003@nvidia.com>
 <530C67F4.7010208@broadcom.com> <530D731B.5050305@nvidia.com>
Message-ID: <530E5834.4070805@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2014 05:52 AM, Alexandre Courbot wrote:
> On 02/25/2014 06:52 PM, Arend van Spriel wrote:
>> On 02/25/2014 03:13 AM, Alexandre Courbot wrote:
>>>>
>>>>> +    /* Wifi */
>>>>> +    sdhci at 78000000 {
>>>>> +        status = "okay";
>>>>> +        bus-width = <4>;
>>>>> +        broken-cd;
>>>>> +        keep-power-in-suspend;
>>>>> +        cap-sdio-irq;
>>>>
>>>> Is non-removable better than broken-cd, or are they entirely unrelated?
>>>
>>> They are unrelated actually. With non-removable the driver expects the
>>> device to always be there since boot, and does not check for the card to
>>> be removed/added after boot. broken-cd indicates there is no CD line and
>>> the device should be polled regularly.
>>>
>>> For the Wifi chip, non-removable would be the correct setting
>>> hardware-wise, but there is a trap: the chip has its reset line asserted
>>> at boot-time, and you need to set GPIO 229 to de-assert it. Only after
>>> that will the device be detected on the SDIO bus. Since it lacks a CD
>>> line, it must be polled, hence the broken-cd property.
>>>
>>> This also raises another, redundant problem with DT bindings: AFAIK we
>>> currently have no way to let the system know the device will only appear
>>> after a given GPIO is set. It would also be nice to be able to give some
>>> parameters to the Wifi driver through the DT (like the OOB interrupt).
>>> Right now the Wifi chip is brought up by exporting the GPIO and writing
>>> to it from user-space, and the OOB interrupt is not used.
>>
>> Hi Alexandre,
>>
>> I recently posted a proposal for brcmfmac DT binding [1]. I did receive
>> some comments, but it would be great if you (and/or others involved) had
>> a look at it as well and give me some feedback. DT work still needs to
>> grow on me.
> 
> Hi Arend, (and thanks again for all the help with getting the chip to
> work!)
> 
> Great, I'm not subscribed to the devicetree list and so have missed this
> thread, but I'm glad to see it.
> 
> I don't think I have much to add to the comments you already received
> there. I'd need it to reference the 32K clock (which I currently
> force-enable manually), the OOB interrupt, and the reset pin as a GPIO
> (as for SHIELD the device needs to be put out of reset using an
> active-low GPIO before anything can happen). That last property could be
> optional as I suspect most designs won't use it.
> 
> Getting the device out of reset should be done before the bus probes the
> non-removable device, so I wonder how this would fit wrt. the DT
> power-on sequencing series by Olof. Something tells me this could rather
> be a property of the bus, but physically speaking the pin is connected
> to the wifi chip, so... Maybe we could get the platform driver to ask
> the bus to probe again after enabling power/getting the device out of
> reset?

Actually, brcmfmac provides a platform driver and a sdio driver. At the
end of the platform probe it registers the sdio driver, which will
trigger the bus to probe again. I am not sure how that would relate to
the DT power-on sequencing you mentioned.

Regards,
Arend
