From: klimov.linux@gmail.com (Alexey Klimov)
Date: Thu, 4 Jan 2018 22:10:22 +0000
Subject: [PATCH v5 20/20] cpufreq: scmi: add support for fast frequency
 switching
In-Reply-To: <1514904162-11201-21-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-21-git-send-email-sudeep.holla@arm.com>
Message-ID: <CALW4P++xNXWUYoAEjV2=zfj-ps+JSD3kkkKRAeED08UF3Gabfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Tue, Jan 2, 2018 at 2:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> The cpufreq core provides option for drivers to implement fast_switch
> callback which is invoked for frequency switching from interrupt context.
>
> This patch adds support for fast_switch callback in SCMI cpufreq driver
> by making use of polling based SCMI transfer. It also sets the flag
> fast_switch_possible.
>
> Cc: linux-pm at vger.kernel.org
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 0ee9335d0063..d0a82d7c6fd4 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -64,6 +64,19 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>         return perf_ops->freq_set(handle, priv->domain_id, freq, false);
>  }
>
> +static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +                                            unsigned int target_freq)
> +{
> +       struct scmi_data *priv = policy->driver_data;
> +       struct scmi_perf_ops *perf_ops = handle->perf_ops;
> +
> +       if (!perf_ops->freq_set(handle, priv->domain_id,
> +                               target_freq * 1000, true))
> +               return target_freq;
> +
> +       return 0;
> +}

Could you please explain how it's supposed to work for purpose of fast
frequency switching?

I am trying to track down ->freq_set.
So it looks like this will fire an scmi perf level set command and
will poll for this command to complete without asking for firmware to
send command completion irq.

scmi_perf_level_set() will call the following functions:

scmi_one_xfer_init();
scmi_do_xfer(handle, t);
scmi_one_xfer_put(handle, t);


The first function in the list calls scmi_one_xfer_get() which has
this in the description (I guess because of down_timeout()):
"This function can sleep depending on pending requests already in the system
for the SCMI entity. Further, this also holds a spinlock to maintain
integrity of internal data structures."

So it can sleep.

As far as I see description of fast frequency switching it's required
for fast_switch to not sleep:
(file Documentation/cpu-freq/cpu-drivers.txt)

"This function is used for frequency switching from scheduler's context.
Not all drivers are expected to implement it, as sleeping from within
this callback isn't allowed. This callback must be highly optimized to
do switching as fast as possible."


The other questions to this implementation of fast switching:

1) Fast switching callback must be highly optimized. Is it now? I see
few spinlocks (in scmi mbox client and in the mailbox framework) there
and polling functionality with udelay(5) inside that will timeout (if
my calculations are correct) after 0.5 ms.
2) Is it highly dependent on transport? If mailbox transport
->send_data() may sleep or hrtimer-based polling in mailbox framework
will be used, then this fast switch won't work, right?

I am still looking into that: I can be wrong and just trying to
understand if it is all okay.

[..]

Thanks,
Alexey
