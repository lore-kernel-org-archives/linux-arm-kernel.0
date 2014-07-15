From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 14 Jul 2014 22:36:59 -0700
Subject: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <CAKohpomkqbHZo9KrJMSwsEKGt6+Ac2Fg2X0+S7ZAo=OzhAc45g@mail.gmail.com>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
 <1405052287-4744-1-git-send-email-skannan@codeaurora.org>
 <CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>
 <2f549e6e4871ccf2a94dd4c8872c7a0b.squirrel@www.codeaurora.org>
 <CAKohpokhmj1OkCRj=X+Q7eYiun8fsqD2dpEt66VKYnqo3dENVA@mail.gmail.com>
 <53C0A12A.2060204@codeaurora.org>
 <CAKohpon9en_VnSx+CVydPsWBHtArvmazn0hrodrRJt9jgOa0-g@mail.gmail.com>
 <53C42AA8.8010107@codeaurora.org>
 <CAKohpomkqbHZo9KrJMSwsEKGt6+Ac2Fg2X0+S7ZAo=OzhAc45g@mail.gmail.com>
Message-ID: <53C4BDFB.70707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2014 09:35 PM, Viresh Kumar wrote:
> On 15 July 2014 00:38, Saravana Kannan <skannan@codeaurora.org> wrote:
>> Yeah, it definitely crashes if policy->cpu if an offline cpu. Because the
>> mutex would be uninitialized if it's stopped after boot or it would never
>> have been initialized (depending on how you fix policy->cpu at boot).
>>
>> Look at this snippet on the actual tree and it should be pretty evident.
>
> Yeah, I missed it. So the problem is we initialize timer_mutex's for
> policy->cpus. So we need to do that just for policy->cpu and also we don't
> need a per-cpu timer_mutex anymore.
>

Btw, I tried to take a stab at removing any assumption in cpufreq code 
about policy->cpu being ONLINE. There are 160 instances of those of with 
23 are in cpufreq.c

So, even if we are sure cpufreq.c is fine, it's 137 other uses spread 
across all the other files. I definitely don't want to try and fix those 
as part of this patch. Way too risky and hard to get the test coverage 
it would need. Even some of the acpi cpufreq drivers seem to be making 
this assumption.

Btw, I think v3 is done. I did some testing and it was fine. But made 
some minor changes. Will test tomorrow to make sure I didn't break 
anything with the minor changes and then send them out.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
