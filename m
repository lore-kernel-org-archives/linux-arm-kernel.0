From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 18 Dec 2012 11:30:17 +0100
Subject: devicetree support for efikasb
In-Reply-To: <878v8wdgv1.fsf@lebrac.rtp-net.org> (Arnaud Patard's message of
 "Mon, 17 Dec 2012 13:04:50 +0100")
References: <20121217075907.GQ24458@pengutronix.de>
 <87licwdikj.fsf@lebrac.rtp-net.org>
 <20121217115016.GN26326@pengutronix.de>
 <878v8wdgv1.fsf@lebrac.rtp-net.org>
Message-ID: <87fw3364au.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:
Hi,


>>
>>> 
>>> >
>>> > I'm not posting the patches here since I do not consider them ready, but
>>> > for everyone interested you can pull the following git tree. I have no
>>> > idea if the patches work together with the preinstalled U-Boot, I use
>>> > barebox on the Smartbook.
>>> 
>>> I've (very quickly) tested it yesterday and it didn't even boot. I've
>>> yet to look at the serial port output to check if it's a problem on my
>>> side or a bug in the kernel.
>>
>> Do you mean barebox doesn't boot or the kernel doesn't boot?
>
> No idea. All I get is a black screen, so I need to look at the serial
> output. Oh, it's uboot not barebox btw. Sorry for the confusion.

After digging a little bit, turns out that someone failed to make sure
that clocks are enabled before reading/writing some
registers. imx51_ipu_mipi_setup() is called very early in the boot and
it's way before the clocks are enabled. So, as the clock is not enabled
when booting on my sb, it's freezing hard. A quick hack to move the call
to the end of mx51_clocks_init() allows to boot.

Then, I'm getting a oops. i2c doesn't seem to work (maybe related to
Matt and Steev remarks about pinctrl settings) so the edid is not found
and when the mtl017 driver is trying to fall back, it falls back the the
edid which may be provided by the dts. As it's not the case, it's
crashing at the memcmp() call. With a new test to check that, I can boot
on my mmc.

PATA is detected too but usb doesn't detect anything on the bus.

Next steps will probably be something like checking mtl017/lvds,lcd
gpios/regulators/pinctrl and then look at usb.

Oh, btw, the smartbook have only 512M of ram, not 1G so you need to fix
that in your dts file.

Arnaud
