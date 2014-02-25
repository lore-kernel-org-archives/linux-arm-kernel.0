From: arend@broadcom.com (Arend van Spriel)
Date: Tue, 25 Feb 2014 10:52:52 +0100
Subject: [PATCH] ARM: tegra: add device tree for SHIELD
In-Reply-To: <530BFC58.6020003@nvidia.com>
References: <1393237593-28121-1-git-send-email-acourbot@nvidia.com>
 <530B952D.2000006@wwwdotorg.org> <530BFC58.6020003@nvidia.com>
Message-ID: <530C67F4.7010208@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2014 03:13 AM, Alexandre Courbot wrote:
>>
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
> 
> For the Wifi chip, non-removable would be the correct setting
> hardware-wise, but there is a trap: the chip has its reset line asserted
> at boot-time, and you need to set GPIO 229 to de-assert it. Only after
> that will the device be detected on the SDIO bus. Since it lacks a CD
> line, it must be polled, hence the broken-cd property.
> 
> This also raises another, redundant problem with DT bindings: AFAIK we
> currently have no way to let the system know the device will only appear
> after a given GPIO is set. It would also be nice to be able to give some
> parameters to the Wifi driver through the DT (like the OOB interrupt).
> Right now the Wifi chip is brought up by exporting the GPIO and writing
> to it from user-space, and the OOB interrupt is not used.

Hi Alexandre,

I recently posted a proposal for brcmfmac DT binding [1]. I did receive
some comments, but it would be great if you (and/or others involved) had
a look at it as well and give me some feedback. DT work still needs to
grow on me.

> Otherwise, Wifi works great with the brcmfmac driver and NVRAM file
> extracted from Android.

With in-band interrupts, indeed. The HOST_WAKE signal is the OOB
interrupt which would need to be provided in the device-tree.

Regards,
Arend

[1] http://mid.gmane.org/1392059868-8782-1-git-send-email-arend at broadcom.com
