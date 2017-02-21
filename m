From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 18:27:59 +0000
Subject: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
In-Reply-To: <81df65a9-d2f1-26df-a977-5265feba25a3@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <69ab75a1-2e04-19e2-d1ad-12ca1cfc7625@arm.com>
 <CAMuHMdWjseO3XSOH2XCbM411Aj12RpdZZbHkpfFUfej58myz5Q@mail.gmail.com>
 <445b2f49-5d15-30af-a431-1c4edcd049a4@arm.com>
 <CAMuHMdUS96tPJRqNxG6sJjvC0LN-FjCeKOm7Zg2V_qMeQ_1QSQ@mail.gmail.com>
 <81df65a9-d2f1-26df-a977-5265feba25a3@arm.com>
Message-ID: <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/02/17 17:51, Sudeep Holla wrote:
> 
> 
> On 21/02/17 17:34, Geert Uytterhoeven wrote:

[...]

>>
>> The SoC can wake-up. It's just not guaranteed that it can wake-up using
>> the wakeup-source configured from Linux. Which wakeup-sources are available
>> depends on the actual PSCI implementation.  It's not specified by the PSCI
>> specification.
>>
>>> Just botching whatever shallow state you can enter on a particular SoC
>>> into standard "mem" state sounds *horrible* to me.
>>
>> That's more or less what /sys/power/mem_sleep does, though.
>>
> 
> OK, I will go through that in detail.
> 

OK, I went through the patch and the main intention is was added.
So I will begin by summarizing my understanding:

A new suspend interface(/sys/power/mem_sleep) is added to allow the
"mem" string in /sys/power/state to represent multiple things that can
be selected.

Before:
A. echo freeze > /sys/power/state ---> Enters s2idle
B. echo mem > /sys/power/state ---> Enters s2r(a.k.a now deep mem sleep)

After:
1. echo freeze > /sys/power/state ---> Enters s2idle still same
2. echo s2idle > /sys/power/mem_sleep
   echo mem > /sys/power/state ---> Also enter s2idle
3. echo deep > /sys/power/mem_sleep
   echo mem > /sys/power/state ---> Also enter s2r(same as [B] above)

Please note I have carefully dropped standby/shallow as we will not
support that state on ARM64 platforms(refer previous discussions for the
same)

Now IIUC, you need 2 above. So, since this new interface allow mem to
mean "s2idle", we need to fix the core to register default suspend_ops
to achieve what you need. And since I now better understand you problem,
you get extra NACK for this series ;)

-- 
Regards,
Sudeep
