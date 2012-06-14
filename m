From: wni@nvidia.com (Wei Ni)
Date: Thu, 14 Jun 2012 12:17:26 +0800
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <4FD8CED9.6030901@broadcom.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD8CED9.6030901@broadcom.com>
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C377BFFE89@HKMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Franky

On Thu, Jun 14, 2012 at 01:33:13, Franky Lin wrote:
>Hi Wei,
>
>On 06/13/2012 03:40 AM, Wei Ni wrote:
>> In the brcmfmac init routine, it call sdio_register_driver() to 
>> register driver, if the wifi device is powered on, then the mmc
>> driver will enumerate it, and call the probe callback routine.
>>
>> On the Cardhu, the wifi's power is controlled by two gpios 
>> (power-gpio and reset-gpio), the default state is power-off.
>> So we need to power on it before calling sdio_register_driver(),
>> if not, the mmc driver can't enumerate it, and will not call
>> the probe routine.
>> This power on sequence is:
>> set power-gpio to 1 ;
>> mdelay(100) ;
>> set reset-gpio to 1 ;
>> mdelay(200);
>>
>> My question is where to power on the wifi. We may have three places 
>> to power on it:
>> 1. power on it in the brcmfmac driver before calling
>> sdio_register_driver(). But I think this power sequence is special for 
>> tegra30 cardhu, it's not good to add it in the generic wifi driver, 
>> because different board may use the different way to power on the wifi.
>> 2. power on it in the mmc driver. In our tegra SD driver, it has 
>> power-gpios property, which allow the slot to be powered. But this power is 
>> for mmc slot, could we add this wifi power sequence in the tegra SD driver?
>> 3. hard-coded into DT. Set these gpios in the DT, something like 
>> pinmux settings, but in this way, it's not good to put the mdelay() value
>> in the DT.
>
>We introduced oob interrupt support in 3.5 [1]. We are using a virtual 
>platform device to retrieve board specific oob interrupt GPIO setting.
>You should be able to implement the power control in this way as well.
>Brcmfmac gets the GPIOs through platform device interface, powers up 
>the chip and triggers a card detection. Then 4329 should be enumerated 
>by MMC stack. The reason we didn't implement this is the card detection.
>Some design doesn't have hardware card detection since the WiFi chip is 
>already on board. And the current MMC stack doesn't have virtual card 
>detection interface.

Wei: Yes, in OOB mode, it's easy to add a device node in the DT, to pass
the gpio property to brcmfmac driver. But the NO-OOB mode doesn?t use the
virtual platform device, so we can't pass the gpio to driver. We need to find
a way to support these two mode both.
Could we use the virtual platform device both for OOB and NO-OOB mode? so that
we can implement power control in these two mode, and we can add a flags to
control if need to power on or not.
BTW, does that power on sequence is generally for 4329?

>
>Franky
>
>[1]: http://www.spinics.net/lists/linux-wireless/msg89335.html
