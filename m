From: kernel@martin.sperl.org (Martin Sperl)
Date: Sat, 30 Apr 2016 11:28:25 +0200
Subject: [PATCH 2/2] clk: bcm2835: Skip PLLC clocks when deciding on a new
 clock parent
In-Reply-To: <1461699585-6649-2-git-send-email-eric@anholt.net>
References: <1461699585-6649-1-git-send-email-eric@anholt.net>
 <1461699585-6649-2-git-send-email-eric@anholt.net>
Message-ID: <C771F70C-2F88-49E1-A370-D76D13262C1E@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 26.04.2016, at 21:39, Eric Anholt <eric@anholt.net> wrote:
> 
> If the firmware had set up a clock to source from PLLC, go along with
> it.  But if we're looking for a new parent, we don't want to switch it
> to PLLC because the firmware will force PLLC (and thus the AXI bus
> clock) to different frequencies during over-temp/under-voltage,
> without notification to Linux.
> 
> On my system, this moves the Linux-enabled HDMI state machine and DSI1
> escape clock over to plld_per from pllc_per.  EMMC still ends up on
> pllc_per, because the firmware had set it up to use that.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
> ?

I guess this patch looks to me as if it is a policy inside the kernel,
which is AFAIK frowned upon.

I am looking into making "assigned-clock-parents? inside the dt 
work with the driver.

Could look something like this:
i2s: i2s at 7e203000 {
	assigned-clock-parents = <&cprman BCM2835_PLLD_PER>, <&clk_osc>;
	assigned-clocks = <&cprman BCM2835_CLOCK_PCM>, <&cprman BCM2835_CLOCK_PCM>;
};
(not sure if that works really - the same clock in assigned-clocks looks suspicious)

This would move the policy out of the kernel into the device-tree,
which - i guess is a better solution.

Martin
