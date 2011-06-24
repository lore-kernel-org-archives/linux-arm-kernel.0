From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 24 Jun 2011 20:05:23 +0530
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <1308923618-5333-1-git-send-email-premi@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
Message-ID: <4E04A0AB.40608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/24/2011 7:23 PM, Sanjeev Premi wrote:
> Currently, loops_per_jiffy is being calculated twice for
> non-SMP processors.
>   - Before calling cpufreq_notify_transition()
>   - From within cpufreq_notify_transition()
>
> Double adjustment leads to incorrect value being assigned to
> loops_per_jiffy. This manifests as incorrect BogoMIPS in
> "cat /proc/cpuinfo".
>
> The value of loops_per_jiffy needs to be calculated only
> when CONFIG_SMP is true. It is the core change included
> in this patch.
>
> The patch also leverages the definition of for_each_cpu()
> with and without CONFIG_SMP to consolidate the mechanism
> to call cpufreq_notify_transition().
>
> Signed-off-by: Sanjeev Premi<premi@ti.com>

NAK. This patch again doesn't make sense considering your issue.
Also jiffies should not be undated before changing the freq.
If the set_rate failed for some reason then you will have wrong
jiffies value.

I understand your issue now. The code for global lpj updation
should have been checking smp_on_up() instead of is_smp().
That one line change is enough. I will post a patch on
the same once I reach to office.

Regards
Santosh
