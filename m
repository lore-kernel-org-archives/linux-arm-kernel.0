From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jul 2014 17:22:08 +0100
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
In-Reply-To: <1405095403.667469987@f367.i.mail.ru>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
 <20140711160238.GD21766@n2100.arm.linux.org.uk>
 <1405095403.667469987@f367.i.mail.ru>
Message-ID: <20140711162208.GF21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 08:16:43PM +0400, Alexander Shiyan wrote:
> Fri, 11 Jul 2014 17:02:38 +0100 ?? Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Fri, Jul 11, 2014 at 08:34:19AM -0700, Tim Harvey wrote:
> > > I've noticed that for IMX6 the gpio-mxc gpio driver always returns 0
> > > for gpio's configured as outputs regardless of if they are outputing
> > > high or low.
> > 
> > There's a different way which this can be solved - set the SION but on
> > your GPIOs.  You will then be able to read back the state of the
> > output pin.
> 
> AFAIK, SION is not affected for pins configured as GPIO.
> Please FIX ME if my opinion is wrong.

SION forces the input path to the GPIOs to be enabled, meaning you can
read the actual state of the pin.

I've ended up setting that on several GPIOs used for regulator control
on iMX6 so that I can see their output state in /sys/kernel/debug/gpio,
otherwise I can't read back their output states.  It appears to work
there:

GPIOs 0-31, platform/209c000.gpio, 209c000.gpio:
 gpio-0   (usb_h1_vbus         ) out lo
 gpio-2   (gpio-ir-recv        ) in  hi
 gpio-4   (2194000.usdhc cd    ) in  lo

GPIOs 32-63, platform/20a0000.gpio, 20a0000.gpio:

GPIOs 64-95, platform/20a4000.gpio, 20a4000.gpio:
 gpio-83  (brcm_reg            ) out hi
 gpio-86  (usb_otg_vbus        ) out lo

GPIOs 96-127, platform/20a8000.gpio, 20a8000.gpio:
 gpio-111 (phy-reset           ) out lo

GPIOs 128-159, platform/20ac000.gpio, 20ac000.gpio:
 gpio-133 (brcm_osc_reg        ) out hi
 gpio-154 (card-reset          ) out hi

GPIOs 160-191, platform/20b0000.gpio, 20b0000.gpio:
 gpio-160 (card-reset          ) out hi

GPIOs 192-223, platform/20b4000.gpio, 20b4000.gpio:


-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
