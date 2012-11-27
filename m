From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 27 Nov 2012 06:20:55 -0800
Subject: [PATCH v4 05/11] pwm: pwm-tiecap: pinctrl support
In-Reply-To: <20121124203423.GA26951@avionic-0098.adnet.avionic-design.de>
 (Thierry Reding's message of "Sat, 24 Nov 2012 21:34:23 +0100")
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-6-git-send-email-avinashphilip@ti.com>
 <20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9EE991@DBDE01.ent.ti.com>
 <20121123105110.GA6884@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9EEAAA@DBDE01.ent.ti.com>
 <20121123111811.GA5072@avionic-0098.adnet.avionic-design.de>
 <87mwy8eb7w.fsf@dell.be.48ers.dk>
 <20121124203423.GA26951@avionic-0098.adnet.avionic-design.de>
Message-ID: <87txsb160o.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Thierry" == Thierry Reding <thierry.reding@avionic-design.de> writes:

Hi,

 >> There's several different situations:
 >> 
 >> - Platform without pinctrl support
 >> - Platform with pinctrl support but no pinmux specified in dt for device
 >> (E.G. pinmux setup in bootloader)
 >> - Pinmux specified in dt
 >> - Some kind of misconfiguration in dt
 >> 
 >> You could argue that devm_pinctrl_get_select_default() shouldn't return
 >> an error for the first situation, but how should it be able to know the
 >> difference between 2 and 4?

 Thierry> In case where the platform supports pinctrl but no pinmux is specified
 Thierry> for the device it should just assume that no pinmuxing is needed. That
 Thierry> sounds like the most logical behaviour to me. In those cases pinctrl
 Thierry> could just assume that the default has already been selected and not
 Thierry> return an error.

Agreed.

 Thierry> But you can't reasonably expect to cope with misconfigured DT
 Thierry> content.  Heck, there's no way for you to even know if it is
 Thierry> misconfigured.

With 'misconfigured DT' I just mean any kind of real error.


 Thierry> That said, I'm not sure how much of an issue this really
 Thierry> is. Pinmuxing is only used for functions local to a given
 Thierry> chip, right? So if an SoC supports pinctrl and a given
 Thierry> peripheral needs pinmuxing then we can reasonably assume that
 Thierry> your second case can't happen, can't we?

Well, peripherals only need pinmuxing if the bootloader didn't already
set it up in advance. We could naturally enforce people to add
"redundant" pinmux info to their .dts files, but I'm not sure I like
that idea.

-- 
Bye, Peter Korsgaard
