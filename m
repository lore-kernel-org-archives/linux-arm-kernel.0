From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 28 Apr 2016 08:04:33 -0700
Subject: [PATCH 4/9] thermal: rockchip: handle the power sequence for
 tsadc controller
In-Reply-To: <57216C65.5040501@gmail.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
 <1460950562-20652-5-git-send-email-wxt@rock-chips.com>
 <20160427234818.GB2590@localhost.localdomain>
 <57216C65.5040501@gmail.com>
Message-ID: <20160428150432.GA20009@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 09:50:29AM +0800, Caesar Wang wrote:
> 
> 
> ? 2016?04?28? 07:48, Eduardo Valentin ??:
> >On Mon, Apr 18, 2016 at 11:35:56AM +0800, Caesar Wang wrote:
> >>+		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_ON);
> >>+		mdelay(10);
> >>+		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_OFF);
> >>+		udelay(100); /* The spec note says at least 15 us */
> >>+		regmap_write(grf, GRF_SARADC_TESTBIT, GRF_SARADC_TESTBIT_ON);
> >>+		regmap_write(grf, GRF_TSADC_TESTBIT_H, GRF_TSADC_TESTBIT_H_ON);
> >>+		udelay(200); /* The spec note says at least 90 us */
> >Does it make sense to use usleep_range() instead?
> 
> I think so in the past, but I'm digging into the the udelay/usleep for
> kernel.

What do you mean by in the past? timekeeping doc still recommends the
range 10us to 20ms for usleep_range()

> 
> In general,
> 
> udelay < 10us ~100us
> mdelay > 1m, <1000ms/HZ
> usleep_range(min,max) > 100us, <20ms

even here, your udelays could be replaced by usleep_range().

Any particular reason you believe spining is better than sleeping in
your case?

> msleep > 20ms,  < 1000ms
> 
> So the udelay is suit for tsadc power sequence.
> ---
> 
> 
> Also,  we have used the mdelay(10), so it doesn't matter if use the udelay.
> After all the udelay is stable than the usleep_range.

What do you mean udelay is stable than usleep_range? usleep_range will
give the opportunity to the scheduler to coalesce wakeups. udelay is a
busyloop spin. Besides, I am not sure the current situation, but
busylooping may be affected by cpu frequency.

> 
> -Caesar
> 
> >1.9.1
> >
> >
> >
> >
> >-- 
> >Thanks,
> >Caesar
