From: steev@genesi-usa.com (Steev Klimaszewski)
Date: Thu, 20 Dec 2012 10:34:31 -0600
Subject: devicetree support for efikasb
In-Reply-To: <20121219085643.GW26326@pengutronix.de>
References: <20121217075907.GQ24458@pengutronix.de>
 <87licwdikj.fsf@lebrac.rtp-net.org>
 <20121217115016.GN26326@pengutronix.de>
 <878v8wdgv1.fsf@lebrac.rtp-net.org>
 <87fw3364au.fsf@lebrac.rtp-net.org>
 <20121219085643.GW26326@pengutronix.de>
Message-ID: <CA+Bgp3PsDc3bQT7_Qxok1cfC4m5ACx=5G-hdAOK2Jcp90NMNdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

I've given the patchset a (very) quick once over, but both myself and
Arnaud have tested PATA - any chance you could push them to the ata mailing
list to get accepted (I believe that's where they belong) - Feel free to
add my Tested-By: and Arnaud said his as well.


On Wed, Dec 19, 2012 at 2:56 AM, Sascha Hauer <s.hauer@pengutronix.de>wrote:

> On Tue, Dec 18, 2012 at 11:30:17AM +0100, Arnaud Patard wrote:
> > Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:
> > Hi,
> >
> >
> > >>
> > >>>
> > >>> >
> > >>> > I'm not posting the patches here since I do not consider them
> ready, but
> > >>> > for everyone interested you can pull the following git tree. I
> have no
> > >>> > idea if the patches work together with the preinstalled U-Boot, I
> use
> > >>> > barebox on the Smartbook.
> > >>>
> > >>> I've (very quickly) tested it yesterday and it didn't even boot. I've
> > >>> yet to look at the serial port output to check if it's a problem on
> my
> > >>> side or a bug in the kernel.
> > >>
> > >> Do you mean barebox doesn't boot or the kernel doesn't boot?
> > >
> > > No idea. All I get is a black screen, so I need to look at the serial
> > > output. Oh, it's uboot not barebox btw. Sorry for the confusion.
> >
> > After digging a little bit, turns out that someone failed to make sure
> > that clocks are enabled before reading/writing some
> > registers. imx51_ipu_mipi_setup() is called very early in the boot and
> > it's way before the clocks are enabled. So, as the clock is not enabled
> > when booting on my sb, it's freezing hard. A quick hack to move the call
> > to the end of mx51_clocks_init() allows to boot.
>
> Shawn already noticed this. A fix should appear soon in mainline.
>
> >
> > Then, I'm getting a oops. i2c doesn't seem to work (maybe related to
> > Matt and Steev remarks about pinctrl settings) so the edid is not found
> > and when the mtl017 driver is trying to fall back, it falls back the the
> > edid which may be provided by the dts. As it's not the case, it's
> > crashing at the memcmp() call. With a new test to check that, I can boot
> > on my mmc.
> >
> > PATA is detected too but usb doesn't detect anything on the bus.
> >
> > Next steps will probably be something like checking mtl017/lvds,lcd
> > gpios/regulators/pinctrl and then look at usb.
>
> This is probably because I'm using barebox. The i2c pinmux is probably
> configured in the bootloader correctly. That should be easy to fix.
> USB may be more work though...
>
> >
> > Oh, btw, the smartbook have only 512M of ram, not 1G so you need to fix
> > that in your dts file.
>
> Will do. The bootloader fixes that for me currently, so I didn't realize
> this.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>



-- 
Best Regards,
Steev

Steev Klimaszewski <steev@genesi-usa.com>
Senior Software Engineer, Genesi USA, Inc.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121220/a53d6641/attachment-0001.html>
