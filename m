From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 27 Jan 2013 20:13:07 +0530
Subject: [PATCH v2 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <20130127085926.GH29973@lunn.ch>
References: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
 <1359215039-2848-2-git-send-email-andrew@lunn.ch>
 <CAKohpok1w2RB1ncyNTcd04XTNFfnq_S98YEcxNjpWGWMVA7TaQ@mail.gmail.com>
 <20130127085926.GH29973@lunn.ch>
Message-ID: <CAKohpo=zrUUv-mtnUBDtJeWAHB00_Se0aGv7X-ZW95i=7DkQpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2013 14:29, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sun, Jan 27, 2013 at 09:21:42AM +0530, Viresh Kumar wrote:

>> > +       kirkwood_cpufreq_set_cpu_state(index);
>>
>> This routine does have error cases, like: wrong value of "state"
>> variable, so returning int from it might make sense. Though i believe
>> state can't be anything else then STATE_CPU_FREQ or STATE_DDR_FREQ.
>> In which case, switch must be modified?
>
> As you say, state cannot be anything else that the two expected
> values. I've just been taught that switch statements should always
> have a default clause. I also thought that a BUG() is too strong, no
> need to kill the machine. It is better to spam the kernel log so it
> gets noticed. I can swap to a WARN_ON(1). I don't really think this is
> an error that needs to be reported back to the framework. Its an
> implementation problem, not a runtime problem. So i would prefer to
> keep to void.

Hmm. What i meant to say was, you just need an if,else instead of switch
and you really don't have to take care of anything else than these two values.
As that can't happen. Even the WARN_ON(). Its useless. Just believe on
what is returned from cpufreq_frequency_table_target(). You really don't
need to validate index returned from it, but only the return value (which
you are already doing)

>> > +static int kirkwood_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>> > +{
>> > +       cpufreq_frequency_table_put_attr(policy->cpu);
>> > +       return 0;
>> > +}
>>
>> Hmm.. Exit is normally called in two cases. Either cpufreq driver is
>> unregistered
>> or cpu is removed. In that case i am not sure if this routine makes sense? As
>> we have a uniprocessor SoC here.
>
> The current Kconfig entry does not allow it to be compiled as a
> module. But the code does allow for it. With the current trend of
> making the ARM kernel multiplatform, its likely that cpufreq drivers
> will become modular so that only the appropriate driver gets loaded in
> a multiplatform kernel. The question then becomes, is it O.K. not
> being able to unload the module?

You got me wrong. What i wanted to say is, even if you have it as module
and "rmmod" it, then also calling this routine wouldn't make any difference.

Then i went into the code to see the effect. So, this will set freq_table for
a cpu as NULL which will be returned by calling cpufreq_frequency_get_table().
And i now feel we must have this routine because once cpufreq driver isn't
there for a cpu, we must not return any table for it. :)
