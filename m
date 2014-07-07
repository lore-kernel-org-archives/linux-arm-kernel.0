From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Jul 2014 16:31:34 +0530
Subject: RFC: Leave sysfs nodes alone during hotplug
In-Reply-To: <53B5D22F.2070308@codeaurora.org>
References: <53B5D22F.2070308@codeaurora.org>
Message-ID: <CAKohpomuPshe4HpvWSzmZ3vvAjV-zHucfHBVbhB6dUBrrYH8pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing Srivatsa and fixing Rafael's id.

On 4 July 2014 03:29, Saravana Kannan <skannan@codeaurora.org> wrote:
> The adding and removing of sysfs nodes in cpufreq causes a ton of pain.
> There's always some stability or deadlock issue every few weeks on our
> internal tree. We sync up our internal tree fairly often with the upstream
> cpufreq code. And more of these issues are popping up as we start exercising
> the cpufreq framework for b.L systems or HMP systems.
>
> It looks like we adding a lot of unnecessary complexity by adding and
> removing these sysfs nodes. The other per CPU sysfs nodes like:
> /sys/devices/system/cpu/cpu1/power or cpuidle are left alone during hotplug.
> So, why are we not doing the same for cpufreq too?

This is how it had been since ever, don't know which method is correct.
Though these are the requirements I have from them:
- On hotplug files values should get reset ..
- On suspend/resume values must be retained.

> Any objections to leaving them alone during hotplug? If those files are
> read/written to when the entire cluster is hotplugged off, we could just
> return an error. I'm not saying it would be impossible to fix all these
> deadlock and race issues in the current code -- but it seems like a lot of
> pointless effort to remove/add sysfs nodes.

Lets understand the problem first and then can take the right decision.

> Examples of issues caused by this:
> 1. Race when changing governor really quickly from userspace. The governors
> end up getting 2 STOP or 2 START events. This was introduced by [1] when it
> tried to fix another deadlock issue.

I was talking about [1] offline with Srivatsa, and one of us might look in
detail why [1] was actually required.

But I don't know how exactly can we get 2 STOP/START in latest mainline
code. As we have enough protection against that now.

So, we would really like to see some reports against mainline for this.

> 2. Incorrect policy/sysfs handling during suspend/resume. Suspend takes out
> CPU in the order n, n+1, n+2, etc and resume adds them back in the same
> order. Both sysfs and policy ownership transfer aren't handled correctly in
> this case.

I know few of these, but can you please tell what you have in mind?

> This obviously applies even outside suspend/resume if the same
> sequence is repeated using just hotplug.

Again, what's the issue?

> I'd be willing to take a shot at this if there isn't any objection to this.
> It's a lot of work/refactor -- so I don't want to spend a lot of time on it
> if there's a strong case for removing these sysfs nodes.

Sure, I fully understand this but still wanna understand the issue first.

> P.S: I always find myself sending emails to the lists close to one holiday
> or another. Sigh.

Sorry for being late to reply to this. I saw it on friday, but couldn't reply
whole day. Was following something with ticks core. :(

> [1] -
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm/+/955ef4833574636819cd269cfbae12f79cbde63a%5E!/
