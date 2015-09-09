From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 9 Sep 2015 17:32:42 +0200
Subject: Almost certainly confirmed, sun7i-a20 does not support 8 bit mmc.
In-Reply-To: <20150909143038.GE9885@lukather>
References: <55F02E4B.70708@schinagl.nl> <20150909143038.GE9885@lukather>
Message-ID: <55F0511A.8060803@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-09-15 16:30, Maxime Ripard wrote:
> On Wed, Sep 09, 2015 at 03:04:11PM +0200, Olliver Schinagl wrote:
>> Hey all,
>>
>> After experimenting with a Micron eMMC chip, I made some interesting finds I
>> wanted to share with you all.
>>
>> For a while now, some had hopes or guessed that the A20 could have support
>> for 8 bit wide bused on the SDC2. Reason for thinking this was, because the
>> sun7i uses the same IP as the sun5i which does support 8 bit wide eMMC. The
>> usermanual does mention 1/4/8 bit data buses and jedec 4.3 support of the
>> MMC spec. Unfortunately so far, it appears that the extra data pins have not
>> been muxed out to the PC pads.
>>
>> I used the following code to enable the extra pins on the A20:
>>                          mmc2_pins_a: mmc2 at 0 {
>> -                               allwinner,pins = "PC6", "PC7", "PC8",
>> -                                                "PC9", "PC10", "PC11";
>> +                               allwinner,pins = "PC6", "PC7",
>> +                                                "PC8", "PC9", "PC10",
>> "PC11",
>> +                                                "PC12", "PC13", "PC14",
>> "PC15";
>>
>> and
>>          SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
>>                    SUNXI_FUNCTION(0x0, "gpio_in"),
>>                    SUNXI_FUNCTION(0x1, "gpio_out"),
>> -                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ4 */
>> +                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ4 */
>> +                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D4 */
>>          SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
>>                    SUNXI_FUNCTION(0x0, "gpio_in"),
>>                    SUNXI_FUNCTION(0x1, "gpio_out"),
>> -                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ5 */
>> +                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ5 */
>> +                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D5 */
>>          SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
>>                    SUNXI_FUNCTION(0x0, "gpio_in"),
>>                    SUNXI_FUNCTION(0x1, "gpio_out"),
>> -                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ6 */
>> +                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ6 */
>> +                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D6 */
>>          SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
>>                    SUNXI_FUNCTION(0x0, "gpio_in"),
>>                    SUNXI_FUNCTION(0x1, "gpio_out"),
>> -                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ7 */
>> +                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ7 */
>> +                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D7 */
>
> Where did you get that info from ? Those pins have never been reported
> as having the mmc2 function, which would explain why it doesn't work.

Right, but the A20 has the same mmc controller as the A13, which does
do 8 bit mmc on PORTC, and the datasheet advertises 8 bit bus width
support in its feature list. So this was worth a shot.

Regards,

Hans
