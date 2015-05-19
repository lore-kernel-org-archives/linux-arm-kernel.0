From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 19 May 2015 16:15:16 +0300
Subject: [PATCH] i2c: designware: separate ops for system_sleep_pm and
 runtime_pm
In-Reply-To: <20150519203242.74617ad6@xhacker>
References: <1431693099-2292-1-git-send-email-jszhang@marvell.com>
 <20150518082823.GH1490@lahna.fi.intel.com>
 <20150519203242.74617ad6@xhacker>
Message-ID: <20150519131516.GO1490@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 08:32:42PM +0800, Jisheng Zhang wrote:
> > I can see that this fixes the issue with the platform driver (as the
> > platform bus core doesn't power on the device automatically as opposed
> > to other buses, like PCI). However, I'm thinking that can we do better
> > here.
> > 
> > Instead of powering the device on again, can't we leave it in low power
> > state? Recently added 'dev->power.direct_complete' may be used to
> > achieve that, I think.
> 
> how to handle runtime suspended via just being clock gated?

As far as I can tell driver's suspend hook does the clock gating so why
would you need to handle it differently? Once the device is runtime
suspended, it is both clock and power gated depending on the platform.

> Currently the only solution is using the runtime pm apis to ensure the
> device is in a working state during s2ram. What's your opinion?

Well, it sounds a bit silly to resume the device just because you want
to call i2c_dw_disable() for it before suspending again ;-)

At least, it would be nice to check if we can keep it runtime suspended
with the help of 'dev->power.direct_complete'. If not possible, then I
suppose your patch is sufficient.
