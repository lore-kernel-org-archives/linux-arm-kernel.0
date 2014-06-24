From: dianders@chromium.org (Doug Anderson)
Date: Tue, 24 Jun 2014 08:20:30 -0700
Subject: [RFC 4/4] ARM: dts: exynos5250: Add Spring device tree
In-Reply-To: <53A94DA1.50703@collabora.co.uk>
References: <1403486483-4063-1-git-send-email-afaerber@suse.de>
 <1403486483-4063-5-git-send-email-afaerber@suse.de>
 <CAD=FV=WHAqASC+bp8mGVnhfr79F5LapJCTLtSfgUG8XuRUSCqw@mail.gmail.com>
 <53A8AE4C.6080702@suse.de>
 <CAD=FV=W96QpDhh1NSaVwrXYjL6Jr-v4sq1-eRSfT=tErw_KCOQ@mail.gmail.com>
 <53A94DA1.50703@collabora.co.uk>
Message-ID: <CAD=FV=VEVwPzW4hdR1kSdZS741Hn6VnDr+yXetTPsN4hEym2xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Tue, Jun 24, 2014 at 3:06 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Doug,
>
> On 06/24/2014 06:05 AM, Doug Anderson wrote:
> Another option is to identify DTS fragments that are common across boards and
> create .dtsi files for these specific chunks instead of trying to group all set
> of common things on a single .dtsi file.
>
> For example, a quite common design for OMAP2+ based boards is to use a SMSC LAN
> chip connected to OMAP's General-Purpose Memory Controller (GPMC). So the
> following files were created to reduce DTS duplication:
>
> arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
>
> Now that I think about it, is the same that what you did for
> arm/boot/dts/cros-ec-keyboard.dtsi.
>
> Maybe splitting exynos5250-cros-common.dtsi in a set of .dtsi files will make it
> more flexible/reusable?

Yes, I think the config fragments can be cleaner but I think we have
to be judicious about using them.  There are definitely tradeoffs
involved.  The keyboard was such an excessively large thing and
totally duplicated, so moving it out made sense.  Other bits are less
obvious (to me) because there are so many interactions / combinations
and you end up with a bit of spaghetti in terms of which labels are
used by and provided by each fragment.  I guess possibly you could
codify that better...

A few thoughts looking at exynos5420-peach-pit:

* backlight: seems (?) too board specific
* samsung,exynos5420-oscclk: could totally be a fragment, but very small.
* power key: could be a fragment for all boards that happen to use
gpx1-2 for this
* sound: could be a fragment for all devices using
"google,snow-audio-max98090", possibly.


> Personally I think that "status = [enabled | disabled]" only makes sense for IP
> blocks that are part of the SoC but may or may not be used by a board (e.g: i2c
> and spi buses, sdhci and usb host controllers, etc).
>
> DTS should be a description of the hardware so I agree that having a disabled
> node for a device that is not present in the board is not right.

Right.  We'll take a look again in v2 when cros-common isn't used.  I
think this could go in steps:
1. Don't use cros-common for spring
2. Don't use cros-common for snow (fold stuff in)
3. Introduce some fragments.
