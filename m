From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 13 Apr 2014 15:46:45 +0800
Subject: [PATCH v2] pwm: i.MX: Avoid sample fifo overflow for i.MX pwm
 version2
In-Reply-To: <1397121829-19331-1-git-send-email-Ying.Liu@freescale.com>
References: <1397121829-19331-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20140413074643.GD24180@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 05:23:49PM +0800, Liu Ying wrote:
> The i.MX pwm version2 is embedded in several i.MX SoCs, such
> as i.MX27, i.MX51 and i.MX6SL.  There are four 16bit sample
> fifos in this IP, each of which determines the duty period
> of a PWM waveform in one full cycle.  The IP spec mentions
> that we should not write a fourth sample because the fifo
> will become full and trigger a fifo write error(FWE) which
> will prevent the PWM from starting once it is enabled.  In
> order to avoid any sample fifo overflow issue, this patch
> does software reset to clear all the sample fifos in the
> very beginning of the pwm configuration function.
> 
> The fifo overflow issue can be reproduced by the following
> commands on the i.MX6SL evk platform, assuming we use pwm2
> for the debug LED which is driven by the pin HSIC_STROBE
> and the maximal brightness is 255.
> echo 0   > /sys/class/leds/user/brightness
> echo 0   > /sys/class/leds/user/brightness
> echo 0   > /sys/class/leds/user/brightness
> echo 0   > /sys/class/leds/user/brightness
> echo 255 > /sys/class/leds/user/brightness
> Here, FWE happens(PWMSR register reads 0x58) and the LED
> can not be lighten.
> 
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>

Acked-by: Shawn Guo <shawn.guo@freescale.com>

> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Cc: linux-pwm at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
