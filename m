From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Sep 2015 19:05:08 -0700
Subject: [PATCH v2 4/4] ARM: bcm2835: Switch to using the new clock driver
 support.
In-Reply-To: <1441922305-2298-4-git-send-email-eric@anholt.net>
References: <1441922305-2298-1-git-send-email-eric@anholt.net>
 <1441922305-2298-4-git-send-email-eric@anholt.net>
Message-ID: <5600B754.8000802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 02:58 PM, Eric Anholt wrote:
> This will give us the ability to set the pixel and HDMI state machine
> clocks for the VC4 KMS driver, change the CPU frequency, and
> potentially gate clocks in the future (once we also write a power
> domain driver).  It also gives the uart an explicit clock reference,
> so that we don't need to change the physical addresses of the old
> fixed clk_bcm2835.c clocks for Raspberry Pi 2 port.
> 
> Two clocks get their frequencies updated as a result of this.  One is
> uart's apb_pclk, which was previously accidentally grabbing the fixed
> uart0_pclk due to the apb_pclk not having clk_register_clkdev()
> called.  The uart doesn't seem to do anything with apb_pclk other than
> make sure it's on, so that appears safe (also, as far as I can see,
> the apb clock is actually the same as the VPU clock).  The other is
> EMMC, which according to the docs was supposed to be in the 50-100Mhz
> range, but it turns out the firmware needed to change to running it at
> the 250Mhz core clock speed to avoid a bug in clock domain crossing.
> 
> Additionally, anything using BCM2835_CLOCK_VPU will now have a correct
> clock rate if the user configures the boot-time core clock speed using
> config.txt.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
