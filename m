From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 26 Aug 2016 17:12:53 +0530
Subject: [PATCH] ARM: dts: da850: Add missing pin muxing for the UARTs
In-Reply-To: <20160825140507.GA13734@gobelin>
References: <20160804110656.25318-1-kbeldan@baylibre.com>
 <m2eg64pchw.fsf@baylibre.com> <20160804210045.GD15013@gobelin>
 <m2fuqknnqk.fsf@baylibre.com> <fe36e8d1-f371-b093-de15-5e03370ea38c@ti.com>
 <dd4712ba-6144-8c64-59a6-7673936af53c@ti.com>
 <20160824082934.GA20246@gobelin>
 <354081bd-653d-ec98-f18e-eb0b1b1ee7e3@ti.com>
 <20160825140507.GA13734@gobelin>
Message-ID: <cf22ea55-ab23-ca29-fd18-76d51320d3f8@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 August 2016 07:45 PM, Karl Beldan wrote:

>>> Indeed ATM the EVM relies on the bootloader to setup the pin muxing.
>>>
>>> I just checked the uart pins routing of the EVM, the dts:
>>> - should reclaim serial2_rxtx_pins and serial2_rtscts_pins
>>
>> Can you please clarify what you mean by dts should "reclaim". You mean
>> move the pins from da850.dtsi to da850-evm.dts or something else?
>>
> 
> No, in the part you are replying to I am not referring to moving the
> pins but reclaiming them. The pins are declared in the dtsi, as they
> should. Eg. the LCDK dts reclaims serial2_rxtx_pins but doesn't reclaim
> serial2_rtscts_pins while their declarations remain in the dtsi.

Alright. I am not sure if "reclaim" is the right term for this, but it
doesn't matter ;) I understand the intent now.

> The purpose of this part was to clarify what I saw on the schematics
> because your emails include the following 2 statements:
> 
>>>>> Looks like the flow control pins are being used for McASP also on the
>>>>> EVM. So lets leave the EVM as-is.
> 
>>>> Rather, the EVM dts file should be updated to use serial2_rxtx_pins like
>>>> the LCDK. Right now it seems to be relying on bootloader to serial2
> 
> My email was to inform that it concerns the flow control pins of the
> UART1 only and that the UART2 flow control pins are not concerned and, 
> since they are dedicated to the UART2, should be reclaimed unlike
> in the LCDK.

I see now.

I think I was thrown off by looking at the fact that mcasp0_pins in
da850-evm.dts muxes UART2_RTS as AMUTE. But, its the mcasp0_pins that
needs fixing. AMUTE is not used by audio on the board. As is AFSR. Plus,
that pinmux entry goes and writes to PINMIX0[31:28] the value of 0x1
which is reserved. Sigh.

I will review your original e-mail and reply back.

Thanks,
Sekhar
