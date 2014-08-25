From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Aug 2014 15:49:29 +0200
Subject: [PATCH v5 3/3] pwm: i.MX: Avoid sample FIFO overflow for i.MX
 PWM version2
In-Reply-To: <20140825115628.GA7008@dragon>
References: <1401274213-8954-1-git-send-email-Ying.Liu@freescale.com>
 <1401274213-8954-3-git-send-email-Ying.Liu@freescale.com>
 <20140825115628.GA7008@dragon>
Message-ID: <20140825134927.GK4163@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 07:59:01PM +0800, Shawn Guo wrote:
> On Wed, May 28, 2014 at 06:50:13PM +0800, Liu Ying wrote:
> > The i.MX PWM version2 is embedded in several i.MX SoCs,
> > such as i.MX27, i.MX51 and i.MX6SL.  There is a 4-word(16bit)
> > sample FIFO in this IP.  Each FIFO slot determines the duty
> > period of a PWM waveform in one full cycle.  The IP spec
> > mentions that we should not write a fourth sample because
> > the FIFO will become full and triggers a FIFO write error
> > (FWE) which will prevent the PWM from starting once it is
> > enabled.  In order to avoid any sample FIFO overflow issue,
> > this patch clears all sample FIFO by doing software reset
> > in the configuration hook when the controller is disabled
> > or waits for a full PWM cycle to get a relinquished FIFO
> > slot when the controller is enabled and the FIFO is fully
> > loaded.
> > 
> > The FIFO overflow issue can be reproduced by the following
> > commands on the i.MX6SL EVK platform, assuming we use PWM2
> > for the debug LED which is driven by the pin HSIC_STROBE
> > and the maximal brightness is 255.
> > echo 0   > /sys/class/leds/user/brightness
> > echo 0   > /sys/class/leds/user/brightness
> > echo 0   > /sys/class/leds/user/brightness
> > echo 0   > /sys/class/leds/user/brightness
> > echo 255 > /sys/class/leds/user/brightness
> > Here, FWE happens(PWMSR register reads 0x58) and the LED
> > can not be lighten.
> > 
> > Another way to reproduce the FIFO overflow issue is to run
> > this script:
> > while true;
> > 	do echo 255 > /sys/class/leds/user/brightness;
> > done
> > 
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@freescale.com>
> > Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> > Cc: linux-pwm at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> 
> The whole series,
> 
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Thierry,
> 
> Can you pick them up if they look good to you?

All three patches applied with your Acked-by (and some minor
reformatting of the commit message).

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/8900549c/attachment-0001.sig>
