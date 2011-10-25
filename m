From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Oct 2011 16:30:09 +0200
Subject: [PATCH v3 2/3] arm/tegra: Don't create duplicate gpio and
	pinmux devices
In-Reply-To: <1319544088-25946-2-git-send-email-swarren@nvidia.com>
References: <1319544088-25946-1-git-send-email-swarren@nvidia.com>
	<1319544088-25946-2-git-send-email-swarren@nvidia.com>
Message-ID: <20111025143009.GA14945@dhcp-172-17-9-83.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 02:01:27PM +0200, Stephen Warren wrote:
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
> To avoid this duplicate registration, modify *_pinmux_init() to check
> whether it's running on a DT machine. If not, register the pinmux devices.
> If so, don't register them.
> 
> Finally, modify board-dt.c to call the *_pinmux_init() after all devices have
> been instantiated from device-tree. This allows the GPIO and pinmux devices
> to be instantiated and initialized before calling functions to configure the
> hardware.
> 
> This has one disadvantage: The pinmux and GPIO initialization now happens
> after /all/ devices are instantiated, rather than after just gpio and
> pinmux but before anything else. So the correct HW configuration is not
> in place when e.g. the SD/MMC device is probed. Long-term, this should be
> solved by doing both:
> 
> a) Initializing the HW state from DT nodes during GPIO and pinmux device
>    probe.
> b) Using the deferred driver probe mechanism, so that drivers can defer
>    their probe until after the gpio and pinmux drivers have probed.
> 
> v2: s/int is_dt/bool is_dt/
> v3: Use of_machine_is_compatible inside *_pinmux_init() rather than passing
> an explicit parameter into the function from outside.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/mach-tegra/board-dt.c               |   13 +++++++------
>  arch/arm/mach-tegra/board-harmony-pinmux.c   |    6 +++++-
>  arch/arm/mach-tegra/board-paz00-pinmux.c     |    6 +++++-
>  arch/arm/mach-tegra/board-seaboard-pinmux.c  |    5 ++++-
>  arch/arm/mach-tegra/board-trimslice-pinmux.c |    5 ++++-
>  5 files changed, 25 insertions(+), 10 deletions(-)

This looks pretty good. Given the fact that current behavior is buggy,
merging it for 3.2 makes sense. Grant, you OK with that for the
prerequisite OF patch?


-Olof
