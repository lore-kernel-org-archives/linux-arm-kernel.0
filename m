From: stigge@antcom.de (Roland Stigge)
Date: Fri, 20 Apr 2012 17:35:38 +0200
Subject: [PATCH RESEND v3] iio: Add device tree support to LPC32xx ADC
In-Reply-To: <4F917AE3.7050808@metafoo.de>
References: <1334932713-19231-1-git-send-email-stigge@antcom.de>
 <4F917AE3.7050808@metafoo.de>
Message-ID: <4F91824A.10207@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/20/2012 05:04 PM, Lars-Peter Clausen wrote:
>> --- /dev/null
>> +++ linux-2.6/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
>> @@ -0,0 +1,16 @@
>> +* NXP LPC32xx SoC ADC controller
>> +
>> +Required properties:
>> +- compatible: must be "nxp,lpc32xx-adc"
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +- interrupts: The ADC interrupt
>> +
>> +Example:
>> +
>> +	adc at 40048000 {
>> +		compatible = "nxp,lpc32xx-adc";
> 
> In my opinion it seems to be a bad idea to use wildcard names in devicetree
> compatible strings.

In the above case, the situation is as follows:

* NXP has LPC3220, LPC3230, LPC3240 and LPC3250 (differing in SRAM size
  and in the existence of its Ethernet and LCD controllers)
* The ADC controller is present in every single one of those
* We already have "lpc32xx" in the kernel everywhere
* Current state is that NXP isn't planning to issue LPC32xx without ADC
* I'm providing a lpc32xx.dtsi file to be used by all LPC32xx variants.
  This one is referencing the above "compatible" string. Splitting up
  in all possible numbers (see below) doesn't help much, here.

What would you prefer?

+static const struct of_device_id lpc32xx_adc_match[] = {
+       { .compatible = "nxp,lpc3220-adc" },
+       { .compatible = "nxp,lpc3230-adc" },
+       { .compatible = "nxp,lpc3240-adc" },
+       { .compatible = "nxp,lpc3250-adc" },
+       {},
+};

?

What is a better strategy here?

Thanks in advance,

Roland
