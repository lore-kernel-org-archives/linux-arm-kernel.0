From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 28 Oct 2013 19:15:32 +0200
Subject: [PATCH 4/4] wl1251: spi: add device tree support
In-Reply-To: <FF34C626-4A49-43B1-B0AD-DC6146ABBB11@codeaurora.org>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-5-git-send-email-sre@debian.org>
 <FF34C626-4A49-43B1-B0AD-DC6146ABBB11@codeaurora.org>
Message-ID: <CANOLnOP=antQDwQLxWhuB8+-kZh9x-JJXrXmOz3FH67fM2Lang@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 8:37 AM, Kumar Gala <galak@codeaurora.org> wrote:
> On Oct 27, 2013, at 11:14 AM, Sebastian Reichel wrote:
> > +++ b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
> > @@ -0,0 +1,36 @@
> > +* Texas Instruments wl1251 controller
> > +
> > +The wl1251 chip can be connected via SPI or via SDIO. The linux
> > +kernel currently only supports device tree for the SPI variant.
> > +
>
> From the binding I have no idea what this chip actually does, also we don't normally reference linux kernel support in bindings specs (so please remove it).
>
> However, what would expect the SDIO binding to look like?  Or more specifically, how would you distinguish the SPI vs SDIO binding/connection?  I'm wondering if the compatible should be something like "ti,wl1251-spi" and than the sdio can be "ti,wl1251-sdio"

When connected to SDIO, it doesn't act as standard SDIO device and
can't be probed (standard SDIO registers missing), so information has
to come some other way. That used to partially come through
platform_data and partially through a callback from mmc subsystem (see
pandora_wl1251_init_card() in
arch/arm/mach-omap2/board-omap3pandora.c). I don't know much about DT,
but maybe the information that comes from SDIO registers on "normal"
SDIO devices should come through DT in this case too? I don't really
know how that should be integrated with mmc subsystem though..

> > +Required properties:
> > +- compatible : Should be "ti,wl1251"
>
> reg is not listed as a required prop.
>
> > +- interrupts : Should contain interrupt line
> > +- interrupt-parent : Should be the phandle for the interrupt
> > +  controller that services interrupts for this device
> > +- vio-supply : phandle to regulator providing VIO
> > +- power-gpio : GPIO connected to chip's PMEN pin
>
> should be vendor prefixed: ti,power-gpio
>
> > +- For additional required properties on SPI, please consult
> > +  Documentation/devicetree/bindings/spi/spi-bus.txt
> > +
> > +Optional properties:
> > +- ti,use-eeprom : If found, configuration will be loaded from eeprom.
>
> can you be a bit more specific on what cfg will be loaded.  Also, is this property a boolean, if so how do I know which eeprom the cfg is loaded from (is it one that is directly connected to the wl1251?

wl1251 is a wifi chip that can have an optional eeprom connected to it
to store things like calibration stuff and MAC address, and that
eeprom is usually inside a single module with some additional radio
related chips. If the eeprom is connected (like the module on pandora
board has), the driver can issue command to the firmware running on
chip to load that data on it's startup, alternatively the driver can
load calibration from other storage (like it happens on N900).


Gra?vydas
