From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Oct 2011 11:39:30 +0200
Subject: [PATCH] arm/tegra: Don't create duplicate gpio and pinmux devices
In-Reply-To: <1319218550-26002-1-git-send-email-swarren@nvidia.com>
References: <1319218550-26002-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111025093653.GA13409@dhcp-172-17-9-83.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2011 at 11:35:50AM -0600, Stephen Warren wrote:
> *_pinmux_init() register the GPIO and pinmux devices so that they're ready
> before any other device needs them.
> 
> *_pinmux_init() are also called by board-dt.c in order to set up the GPIO
> and pinmux configurations. In this case, if we register the devices, they
> end up being probed once due to this registration, and a second time due
> to a device-tree node (or vice-versa). The second probe fails since the
> memory regions are already requested. Besides, we don't actually want the
> duplicated devices.
> 
> To avoid this duplicate registration, pass a parameter into *_pinmux_init()
> indicating whether they should register the device or not. Set this true
> for non-DT boards, and false otherwise.
> 
> Finally, modify board-dt.c to call the *_pinmux_init() after all devices have
> been instantiated from device-tree. This allows the GPIO and pinmux devices
> to be instantiated and initialized before calling functions to configure the
> hardware.
> 
> This has one disadvantage: The pinmux and GPIO initialization now happens
> after /all/ devices are instantiated, rather than after just gpio and
> pinmux, but before anything else. So the correct HW configuration is not
> in place when e.g. the SD/MMC device is probed. Long-term, this should be
> solved by doing both:
> 
> a) Initializing the HW state from DT nodes during GPIO and pinmux device
>    probe.
> b) Using the deferred driver probe mechanism, so that drivers can defer
>    their probe until after the gpio and pinmux drivers have probed.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Grant, Olof, Colin,
> 
> What are your thoughts here? Both with and without the patch there are
> disadvantages. I'm not sure which one is better...

I'm not a fan of the added argument. Since it's really just a check
whether you are running on a device-tree probed machine or not, adding
a machine_is_{harmony,paz00,seaboard}() check in the same place as the
!is_dt check now will accomplish the same thing.

It would be nice to check for of_machine_is_compatible() instead of the
machine_is_.*() tests, but then you need to ifdef it since it doesn't
evaluate to 0 on CONFIG_OF=n -- for extra bonus, do it that way and add
the empty of_machine_is_compatible() function to include/linux/of.h.


-Olof
