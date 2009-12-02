From: derkling@gmail.com (Patrick Bellasi)
Date: Wed, 2 Dec 2009 10:11:03 +0100
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
In-Reply-To: <20091201155908.GF18841@game.jcrosoft.org>
References: <20091129234917.GB18841@game.jcrosoft.org>
	<1259574486-13391-1-git-send-email-derkling@gmail.com>
	<1259574486-13391-2-git-send-email-derkling@gmail.com>
	<cd73a99e0911301236pd18a382o6faa04c15b3bf9c@mail.gmail.com>
	<aa8983610912010058j738df89fyd75e9e75973e94ed@mail.gmail.com>
	<20091201155908.GF18841@game.jcrosoft.org>
Message-ID: <aa8983610912020111j2f88cc6bg383c15ef756c5f56@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 1, 2009 at 4:59 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
>> >> @@ -83,6 +83,7 @@ struct at91_eth_data {
>> >> ? ? ? ?u32 ? ? ? ? ? ? phy_mask;
>> >> ? ? ? ?u8 ? ? ? ? ? ? ?phy_irq_pin; ? ?/* PHY IRQ */
>> >> ? ? ? ?u8 ? ? ? ? ? ? ?is_rmii; ? ? ? ?/* using RMII interface? */
>> >> + ? ? ? u8 ? ? ? ? ? ? ?use_twi_pins; ? /* ETX2-ETX3 on PA23-PA24 */
>> >> ?};
>> >
> except here the TWI description is incorrect as you do not care about the twi
> when you configured the MACB as I can want to use the two pin for something
> else than I2C. So we need to describe want we want to do about the MACB and
> not a possible alternated functionnality.

Maybe I am misunderstanding what you are complaining about.
However let me try to explain better the intent.

A board code use the "use_twi_pins" in the configuration of the
behaviours of the MACB.
Thus, this read as: "I need a MACB which use the pins that can be used
for the TWI too".
Of course, I'm not caring about TWI during MACB configuration, I'm
just giving an input to the soc-specific code to say: "please route my
 ETX2-ETX3 signals to the same pins where the TWI's are".
This should be a quite clear statement because in this specific SoC
(at91sam9260) the TWI hardware block can be attached only to these
pins. To be even more clear, I suggested to ifdef the use_twi_pins to
allow its usage only on the at91sam9260 SoC, that is the only one
where the statement "I need a MACB which use the pins that can be used
for the TWI too" makes sense.

If I want to use the two pins for something else, no problems: I'll
not define use_twi_pins=1 on my MACB configuration, and this (correct
me if I'm wrong) will turn out to be equivalent to set use_twi_pins=0,
and I'll setup these pins somewhere else in the board code.

I hope to have been more clear in describing the intent of this new member.
Put in these terms: what do you think?

> Best Regards,
> J.
Bye Patrick
