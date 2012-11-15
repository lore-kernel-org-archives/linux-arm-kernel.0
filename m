From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 15:26:52 +0100
Subject: [PATCH] RFC: pinctrl: grab default handler with bus notifiers
In-Reply-To: <CACRpkdY-tye5LNOwxQ-XrjM-x9RffAvj-tPfsFQA3ZWOY8P-Vw@mail.gmail.com>
References: <1352636539-6318-1-git-send-email-linus.walleij@stericsson.com>
 <50A15A54.3090803@wwwdotorg.org>
 <20121113063546.GD18224@opensource.wolfsonmicro.com>
 <CACRpkdY-tye5LNOwxQ-XrjM-x9RffAvj-tPfsFQA3ZWOY8P-Vw@mail.gmail.com>
Message-ID: <20121115152652.44c567d5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Thu, 15 Nov 2012 15:03:40 +0100, Linus Walleij wrote:

> > I have to say that I agree with this, notifiers seem to make life more
> > complicated for limited gain.  Otherwise I guess we could enhance
> > notifiers so that they're able to trigger deferrals?
> 
> OK I'll have to come up with a patch to the device core
> instead... it'll be much simpler anyway and if both of you guys
> can back it I guess Greg might be OK with it too.

At ELCE, I've discussed with one person having an interesting use case:
they are using the same pin for two different purposes during the
system operation.

At boot time, this pin is muxed as a SPI pin and is used to program the
bitstream of a FPGA. This is done in Linux, through a userspace
application.

Then, once it is done, this pin is remuxed as a UART pin, and used to
communicate with another device on the board.

If the pinctrl configuration is done at probe() time inside the driver
core, then how can this kind of use case be supported? If each driver
does its own muxing, we could think of letting the SPI and UART driver
only do their muxing when the device is opened, and remove their muxing
when the device is closed, so that such sharing of pins for two
separate functions could be supported. Is this something we want to
support?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
