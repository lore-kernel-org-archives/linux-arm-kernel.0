From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Apr 2015 10:40:05 +0200
Subject: [RFC PATCH 0/4] pinctrl: prototyping a per pin mux approach
In-Reply-To: <1427967496-22533-1-git-send-email-ludovic.desroches@atmel.com>
References: <1427967496-22533-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150414084005.GT9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 11:38:12AM +0200, Ludovic Desroches wrote:
> 
> Hi,
> 
> Here is an implementation of what I need for the future at91 pin controller.
> The pinctrl driver is a draft made for a sama5d4 in order to test it. 
> It is not clean and many things are missing but I think it will be easier to
> debate on code.
> 
> From the discussion with Sascha, it seems that we agree that current pinctrl
> doesn't fit the needs of controllers who have per pin muxing because the
> concepts of groups is not real.
> In my opinion, even if groups are not real it is quite convenient to use them
> at least for debug sysfs.
> 
> The new at91 pin controller is close to Mediatek one. I am not totally happy
> with their solution since a group is describing a pin. It is probably the
> easiest way to do it but it doesn't fit my needs. I have two constraints:
> 
> - I want something readable in sysfs as:
> 
> device fc000000.mmc
> state default
> type MUX_GROUP (2)
> controlling device ahb:apb:pinctrl at fc06a000
> group mci1_0_4bit
> function C
> 
> device fc000000.mmc
> state default
> type CONFIGS_PIN (3)
> controlling device ahb:apb:pinctrl at fc06a000
> pin PE19
> config 00010003
> 
> I don't want to have a group named as a pin.
> 
> - I want to perform some verifications on user choices. A concept of ioset is
> introduced. An ioset is a set of pins dedicated to a device. A device can have
> several iosets. For example we can have i2c0 ioset1 with pins PA0 and PA1 and
> i2c0 ioset2 with pins PE10 and PE11. The controller has no knowledge about
> iosets. It means I could take the i2c data signal from ioset1 and the i2c
> clock signal from ioset2 BUT validation has been done only per ioset. For
> devices such as i2c it should not be a problem but it could be for other ones
> such as mci, isi, etc.
> 
> - I don't want big tables describing pins in my driver. It represents a huge
> amount of code mainly useless in the case of a multiplatform image.

This is needed due to some misdesign in the pinctrl core that's just,
sorry, braindamaged. The pinctrl core forces you to parse a device node
(which your driver perfectly understands) into a struct pinctrl_map.
This struct contains a struct pinctrl_map_mux which contains a group and
a function as strings. With the help of the driver struct pinctrl_map is
converted to struct pinctrl_setting which basically contains the same
information, but with a struct pinctrl_setting_mux which contains a
group and a function as integers. Instead of passing this data back to
the driver to act upon the structs are shred into pieces and passed to
the driver as individual variables.

So to recap the pinctrl core forces you to parse your data from the
device node into a format not native to the driver, then uses the
drivers help to convert this data in yet another format which it then
passes back to the driver in little pieces. Note that the pinctrl core
doesn't even use all this data except for requesting pins and for
generating debugfs entries.  These debugfs entries even often contain
useless information because neither struct pinctrl_map nor struct
pinctrl_setting are suitable for storing information for per-pin
controllers. Most drivers only put some information in there to find the
informations back the device node already contained.

A sane approach would just let the driver parse the data from a device
node into a cookie which is then passed back to the driver to be
activated. The driver would then be free to store whatever information
it needs in this cookie. The driver just request the necessary pins
itself from the pinctrl core instead of letting the core doing it.

I know this is not the answer you were looking for, but the pinctrl core
in my eyes is a big midlayer mistake and I'm not very fond of stretching
this concept further to be able to live with it for another round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
