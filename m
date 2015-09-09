From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Wed, 09 Sep 2015 17:56:22 +0200
Subject: [linux-sunxi] Re: Almost certainly confirmed, sun7i-a20 does
 not support 8 bit mmc.
In-Reply-To: <55F0511A.8060803@redhat.com>
References: <55F02E4B.70708@schinagl.nl> <20150909143038.GE9885@lukather>
 <55F0511A.8060803@redhat.com>
Message-ID: <55F056A6.3050407@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On 09-09-15 17:32, Hans de Goede wrote:
> Hi,
>
> On 09-09-15 16:30, Maxime Ripard wrote:
>> On Wed, Sep 09, 2015 at 03:04:11PM +0200, Olliver Schinagl wrote:
>>> Hey all,
>>>
>>> After experimenting with a Micron eMMC chip, I made some interesting 
>>> finds I
>>> wanted to share with you all.
>>>
>>> For a while now, some had hopes or guessed that the A20 could have 
>>> support
>>> for 8 bit wide bused on the SDC2. Reason for thinking this was, 
>>> because the
>>> sun7i uses the same IP as the sun5i which does support 8 bit wide 
>>> eMMC. The
>>> usermanual does mention 1/4/8 bit data buses and jedec 4.3 support 
>>> of the
>>> MMC spec. Unfortunately so far, it appears that the extra data pins 
>>> have not
>>> been muxed out to the PC pads.
>>>
>>> I used the following code to enable the extra pins on the A20:
>>>                          mmc2_pins_a: mmc2 at 0 {
>>> -                               allwinner,pins = "PC6", "PC7", "PC8",
>>> -                                                "PC9", "PC10", "PC11";
>>> +                               allwinner,pins = "PC6", "PC7",
>>> +                                                "PC8", "PC9", "PC10",
>>> "PC11",
>>> +                                                "PC12", "PC13", 
>>> "PC14",
>>> "PC15";
>>>
>>> and
>>>          SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
>>>                    SUNXI_FUNCTION(0x0, "gpio_in"),
>>>                    SUNXI_FUNCTION(0x1, "gpio_out"),
>>> -                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ4 */
>>> +                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ4 */
>>> +                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D4 */
>>>          SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
>>>                    SUNXI_FUNCTION(0x0, "gpio_in"),
>>>                    SUNXI_FUNCTION(0x1, "gpio_out"),
>>> -                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ5 */
>>> +                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ5 */
>>> +                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D5 */
>>>          SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
>>>                    SUNXI_FUNCTION(0x0, "gpio_in"),
>>>                    SUNXI_FUNCTION(0x1, "gpio_out"),
>>> -                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ6 */
>>> +                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ6 */
>>> +                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D6 */
>>>          SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
>>>                    SUNXI_FUNCTION(0x0, "gpio_in"),
>>>                    SUNXI_FUNCTION(0x1, "gpio_out"),
>>> -                 SUNXI_FUNCTION(0x2, "nand0")),        /* NDQ7 */
>>> +                 SUNXI_FUNCTION(0x2, "nand0"),         /* NDQ7 */
>>> +                 SUNXI_FUNCTION(0x3, "mmc2")),         /* D7 */
>>
>> Where did you get that info from ? Those pins have never been reported
>> as having the mmc2 function, which would explain why it doesn't work.
>
> Right, but the A20 has the same mmc controller as the A13, which does
> do 8 bit mmc on PORTC, and the datasheet advertises 8 bit bus width
> support in its feature list. So this was worth a shot.
Yeah Hans and I where discussing it a bit off list, and where hoping 
that it could be available. Also the H3 for example exposes the mux.

Hopefully the A40 or whatever the A10 pin compatible upgrade will be 
have these MUXes out. Pin-wise it makes sense as it's the same pins as 
the 8 NAND data pins.

Anyway, I'll go home now to find my Olimex A20-micro, as I may actually 
have one, and run some tests on it for Maxime ;)

Olliver
>
> Regards,
>
> Hans
>
