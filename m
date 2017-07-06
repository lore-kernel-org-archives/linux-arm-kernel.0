From: Claudiu.Beznea@microchip.com (m18063)
Date: Thu, 6 Jul 2017 10:31:04 +0300
Subject: [PATCH v2 4/5] ARM: dts: at91: at91-sama5d27_som1: add sama5d27
 SoM1 support
In-Reply-To: <a74f9110-ced4-5412-8ed2-f57f65557f7e@microchip.com>
References: <1499086572-6083-1-git-send-email-claudiu.beznea@microchip.com>
 <1499086572-6083-5-git-send-email-claudiu.beznea@microchip.com>
 <20170705152343.b735on6edg3vfsp3@rfolt0960.corp.atmel.com>
 <a74f9110-ced4-5412-8ed2-f57f65557f7e@microchip.com>
Message-ID: <947abe4f-af3a-78de-c800-728b56c53c6b@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05.07.2017 18:29, Nicolas Ferre wrote:
> On 05/07/2017 at 17:23, Ludovic Desroches wrote:
>> On Mon, Jul 03, 2017 at 03:56:11PM +0300, Claudiu Beznea wrote:
>>> Add specific DTS file and bindings for sama5d27 SoM1 board.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
>>> ---
>>>  arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 178 ++++++++++++++++++++++++++++++
>>>  1 file changed, 178 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
>>> new file mode 100644
>>> index 0000000..c3a1dc8
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
>>
>> [...]
>>
>>> +
>>> +			i2c0: i2c at f8028000 {
>>> +				dmas = <0>, <0>;
>>> +				pinctrl-names = "default";
>>> +				pinctrl-0 = <&pinctrl_i2c0_default>;
>>> +				i2c-sda-hold-time-ns = <350>;
>>> +				status = "disabled";
>>> +
>>> +				24aa at 50 {
>>> +					compatible = "24mac602";
>>> +					reg = <0x50>;
>>> +					pagesize = <8>;
>>> +					start-offset = /bits/ 8 <0xf8>;
>>
>> Are you sure about the offset? I thought it was 0xfa but maybe I am
>> wrong.
Indeed, it is 0xfa. I chose 0xf8 because at24 driver will truncate the
eeprom size at something that is power of 2 (I don't know the reason behind
this, maybe it is something historical, maybe it is something I don't get
it for the moment). If I would use 24mac402 (which EEPROM size should be
6 bytes but due to the truncation it will become of 4 bytes) and 0xfa as
starting offset I could read only 4 octets. Due to this I chose to use
24mac602 which length is 8 = 2^3 bytes, the reading will start from 0xf8
but the first 2 bytes will not be of interest.
Sorry that I forgot to mention this in the cover letter.

> 
> Moreover, as the binding for this is not yet accepted I would advice to
> remove this part for now. It will be easier for synchronization with i2c
> eeprom.
Yes, I will remove this part form in the 3rd version.

Thanks,
Claudiu
> 
> Best regards,
> 
