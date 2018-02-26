From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 27 Feb 2018 00:13:36 +0100
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
Message-ID: <20180226231336.GA18565@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2018-02-26 16:02:22, Daniel Baluta wrote:
> On Mon, Feb 26, 2018 at 3:13 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> JFYI: This issues is tracked in the regression reports for Linux 4.16
> >> (http://bit.ly/lnxregrep416 ) with this id:
> >>
> >> Linux-Regression-ID: lr#4b650f
> >
> > Ok, so it seems that issue is bigger: whole sound subsystem does not
> > work. /proc/asound/cards is empty.
> >
> > 7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.
> >
> > I tried to revert sound/soc changes, and sound is broken, too. Nasty
> 
> 
> dmesg log?

Partial dmesg is at:
https://github.com/pavelmachek/missy/blob/master/db/phone/nokia/n900/pavel/2018.1291171648263/dmesg.out

I should be able to get full one...

I did git bisect, and the winner seems to be:

pavel at duo:/data/l/linux-n900$ git bisect bad
c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
commit c85823390215e52d68d3826df92a447ed31e5c80
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Wed Dec 27 16:37:44 2017 +0100

    gpio: of: Support SPI nonstandard GPIO properties

    Before it was clearly established that all GPIO properties in the
        device tree shall be named "foo-gpios" (with the deprecated
        variant
	    "foo-gpio" for single lines) we unfortunately merged a few
        bindings
	    which named the lines "gpio-foo" instead.

    This is most prominent in the GPIO SPI driver in Linux which names
        the lines "gpio-sck", "gpio-mosi" and "gpio-miso".

    As we want to switch the GPIO SPI driver to using descriptors, we
        need devm_gpiod_get() to return something reasonable when
        looking
	    up these in the device tree.

    Put in a special #ifdef:ed kludge to do this special lookup only
        for the SPI case and gets compiled out if we're not enabling
        SPI.
	    If we have more oddly defined legacy GPIOs like this, they
        can be
	    handled in a similar manner.

    Reviewed-by: Rob Herring <robh@kernel.org>
        Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Unfortunately, it does not seem to revert cleanly on my v4.16 branch.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180227/c36cb621/attachment-0001.sig>
