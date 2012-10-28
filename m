From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 28 Oct 2012 17:57:11 +0100
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
Message-ID: <20121028165711.GG15824@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 04:53:45PM +0200, Andrew Lunn wrote:
> This patchset converts all DT kirkwood boards to using pinctrl.

Thanks for the feedback everybody gave.

Progress has been made:

The bug causing the lockups has been found, fixed and passed upstream.

I factored out the repeated pinmux definitions for sata0, sata1, spi,
twsi0, uart0, uart1.

I fixed a few types reported by testers.

I found a solution to many of the gpio_request() failures. The ones
for controlling power to SATA or USB i've replaced with a regulator in
DT. The regulator will grab the GPIO, set it to output, and driver it
high/low as required. I just hope we don't have an ordering issue.
The regulator framework seems to load quite early and probes all the
regulators. This fails, because pinctrl has not yet loaded, so the
gpio framework returns EPROBE_DEFER. This is not fatal to the
regulator framework, it tries again later. But this later is after
most of the rest of the drivers have loaded. So we might get into
issues where uboot has not enabled power to USB/SATA, the driver is
probed and fails because of the lack of power, and once things of gone
wrong, we turn the power on.

I still expect problems with GPIOs used for power off. I've not yet
touched them. Again, a regulator makes sense, but there is no 'out of
the box' regulator type or property which adds itself to pm_power_off.

The last problem is:

        /* Set NAS to turn back on after a power failure */
        dnskw_gpio_register(37, "dnskw:power:recover", 1);

I think its a bit of a stretch calling this a regulator.

Since the current patchset is 18 patches, plus a few other bug fixes
and dependencies, i'm not going to post them all here. I think we are
still at the smoke/no-smoke stage of testing. Please pull from:

git://github.com/lunn/linux.git v3.7-rc2-pinctrl-v2

and let me know if things work, what typo's need fixing, where the
smoke comes out, etc.

      Thanks
	Andrew
