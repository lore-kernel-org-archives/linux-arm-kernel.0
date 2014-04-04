From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 4 Apr 2014 22:26:58 +0800
Subject: MX28: leds/pwm: Using pwm driven led as heartbeat leads to
 kernel warning
In-Reply-To: <533EB9AC.6040708@i2se.com>
References: <53345C93.9040005@i2se.com>
 <533EB9AC.6040708@i2se.com>
Message-ID: <20140404142656.GA16383@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 03:54:52PM +0200, Stefan Wahren wrote:
> the problem is still reproducable in Mainline 3.14.0 and gives the same
> warning message.
> Also i add linux-leds in CC.
> 
> Are there any advices to narrow down the problem?
> 
> Is this problem specific to i.MX28 PWM (i don't have other kind of
> hardware)?

I don't think it's specific to i.MX28 PWM.  Since the .config hook of
pwm_ops will be called from interrupt context in this case, any pwm
drivers that do sleeping calls in the hook will have this problem, e.g.
the clk APIs that hold mutex like clk_prepare() and clk_get_rate() etc.

Shawn
