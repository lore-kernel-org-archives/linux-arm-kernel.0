From: utx@penguin.cz (Stanislav Brabec)
Date: Tue, 06 Oct 2009 13:48:52 +0200
Subject: spitz: add gpio button support (AK_INT and remote control
	description)
In-Reply-To: <20091006074635.GA2775@ucw.cz>
References: <20091006074635.GA2775@ucw.cz>
Message-ID: <1254829732.3546.35.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> I'm not sure what AK_INT is, nor what event it should
> generate.

AK_INT: remote control detect

How it should work on spitz:

The default state of ?the remote pin of audio barrel connector is a weak
pull-up.

Button is pressed. => Voltage ?on remote pin decreases. => Hardware
defined threshold voltage is reached. => AK_INT is triggered. => Driver
sets SPITZ_SCP2_AKIN_PULLUP (it connects stronger and more power hungry
pull-up), ignores AK_INT change, sets MAX1111 to channel 0, reads value
from A/D converter.

After some debouncing:

The value is below threshold. => Decode the value and generate input
event.

The value is over threshold. => Switch SPITZ_SCP2_AKIN_PULLUP back,
activate AK_INT interrupt and wait for next edge.

The value is near zero. => ?A standard 3-ring earphone connector seems
to be inserted. AK_INT will be "active" all the time. To save stronger
pull-up power, behave like the value over threshold and ignore AK_INT
until possible next change (remove earphone, insert remote).

Some of these actions should probably cause wake-up. It would be nice to
wake-up sleeping Zaurus by pressing Play button and start to play.

The driver is available e. g. in 2.6.26-RP kernel as
sharpsl-rc-r1.patch. I plan to rewrite it to a generic "resistor matrix
keyboard" and then sent to vanilla.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx
