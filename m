From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 18:24:01 +0100
Subject: [PATCH] RFC: pinctrl: grab default handler with bus notifiers
In-Reply-To: <20121115152652.44c567d5@skate>
References: <1352636539-6318-1-git-send-email-linus.walleij@stericsson.com>
 <50A15A54.3090803@wwwdotorg.org>
 <20121113063546.GD18224@opensource.wolfsonmicro.com>
 <CACRpkdY-tye5LNOwxQ-XrjM-x9RffAvj-tPfsFQA3ZWOY8P-Vw@mail.gmail.com>
 <20121115152652.44c567d5@skate>
Message-ID: <CACRpkdaXCA9ZDbkGTtdtFBWLhBKQmPf1=EgnLhUSqKOT1xU7oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 3:26 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> At ELCE, I've discussed with one person having an interesting use case:
> they are using the same pin for two different purposes during the
> system operation.
>
> At boot time, this pin is muxed as a SPI pin and is used to program the
> bitstream of a FPGA. This is done in Linux, through a userspace
> application.
>
> Then, once it is done, this pin is remuxed as a UART pin, and used to
> communicate with another device on the board.

This is not related to the current discussion but interesting
anyway...

> If the pinctrl configuration is done at probe() time inside the driver
> core, then how can this kind of use case be supported? If each driver
> does its own muxing, we could think of letting the SPI and UART driver
> only do their muxing when the device is opened, and remove their muxing
> when the device is closed, so that such sharing of pins for two
> separate functions could be supported. Is this something we want to
> support?

This is trivial to support after this commit in the current patch
queue:
commit 1a78958dc212f3698fdc543857af80155cb30f7f
pinctrl: reserve pins when states are activated

Just define function maps for both devices using the same
pins. Since the devices need to actively release their
pins they need to go to a state which does not mux in
any pins, so that the pins will be free:ed.

This state can be any arbitrary string, but if so desired
for consistency we can define something like
#define PINCTRL_STATE_DECOUPLED "decoupled"
in include/linux/pinctrl/pinctrl-state.h to clearly
mark that this is a state where the device is not
using any pins at all.

Yours,
Linus Walleij

Yours,
Linus Walleij
