From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 26 Feb 2014 12:20:26 -0800
Subject: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
In-Reply-To: <CAKohpo==WVKytPCaMk=O5rGfPNFDAF7ffYo7OE0d3uAPyJfwwA@mail.gmail.com>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
 <15001517.xLHO8lGdWr@vostro.rjw.lan> <530D06FF.201@codeaurora.org>
 <1789244.B5CzWbcp6h@vostro.rjw.lan> <530D47F4.2010204@codeaurora.org>
 <CAKohpo==WVKytPCaMk=O5rGfPNFDAF7ffYo7OE0d3uAPyJfwwA@mail.gmail.com>
Message-ID: <530E4C8A.6060906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2014 10:02 PM, Viresh Kumar wrote:
> On 26 February 2014 07:18, Saravana Kannan <skannan@codeaurora.org> wrote:
>> On 02/25/2014 02:41 PM, Rafael J. Wysocki wrote:
>
>>> And is "fully initialized" actually well defined?
>>
>> The point in add dev/hot plug path after which we will no longer change
>> policy fields without sending further CPUFREQ_UPDATE_POLICY_CPU /
>> CPUFRE_NOTIFY notifiers.
>
> Okay..
>
>> Pretty much the end of __cpufreq_add_dev() so that it's after:
>> - cpufreq_init_policy()
>> - And the update of userpolicy fields that after thie init call
>
> No. In that case it can be considered initialized before cpufreq_init_policy().
> As we do send CPUFREQ_NOTIFY after that from cpufreq_init_policy()->
> cpufreq_set_policy().

Ok, valid hole in my definition of "fully initialized".
>
> There are two types of fields within policy, some are very basic: cpu/min/max/
> affected_cpus/related_cpus
>
> some are advanced: sysfs/governors/..
>
> And as a rule you have to get policy->rwsem lock before accessing policy
> members. We might not have followed it very well for small things like cpu.
>
> And so if you are doing anything over that, please use a lock and that is
> already present in cpufreq_update_policy().
>
> With my latest patchset that I sent yesterday, locking is improved and now
> a policy will be usable only after the rwsem is released. And that should be
> fine. And so making it available in the per-cpu variable after all the necessary
> fields are filled looks fine to me. And so I don't think we need to move it
> after call to cpufreq_init_policy(maybe a better name to this function is
> required)..

I'll take a closer look. Internal tree cpufreq code is in 3.12, so 
back-porting all the cpufreq changes and testing it can take a bit of 
time. Will get back on this.

-Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
