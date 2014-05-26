From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 26 May 2014 14:35:48 +0200
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
In-Reply-To: <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
 <1401101131.4829.29.camel@weser.hi.pengutronix.de>
 <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
Message-ID: <1401107748.4829.39.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 26.05.2014, 16:36 +0530 schrieb Viresh Kumar:
> On 26 May 2014 16:15, Lucas Stach <l.stach@pengutronix.de> wrote:
> > This driver handles the i.MX5 specific clock reparenting to be able to
> > reprogramm the PLL. cpufreq-cpu0 can only change a postdivider of the
> > PLL, which means we can't reach the exact OPP frequencies and can not
> > profit from the additional power savings of a slower running PLL.
> >
> > Also without reprogramming the PLL we could possibly not scale to the
> > highest OPPs if the bootloader left the PLL at a slower rate. This is
> > the case for many i.MX53 boards, as the CPU regulator normally does
> > start up with the voltage required for 800MHz operation. If the
> > bootloader decides to not touch the regulator and set the PLL to 800MHz
> > the 1GHz and 1.2GHz operating points won't be useable.
> 
> Almost all users of cpufreq-cpu0 has such situations and they have
> written a clock-driver for "cpu clock" to get this fixed. And they handle
> all this PLL stuff in clk_set_rate() for this new clock..
> 
> I still couldn't find anything so special here that can't be fixed this way.
> There is no point adding and maintaining a cpufreq driver if we can
> use cpufreq-cpu0.

Ok I can push down the clock handling into the imx5 clk driver.

This leaves two more differences between imx5-cpufreq and cpufreq-cpu0:

1. Disabling of OPPs that could not be supported by the connected
regulator. I think this part can easily be made generic and pushed into
cpu0, as it should be beneficial to other SoCs too.

2. Usage of a fixed max voltage, rather than a voltage-tolerance. i.MX5
has a fixed maximum voltage, which is valid across all operating points.
I'm really opposed to using a tolerance value, where we instead could
have a well defined range. So for merging imx5-cpufreq into cpufreq-cpu0
this driver really need to handle this case.
Does adding a separate property for this, while keeping the
voltage-tolerance for the existing users, sound like a change you would
accept?

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
