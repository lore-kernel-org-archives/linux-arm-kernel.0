From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 8 Apr 2014 16:49:52 +0800
Subject: MX28: leds/pwm: Using pwm driven led as heartbeat leads to
 kernel warning
In-Reply-To: <20140408084150.GC30127@piout.net>
References: <53345C93.9040005@i2se.com> <533EB9AC.6040708@i2se.com>
 <20140404142656.GA16383@dragon> <20140404164446.GI4883@piout.net>
 <20140408073402.GC2438@dragon> <20140408075916.GA30127@piout.net>
 <20140408081848.GH2438@dragon> <20140408084150.GC30127@piout.net>
Message-ID: <20140408084951.GI2438@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 10:41:50AM +0200, Alexandre Belloni wrote:
> On 08/04/2014 at 16:18:49 +0800, Shawn Guo wrote :
> > On Tue, Apr 08, 2014 at 09:59:16AM +0200, Alexandre Belloni wrote:
> > > The driver using the PWM should test the flag, have a look at:
> > > http://lxr.free-electrons.com/source/drivers/leds/leds-pwm.c#L183
> > 
> > Ah, right, that' how the flag works.  Thanks, Alexandre.  I send a patch
> > to set the flag for pwm-mxs driver shortly.
> > 
> 
> Actually, I had a closer look and I believe using clk_prepare_enable()
> in .config is wrong. Let me prepare a patch.

Yes, we can split clk_prepare_enable() into clk_prepare() and
clk_enable(), call the former in .probe() and only the later in .config
hook.

But it only fixes the problem partially.  If you look at Stefan's report
closely, you can see the warning actually comes from the clk_get_rate()
call which holds a mutex too.

Shawn
