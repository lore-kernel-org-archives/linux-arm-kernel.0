From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 30 Aug 2013 11:28:01 +0530
Subject: [PATCH 02/10] cpufreq: OMAP: Add SMP support for OMAP4+
In-Reply-To: <CAKohpomco=TodaosVbvAhFSxrth9aZ1gh+VOHftG1w6nYWBsPg@mail.gmail.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
 <1316725648-26710-3-git-send-email-khilman@ti.com>
 <CAOh2x=k11EivJoy5-PMXnE5JGDc=DcJKhae7qoh6tNc4L63VnA@mail.gmail.com>
 <521F4E88.1000709@ti.com>
 <CAKohpokqz0cQNS12hZS-YOCd8KSOtCy9_TbGdqFzCYz8NyeamQ@mail.gmail.com>
 <521F4FBB.3080002@ti.com>
 <CAKohpomco=TodaosVbvAhFSxrth9aZ1gh+VOHftG1w6nYWBsPg@mail.gmail.com>
Message-ID: <CAKohpo=q=tE5o75WzCt=T0d2fFBdgLRj8SYoqoBZc3h0XioWLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 August 2013 11:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29 August 2013 19:12, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> > On Thursday 29 August 2013 09:39 AM, Viresh Kumar wrote:
> >> On 29 August 2013 19:07, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> >>> On Thursday 29 August 2013 06:02 AM, Viresh Kumar wrote:
> >>
> >>>> cpumask_setall(policy->cpus);
> >>>>
> >>> Thats should work I guess. Infact I changed this i downstream kernel
> >>> a while back but forgot to send a patch. Just see if for some reason
> >>> above can break UP machine since this driver is used on UP machines
> >>> as well. Other than that, it should be fine
> >>
> >> Atleast I can't see why it will break on UP machines as that should set
> >> masks to individual CPUs then...
> >>
> >> Okay I will fix that in my longest patchset ever... 230+ patches already :)
> >>
> > WoW !!
> > Looks like you re-wrote most of the CPUFREQ drivers ;-)
>
> I am trying hard to get rid of redundancy of code wherever possible .. :)
>
> I am pasting my patch here for now (don't want to post
> this separately) as most of the concerned people are following this chain..
>
> I will include it in my patchset and will post it on lists with them (After
> your Ack, which you will give now :) )
>
> --------x-----------------x--------------

OMG, Gmail fucked up completely... What to do now :)

Earlier (few days back):
- We could have selected the plain text mode while sending emails, where
emails are corrupted a bit and so patches couldn't be applied.
- BUT they are atleast readable as it wasn't fucked up so badly..

But today I noticed that gmail has completely removed tabs from mails
(Atleast while pasting code). And so all tabs used for alignments in mail are
gone.. And so aren't even readable anymore..

Deselecting plain text mode, sends it in HTML and that's fucked up too..
Mails gets bounced from our lists (and even then gmail has eaten up
the tabs from code)...

For now see the attached patch, I will send it using git later..

Btw, this is the link to master patch that you may need during reviews..
https://lkml.org/lkml/2013/8/21/485

> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Wed, 21 Aug 2013 19:05:05 +0530
> Subject: [PATCH] cpufreq: omap: use cpufreq_generic_init() routine
>
> Use generic cpufreq_generic_init() routine instead of replicating the same code
> here.
>
> This also rearranges the code a bit to make it more sensible. Also removes some
> unnecessary checks.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/omap-cpufreq.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 09150fc..a94c4ef 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -112,50 +112,31 @@ static inline void freq_table_free(void)
>
>  static int omap_cpu_init(struct cpufreq_policy *policy)
>  {
> - int result = 0;
> + int result;
>
>   policy->clk = clk_get(NULL, "cpufreq_ck");
>   if (IS_ERR(policy->clk))
>   return PTR_ERR(policy->clk);
>
> - if (policy->cpu >= NR_CPUS) {
> - result = -EINVAL;
> - goto fail_ck;
> - }
> -
> - if (!freq_table)
> + if (!freq_table) {
>   result = opp_init_cpufreq_table(mpu_dev, &freq_table);
> -
> - if (result) {
> - dev_err(mpu_dev, "%s: cpu%d: failed creating freq table[%d]\n",
> + if (result) {
> + dev_err(mpu_dev,
> + "%s: cpu%d: failed creating freq table[%d]\n",
>   __func__, policy->cpu, result);
> - goto fail_ck;
> + goto fail;
> + }
>   }
>
>   atomic_inc_return(&freq_table_users);
>
> - result = cpufreq_table_validate_and_show(policy, freq_table);
> - if (result)
> - goto fail_table;
> -
> - /*
> - * On OMAP SMP configuartion, both processors share the voltage
> - * and clock. So both CPUs needs to be scaled together and hence
> - * needs software co-ordination. Use cpufreq affected_cpus
> - * interface to handle this scenario. Additional is_smp() check
> - * is to keep SMP_ON_UP build working.
> - */
> - if (is_smp())
> - cpumask_setall(policy->cpus);
> -
>   /* FIXME: what's the actual transition time? */
> - policy->cpuinfo.transition_latency = 300 * 1000;
> -
> - return 0;
> + result = cpufreq_generic_init(policy, freq_table, 300 * 1000);
> + if (!result)
> + return 0;
>
> -fail_table:
>   freq_table_free();
> -fail_ck:
> +fail:
>   clk_put(policy->clk);
>   return result;
>  }
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-omap-use-cpufreq_generic_init-routine.patch
Type: application/octet-stream
Size: 2406 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130830/84f46532/attachment-0001.obj>
