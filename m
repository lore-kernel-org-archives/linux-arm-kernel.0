From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Dec 2013 16:11:01 +0000
Subject: [PATCH 2/2] kvmtool/arm: Add option to override Generic Timer
 frequency
In-Reply-To: <46C11E1C-4EEF-4EAE-9507-21384CE80127@suse.de>
References: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
 <1387305074-29421-3-git-send-email-robin.murphy@arm.com>
 <308D5B7E-5BDA-4984-9448-EAD8B5D699CF@suse.de> <52B1A6A9.1030107@arm.com>
 <46C11E1C-4EEF-4EAE-9507-21384CE80127@suse.de>
Message-ID: <52B1C915.7040000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/13 14:07, Alexander Graf wrote:
> [...]
>>> How does it encourage a vendor to properly implement their firmware if there's a workaround?
>>>
>>>
>>> Alex
>>>
>>>
>>
>> Hi Alex,
>>
>> In short, by enabling the users to create the demand. Yes, like any workaround there's potential for abuse, but having *something* that makes it work is the difference between "I want virtualisation"[1] and "Dear vendor, I've tried virtualisation on your chip/board and it's great, but it tells me I need new firmware, where do I get that?"
>>
>> Having the specs tell them what to do clearly isn't sufficient, so let's give the integrators and consumers incentive to shout at them too. The sooner proper support is commonplace and we can deprecate clock-frequency hacks altogether, the better.
>
> Oh, I'm all for hacks. But please don't fall under the illusion that this will push vendors to fix their firmware. It will have the opposite effect - vendors will just point to the workaround and say "but it works" :).
>

If vendors already aren't bothering to support functionality available 
in their flagship hardware, workarounds hardly make that worse, and are 
a win for the user. If it can drive adoption enough to get vendors to 
see the value in at least fixing future products, that's only good.

> Either way, this hack is basically required because you can't program CNTFRQ because it's controlled by secure firmware, right? So the host os already needs to know about this and probably does have a "clock-frequency" value in its device tree entry already to know how fast its clock ticks.
>

In some cases, yes. In others they don't explicitly use the arch timer 
at all thus have no frequency set anywhere. In the case of the board I 
have on my desk, it took hacking the non-secure part of the bootloader, 
writing a shim to throw away the securely-booted non-hyp cpu0 and fire 
up a secondary, and hacking a timer node into the host DT to even get as 
far as having an issue with kvmtool.

> Couldn't we search for that host entry and automatically pass it into the guest if it's there? That way the whole thing becomes seamless and even less of an issue.
>

In theory that would be an ideal solution, yes. In practice it means 
either making KVM dependent on PROC_DEVICETREE (yuck) or cooking up some 
kernel interface to expose the system timer frequency to userspace 
(double yuck). Not just "global solution to local problem", but "global 
solution to local 
problem-that-shouldn't-even-exist-and-you-want-to-go-away-as-soon-as-possible-without-leaving-a-legacy". 
Besides, that would probably just reinforce the equally wrong behaviour 
of putting the frequency in the host DT instead of fixing the firmware ;)

Robin.

>
> Alex
>
>
