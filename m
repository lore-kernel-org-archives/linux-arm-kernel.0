From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Feb 2014 12:59:08 -0600
Subject: [RFC PATCH 1/6] PM / Voltagedomain: Add generic clk notifier
 handler for regulator based dynamic voltage scaling
In-Reply-To: <20140227023455.GA15712@kahuna>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-2-git-send-email-nm@ti.com>
 <20140225055142.22529.21814@quantum> <530D0394.4020208@ti.com>
 <20140227023455.GA15712@kahuna>
Message-ID: <20140227185907.GA4862@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 26, 2014 at 08:34:55PM -0600, Nishanth Menon wrote:
> On 14:56-20140225, Nishanth Menon wrote:
> > On 02/24/2014 11:51 PM, Mike Turquette wrote:
> > > Quoting Nishanth Menon (2014-02-18 12:32:18)
> [...]
> > > I'm not sure about trying to capture the "voltdm" as a core concept. It
> > > feels a bit unwieldy to me.
> > 
> > Considering it is a simple collation of regulators and SoC specific
> > "magic" which have to be operated in tandem to clock operation, Why
> > does it seem unwieldy? Usage of multiple voltage planes in a single
> > voltage domain concept does not seem unique to TI processors either:
> > For example, imx6q-cpufreq.c uses 3 regulators (arm, pu, soc),
> > s5pv210-cpufreq.c uses two regulators (vddarm, vddint), ideally OMAP
> > implementation would use two (vdd_mpu, vbb_mpu).
> > 
> > > I have wondered about making an abstract
> > > "performance domain" which is the dvfs analogue to generic power
> > > domains. This a reasonable split since gpd are good for idle power
> > > savings (e.g. clock gate, power gate, sleep state, etc) and "perf
> > > domains" would be good for active power savings (dvfs).
> > > 
> > > Having a generic container for performance domains might make a good
> > > place to stuff all of this glue logic that we keep running into (e.g.
> > > CPU and GPU max frequencies that are related), and it might make another
> > > nice knob for the thermal folks to use.
> > 
> > This sounds like one level higher abstraction that we are speaking of
> > here? I was'nt intending to solve the bigger picture problem here -
> > just an abstraction level that might allow reusablity for multiple
> > SoCs. In fact, having an abstraction away for voltage domain(which may
> > consist of multiple regulators and any SoC specific magic) purely
> > allows us to move towards a direction you mention here.
> > 
> > > 
> > > For the case of the OMAP voltage domains, it would be a place to stuff
> > > all of the VC/VP -> ABB -> Smart Reflex AVS stuff.
> > > 
> > 
> > Unfortunately, I dont completely comprehend objection we have to this
> > approach (other than an higher level abstraction is needed) and if we
> > do have an objection, what is the alternate approach should be for
> > representing hardware which this series attempts to present.
> 
> I think the following is around the lines of your thought direction -
> if Rafael or others have comments on the following approach, it'd be a
> good starting point for me to progress.
> 
> -->8--
> From 62e50b9f920495db88e5594aa6bceb52e83a443d Mon Sep 17 00:00:00 2001
> From: Nishanth Menon <nm@ti.com>
> Date: Wed, 26 Feb 2014 10:59:59 -0600
> Subject: [PATCH] PM / Runtime: introduce active power management callbacks
>  for pm_domain
> 
> dev_pm_domain currently handles just device idle power management
> using the generic pm_runtime_get|put and related family of functions.
> 
> Logically with appropriate pm_domain hooks this can translate to
> hardware specific clock and related operations. Given that pm_domains
> may contain this information, this provides an opportunity to extend
> current pm_runtime do dynamic power operations as well.
> 
> What this means for drivers is as follows:
> 
> Today, drivers(with some level of complexity) do:
> pm_runtime_get_sync(dev);
> clk = clk_get(dev, "name");
> old_rate = clk_get_rate(clk);
> ...
> clk_set_rate(clk, new_rate);
> ...
> clk_put(clk);
> pm_runtime_get_sync(dev);
> 
> Instead, on pm_domains that can handle this as part of
> pm_domain->active_ops functions, They can now do the following:
> pm_runtime_get_sync(dev);
> old_rate = pm_runtime_get_rate(dev);
> ...
> pm_runtime_set_rate(dev, new_rate);
> ...
> pm_runtime_put_sync(dev);
> 
> Obviously, this'd work for devices that handle a single main
> functional clock, but this could reduce complexity of drivers having
> to deal with power management details to have pm_runtime as the main
> point of interface.
> 
> CAVEAT: For power domains that are capable of handling multiple
> clocks (example on OMAP, where there are the concepts of interface,
> functional and optional clocks per block), appropriate handling will
> be necessary from pm_domain callbacks. So, the question about which
> clock rate is being controlled or returned to is entirely upto the
> pm_domain implementation.
> 
> On the otherhand, we can debate about defining and querying ACPI style
> "Performance state" instead of frequencies and wrap P-states inside
> or the other way around.. but given that majority of drivers using
> pm_runtime would rather be interested in frequencies and my naieve
> belief that we can index P-states with frequencies, kind of influenced
> my choice here of proposing frequencies as base query parameter..
> ofcourse, debate is still open here.
> 
> Yes, we can still debate if providing yet another wrapper on top of
> clock APIs makes sense at all as well.
> 
> Nyet-signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/base/power/runtime.c |  101 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm.h           |   25 +++++++++--
>  include/linux/pm_runtime.h   |   21 +++++++++
>  3 files changed, 143 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 72e00e6..ef230b4 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1401,3 +1401,104 @@ void pm_runtime_remove(struct device *dev)
>  	if (dev->power.irq_safe && dev->parent)
>  		pm_runtime_put(dev->parent);
>  }
> +
> +/**
> + * pm_runtime_get_rate() - Returns the device operational frequency
> + * @dev:	Device to handle
> + * @rate:	Returns rate in Hz.
> + *
> + * Returns appropriate error value in case of error conditions, else
> + * returns 0 and rate is updated. The pm_domain logic does all the necessary
> + * operation (which may consider magic hardware stuff) to provide the rate.
> + *
> + * NOTE: the rate returned is a snapshot and in many cases just a bypass
> + * to clk api to set the rate.
> + */
> +int pm_runtime_get_rate(struct device *dev, unsigned long *rate)
> +{
> +	unsigned long flags;
> +	int error = -ENOSYS;
> +
> +	if (!rate || !dev)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	if (!pm_runtime_active(dev)) {
> +		error = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (dev->pm_domain && dev->pm_domain->active_ops.get_rate)
> +		error = dev->pm_domain->active_ops.get_rate(dev, rate);
> +out:
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +	return error;
> +}

IMHO coupling device drivers even more with pm_runtime is wrong, and
Kevin Hilman seems to agree [1].

I would much rather go with Nishanth's initial approach of subscribing
to clock notifiers. They are, after all, supposed to tell the kernel
about any clock changes. In just so happens that in the case discussed
in this thread, OMAP needs to change voltages to match clock frequency
and, IMHO, using clock notifiers for that is correct.

The sematics are well defined and it's something which has been in the
tree for quite some time.

[1] https://lkml.org/lkml/2014/1/30/469

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/f6a7eda2/attachment.sig>
