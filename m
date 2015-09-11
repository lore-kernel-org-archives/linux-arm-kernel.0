From: martin@sperl.org (Martin Sperl)
Date: Fri, 11 Sep 2015 12:08:21 +0200
Subject: [PATCH v2 3/4] clk: bcm2835: Add support for programming the
 audio domain clocks.
In-Reply-To: <1441922305-2298-3-git-send-email-eric@anholt.net>
References: <1441922305-2298-1-git-send-email-eric@anholt.net>
 <1441922305-2298-3-git-send-email-eric@anholt.net>
Message-ID: <DA82061A-F4FF-4B05-A6B4-BFD5F3F2E52C@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 10.09.2015, at 23:58, Eric Anholt <eric@anholt.net> wrote:
> 
> This adds support for enabling, disabling, and setting the rate of the
> audio domain clocks.  It will be necessary for setting the pixel clock
> for HDMI in the VC4 driver and let us write a cpufreq driver.  It will
> also improve compatibility with user changes to the firmware's
> config.txt, since our previous fixed clocks are unaware of it.
> 
> The firmware also has support for configuring the clocks through the
> mailbox channel, but the pixel clock setup by the firmware doesn't
> work, and it's Raspberry Pi specific anyway.  The only conflicts we
> should have with the firmware would be if we made firmware calls that
> result in clock management (like opening firmware V3D or ISP access,
> which we don't support in upstream), or on hardware over-thermal or
> under-voltage (when the firmware would rewrite PLLB to take the ARM
> out of overclock).  If that happens, our cached .recalc_rate() results
> would be incorrect, but that's no worse than our current state where
> we used fixed clocks.
> 
> The existing fixed clocks in the code are left in place to provide
> backwards compatibility with old device tree files.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

This patch-sets sets the emmc clock to correct frequency - no longer
overclocking SDCards by a factor of 2.5.
This means booting from the eMMC on the Compute module works now
without issues.

Note that the DT bcm2835-rpi-b-plus.dtb can get used to boot
the compute module.

Thanks

Tested-by: Martin Sperl <kernel@martin.sperl.org>
