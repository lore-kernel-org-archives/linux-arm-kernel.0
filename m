From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 20 Sep 2018 07:44:27 +0200
Subject: [PATCH 2/2] pinctrl: bcm: add Northstar driver
In-Reply-To: <da0992c4-f8c8-7e3c-6d54-35a8cfdcd7bc@gmail.com>
References: <20180919210219.21921-1-zajec5@gmail.com>
 <20180919210219.21921-2-zajec5@gmail.com>
 <da0992c4-f8c8-7e3c-6d54-35a8cfdcd7bc@gmail.com>
Message-ID: <b14fda92-14a1-0da7-02bf-758fa3751abe@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/19/18 11:45 PM, Florian Fainelli wrote:
> On 09/19/2018 02:02 PM, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> This driver provides support for Northstar mux controller. It differs
>> from Northstar Plus one so a new binding and driver were needed.
>>
>> Right now it includes support for SPI pins only which is caused by a
>> lack of access to Broadcom's datasheet. SPI pins info was extracted from
>> the Broadcom's SDK. Once more pins are discovered they can be added to
>> the driver without breaking any existing setups.
>>
>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>> ---
> 
> [snip]
> 
>> +static const struct pinctrl_pin_desc ns_pinctrl_pins[] = {
>> +	{ 0, "spi_clk" },
>> +	{ 1, "spi_ss" },
>> +	{ 2, "spi_mosi" },
>> +	{ 3, "spi_miso" },
>> +};
> 
> In case you are interested, here are the additional functions:
> 
> 4: i2c_scl
> 5: i2c_sda
> 
> 6: mdc
> 7: mdio
> 
> 8: pwm0
> 9: pwm1
> 10: pwm2
> 11: pwm3
> 
> 12: uart1_rx
> 13: uart1_tx
> 14: uart1_cts
> 15: uart1_rts
> 
> On BCM53012:
> 
> 16: uart2_rx
> 17: uart2_tx
> 22: sdio_card_power_ctl
> 23: sdio_en_1p8
> 
> On BCM53013:
> 
> 21: 25Mhz crystal output for I2S

I believe what you provided are name of bits in the cru_genpll_control0
register. FWIW that info would be part of ns_pins_data rather than
ns_pinctrl_pins.

I was aware of most of them thanks to analyzing bcm5301x_dmu.c from the
SDK but some are still new to me, so thanks for that!

What I'm really missing are SoC pin numbers for all above. E.g. what
hardware pin number is used for the uart2_rx? Or sdio_card_power_ctl?
And all the other ones.

If you could provide that info it'd be extremely helpful.

***

If you take a look at pinctrl-nsp-mux.c, you'll see that there isn't 1:1
mapping used on Broadcom platforms.

E.g. Northstar Plus has SoC pins 4 and 5 used for I2C:
i2c_pins[] = {4, 5};
but they are controlled by BIT(3) and BIT(4) of the BASE0 register:
NSP_PIN_GROUP(i2c, NSP_MUX_BASE0, 3, 0x03, 0x00),
(0x03 << 3)

Another NSP example: SoC pins 16 and 17 are used for UART2:
uart2_pins[] = {16, 17};
but they are controlled by BIT(15) and BIT(16) of the BASE0 register:
NSP_PIN_GROUP(uart2, NSP_MUX_BASE0, 15, 0x03, 0x00),
(0x03 << 15)

Of course, some pins map 1:1, e.g. pin 26 for LED of switch port 5:
switch_p05_led0_pins[] = {26};
maps nicely to BIT(26) of the BASE0 register:
NSP_PIN_GROUP(switch_p05_led0, NSP_MUX_BASE0, 26, 0x01, 0x01),
(0x01 << 26)
but it clearly isn't a rule.
