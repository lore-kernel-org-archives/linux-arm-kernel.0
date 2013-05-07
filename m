From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 07 May 2013 09:17:54 +0100
Subject: [RFC PATCH 1/2] ARM: delay: print dummy values for bogomips
In-Reply-To: <20130506231554.GB16801@amd.pavel.ucw.cz>
References: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
 <1367602547-19322-2-git-send-email-will.deacon@arm.com>
 <20130506231554.GB16801@amd.pavel.ucw.cz>
Message-ID: <5188B8B2.5030601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/13 00:16, Pavel Machek wrote:

Hi Pawel,

>> Now that we support a timer-backed delay loop, I'm quickly getting sick
>> and tired of people complaining that their beloved bogomips value has
>> decreased. You know who you are!
> 
>> Unfortunately, we can't just remove the entry from /proc/cpuinfo, as it
>> will likely break fragile userspace code which is parsing that stuff, so
>> instead replace it with a dummy value that can be chosen in the
>> Kconfig.
> 
> So, instead of removing it you silently report invalid value? Note

Removing it would be an ABI breakage. Unfortunately.

> that there's no cpumhz display in procinfo... at least on OLPC I
> looked.

And? What does the CPU frequency bring you when any modern CPU has some
kind of cpufreq support that renders this information information pretty
much meaningless?

> And whether it is 30MHz or 3GHz cpu might be relevant information for
> userspace, and yes, bogomips used to be good enough for that.

Name one userspace application that extracts meaningful information out
of the BogoMIPS field. Just one.

> Actually it was mhz, mhz/2 or mhz*2 on pretty much all reasonable systems.

So any number within a ratio from one to four is good enough for you?
Wow. That pretty much proves the usefulness of this patch.

Additionally, having switched arch_timer capable CPUs to a timer based
delay instead of a loop-based delay means your precious pseudo-frequency
is now a thing of the past. And guess what? Nothing broke so far.
Because using BogoMIPS to deduct anything is *bogus*.

Timer-based delay calibration has been around for about ages. I still
remember the day (some 10 or 12 years ago) when DaveM switched the
UltraSPARC port to use the timer, and my BogoMIPS went from ~1000 to 12.
People moaned, DaveM held his position, and nothing happened. *Nothing*.
End of story.

	M.
-- 
Jazz is not dead. It just smells funny...
