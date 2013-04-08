From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon, 8 Apr 2013 18:42:39 +0530
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <515C5C76.3080009@wwwdotorg.org>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org>
Message-ID: <CA+V-a8t3wtP77DdeUoQHKMjAuWmV+ude+1J3UjJmMTqobgStjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Sorry for the delayed response, I was a holiday.

On Wed, Apr 3, 2013 at 10:14 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/03/2013 03:16 AM, Prabhakar Lad wrote:
>> Hi Linus/Stephen,
>>
>> I am working adding  DT nodes for DA850.
>>
>> Following is the pin control snippet of da850.dtsi:-
>>
>>               pmx_core: pinmux at 1c14120 {
> ...
>>                         i2c0_pins: pinmux_i2c0_pins {
>>                                 pinctrl-single,bits = <
>>                                         /* I2C0_SDA,I2C0_SCL */
>>                                         0x10 0x00002200 0x0000ff00
>>                                 >;
>>                         };
>>                         mdio_pins: pinmux_mdio_pins {
>>                                 pinctrl-single,bits = <
>>                                         /* MDIO_CLK, MDIO_D */
>>                                         0x10 0x00000088 0x000000ff
>>                                 >;
>>                         };
>>                 }
>>
>> And following is the code snippet for dts:-
>>
>>               i2c0: i2c at 1c22000 {
>>                       status = "okay";
>>                       clock-frequency = <100000>;
>>                       pinctrl-names = "default";
>>                       pinctrl-0 = <&i2c0_pins>;
>>               };
>>               mdio: mdio at 1e24000 {
>>                       status = "okay";
>>                       bus_freq = <2200000>;
>>                       pinctrl-names = "default";
>
> I assume there's also the following there:
>
>                         pinctrl-0 = <&mdio_pins>;
>
Yes missed it :)

>>               };
>>
>> But while booting I see the following boot log:-
>> ...
>> cpuidle: using governor menu
>> TCP: cubic registered
>> NET: Registered protocol family 17
>> pinctrl-single 1c14120.pinmux: pin 1c14130 already requested by
>> davinci_mdio.0; cannot claim for i2c_davinci.1
>> pinctrl-single 1c14120.pinmux: pin-4 (i2c_davinci.1) status -22
>> pinctrl-single 1c14120.pinmux: could not request pin 4 on device pinctrl-single
>> console [netcon0] enabled
>> ....
>>
>> This is because the mdio and i2c are using same pin 0x10,
>
> How can two devices use the same pin? I mean physically, in hardware?
>
> Is this because pinctrl-single uses the register address as the pin
> number, whereas you have registers which configure multiple pins at

Yes you are correct, we have registers  which configure multiple pins at once.
For example for above Pin Multiplexing Control 4 Register (Pinmux4)
[1] page(250) : -

PINMUX4_31_28 --> SP1_SCS[2]/UART1_TXD/SATA_CP_POD/GP1[0] Control
PINMUX4_27_24 --> SPI1_SCS[3]/UART1_RXD/SATA_LED/GP1[1] Control
PINMUX4_23_20 --> SPI1_SCS[4]/UART2_TXD/I2C1_SDA/GP1[2] Control
PINMUX4_19_16 --> SPI1_SCS[5]/UART2_RXD/I2C1_SCL/GP1[3] Control
PINMUX4_15_12 --> SPI1_SCS[6]/I2C0_SDA/TM64P3_OUT12/GP1[4] Control
PINMUX4_11_8 --> SPI1_SCS[7]/I2C0_SCL/TM64P2_OUT12/GP1[5] Control
PINMUX4_7_4 --> SPI0_SCS[0]/TM64P1_OUT12/GP1[6]/MDIO_D/TM64P1_IN12 Control
PINMUX4_3_0 --> SPI0_SCS[1]/TM64P0_OUT12/GP1[7]/MDIO_CLK/TM64P0_IN12 Control

> once? If so, your hardware isn't something that can be represented by
> pinctrl-single.
>
What is the alternative for such case ? any pointer would be helpful.

[1] http://www.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=spruh77a&fileType=pdf

Regards,
--Prabhakar
