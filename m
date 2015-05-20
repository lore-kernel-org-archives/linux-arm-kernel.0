From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 20 May 2015 20:34:30 +0800
Subject: [PATCH] i2c: designware: separate ops for system_sleep_pm and
 runtime_pm
In-Reply-To: <20150520121506.GU1490@lahna.fi.intel.com>
References: <1431693099-2292-1-git-send-email-jszhang@marvell.com>
 <20150518082823.GH1490@lahna.fi.intel.com>
 <20150519203242.74617ad6@xhacker>
 <20150519131516.GO1490@lahna.fi.intel.com>
 <20150520193422.73de7d90@xhacker>
 <20150520121506.GU1490@lahna.fi.intel.com>
Message-ID: <20150520203430.24edd2a8@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mika,

On Wed, 20 May 2015 15:15:06 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Wed, May 20, 2015 at 07:34:22PM +0800, Jisheng Zhang wrote:
> > Sorry for confusion. Considering one platform which doesn't support power off
> > the i2c host but it can disable the host's clock. So in such platform, when
> > the host is runtime suspended, its clock is disabled, then i2c_dw_disable() will
> > hang when s2ram.
> 
> Right. This happens also when the platform powers off the device.
> 
> > Except using the runtime pm API to ensure the host is in
> > a correct state, is there any other solution? AFAIK, 'dev->power.direct_complete'
> > doesn't help such case.
> 
> What I had in mind is something like below:
> 
> static int i2c_dw_prepare(struct device *dev)
> {
> 	return pm_runtime_suspended(dev);
> }
> 
> static void i2c_dw_complete(struct device *dev)
> {
> 	if (dev->power.direct_complete)
> 		pm_request_resume(dev);
> }
> 
> In other words it checks if the device is already runtime suspended and
> prevents ->suspend() etc. from being called.

What amazing! I wrote the same code as yours after sending out the last email.

> 
> If that does not work (I didn't try as this problem does not exist on

It works! How to submit the patch? Do you mind if I cook the patch and add
you signed-off?

Thanks a lot,
Jisheng
