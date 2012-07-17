From: mturquette@ti.com (Mike Turquette)
Date: Tue, 17 Jul 2012 08:42:54 -0700
Subject: [PATCH 2/2] [RFC] cpufreq: omap: scale regulator from clk notifier
In-Reply-To: <5004F638.6020301@nvidia.com>
References: <1342225001-22962-1-git-send-email-mturquette@linaro.org>
 <1342225001-22962-3-git-send-email-mturquette@linaro.org>
 <5004F638.6020301@nvidia.com>
Message-ID: <20120717154254.GA3340@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120717-10:50, Prashant Gaikwad wrote:
> On Saturday 14 July 2012 05:46 AM, Mike Turquette wrote:
> >+	/* scaling up?  scale voltage before frequency */
> >+	if (cnd->new_rate>  cnd->old_rate) {
> >+		dev_dbg(mpu_dev, "cpufreq-omap: %d mV -->  %d mV\n",
> >+				volt_old, volt_new);
> >+
> >+		ret = regulator_set_voltage(mpu_reg, volt_new - tol, volt_new + tol);
> >+
> >+		if (ret<  0) {
> >+			dev_warn(mpu_dev, "%s: unable to scale voltage up.\n",
> >+				 __func__);
> >+			return NOTIFY_BAD;
> >+		}
> >+	}
> >+
> >+	/* scaling down?  scale voltage after frequency */
> >+	if (cnd->new_rate<  cnd->old_rate) {
> >+		dev_dbg(mpu_dev, "cpufreq-omap: %d mV -->  %d mV\n",
> >+				volt_old, volt_new);
> >+
> >+		ret = regulator_set_voltage(mpu_reg, volt_new - tol, volt_new + tol);
> >+
> >+		if (ret<  0) {
> >+			dev_warn(mpu_dev, "%s: unable to scale voltage down.\n",
> >+				 __func__);
> >+			return NOTIFY_BAD;
> >+		}
> >  	}
> 
> How are you checking pre and post rate change condition here? Need
> switch case for event?
>

Oops.  This version of the patch is missing that.  I previously had a
version of the patch which did pre/post checking but all of this code
was in arch/arm/mach-omap2/.  It looks like when I moved things around I
accidentally dropped that bit.

Anyways that is trivial to do and simply changes like the following:

if (cnd->new_rate > cnd->old_rate && flags & CLK_PRE_RATE_CHANGE)
	...

if (cnd->new_rate < cnd->old_rate && flags & CLK_POST_RATE_CHANGE)
	...

Regards,
Mike
