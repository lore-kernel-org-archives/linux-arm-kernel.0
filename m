From: jm@lentin.co.uk (Jamie Lentin)
Date: Tue, 1 May 2012 19:34:29 +0100 (BST)
Subject: [PATCH 1/1] ARM: kirkwood: Add support for RaidSonic
In-Reply-To: <20120501172042.GA13233@lunn.ch>
References: <20120501172042.GA13233@lunn.ch>
Message-ID: <alpine.DEB.2.00.1205011902150.23719@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 May 2012, Andrew Lunn wrote:

> Hi Simon
>
> The patch looks good.
>
> +static void ib62x0_power_off(void)
> +{
> +       gpio_set_value(IB62X0_GPIO_POWER_OFF, 1);
> +}
>
> Seeing this set of a train of thought. I have a feature creep
> request. Nice to have, i.e. not required to acceptance. This patterns
> of using a GPIO line to turn the hardware off is seen quite a few
> times. e.g.
>
> mach-kirkwood/netspace_v2-setup.c
> mach-orion5x/mv2120-setup.c
> mach-kirkwood/d2net_v2-setup.c
> mach-kirkwood/netspace_v2-setup.c
>
> and a few more.
>
> How about writing a gpio-poweroff platform driver? It would take a
> platform_data structure which lists which GPIO line to use, and if it
> should be active high/low. The probe function would take control of
> the GPIO line, set it to inactive state, and output. It would also
> register a function for pm_power_off(). When that function is called,
> it toggles the GPIO to turn the power off.
>
> Then wrap all this up in a DT binding.

I've been thinking about this too, would make a lot of sense. Most of the 
gpio-poweroff driver would be easy, although registering the power_off 
function wasn't immediately obvious.

In the process of this though, I stumbled on the gpio-regulator driver and 
emails suggesting to use this. It seems like it would make sense for the 
GPIO pins on the DNS-320 that turn on/off SATA drives, and intend to have 
a go at using this instead. This could possibly be used for power off too, 
but might be streatching it a bit too far.

>
>     Andrew
>

-- 
Jamie Lentin
