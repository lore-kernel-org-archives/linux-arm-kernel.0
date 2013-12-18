From: agraf@suse.de (Alexander Graf)
Date: Wed, 18 Dec 2013 15:07:43 +0100
Subject: [PATCH 2/2] kvmtool/arm: Add option to override Generic Timer
 frequency
In-Reply-To: <52B1A6A9.1030107@arm.com>
References: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
 <1387305074-29421-3-git-send-email-robin.murphy@arm.com>
 <308D5B7E-5BDA-4984-9448-EAD8B5D699CF@suse.de> <52B1A6A9.1030107@arm.com>
Message-ID: <46C11E1C-4EEF-4EAE-9507-21384CE80127@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 18.12.2013, at 14:44, Robin Murphy <robin.murphy@arm.com> wrote:

> On 17/12/13 20:39, Alexander Graf wrote:
>> 
>> On 17.12.2013, at 19:31, Robin Murphy <robin.murphy@arm.com> wrote:
>> 
>>> Some platforms have secure firmware which does not correctly set the
>>> CNTFRQ register on boot, preventing the use of the Generic Timer.
>>> This patch allows mirroring the necessary host workaround by specifying
>>> the clock-frequency property in the guest DT.
>>> 
>>> This should only be considered a means of KVM bring-up on such systems,
>>> such that vendors may be convinced to properly implement their firmware
>>> to support the virtualisation capabilities of their hardware.
>>> 
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> Acked-by: Will Deacon <will.deacon@arm.com>
>> 
>> How does it encourage a vendor to properly implement their firmware if there's a workaround?
>> 
>> 
>> Alex
>> 
>> 
> 
> Hi Alex,
> 
> In short, by enabling the users to create the demand. Yes, like any workaround there's potential for abuse, but having *something* that makes it work is the difference between "I want virtualisation"[1] and "Dear vendor, I've tried virtualisation on your chip/board and it's great, but it tells me I need new firmware, where do I get that?"
> 
> Having the specs tell them what to do clearly isn't sufficient, so let's give the integrators and consumers incentive to shout at them too. The sooner proper support is commonplace and we can deprecate clock-frequency hacks altogether, the better.

Oh, I'm all for hacks. But please don't fall under the illusion that this will push vendors to fix their firmware. It will have the opposite effect - vendors will just point to the workaround and say "but it works" :).

Either way, this hack is basically required because you can't program CNTFRQ because it's controlled by secure firmware, right? So the host os already needs to know about this and probably does have a "clock-frequency" value in its device tree entry already to know how fast its clock ticks.

Couldn't we search for that host entry and automatically pass it into the guest if it's there? That way the whole thing becomes seamless and even less of an issue.


Alex
