From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 16 Jul 2015 15:03:50 +0300
Subject: [PATCH 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
In-Reply-To: <alpine.DEB.2.02.1507161012090.32764@utopia.booyaka.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
 <55A4DFEF.6040005@ti.com> <55A52208.5060302@ti.com>
 <alpine.DEB.2.02.1507160014371.32764@utopia.booyaka.com>
 <55A758A3.2070108@ti.com>
 <alpine.DEB.2.02.1507161012090.32764@utopia.booyaka.com>
Message-ID: <55A79DA6.4070206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2015 01:13 PM, Paul Walmsley wrote:
> On Thu, 16 Jul 2015, Tero Kristo wrote:
>
>> On 07/16/2015 03:15 AM, Paul Walmsley wrote:
>>> On Tue, 14 Jul 2015, Tero Kristo wrote:
>>>
>>>> On 07/14/2015 01:09 PM, Lokesh Vutla wrote:
>>>>> Hi,
>>>>> On Wednesday 10 June 2015 02:56 PM, Lokesh Vutla wrote:
>>>>>> Some IP blocks like RTC, needs an additional unlocking mechanism for
>>>>>> writing to its registers. This patch adds optional lock and unlock
>>>>>> function pointers to the IP block's hwmod data which gets executed
>>>>>> before and after writing into IP sysconfig register.
>>>>>> And also hook lock and unlock functions to AMx3xx, DRA7 RTC hwmod
>>>>>> data,
>>>>>> so that sysconfig registers are updated properly.
>>>>> ping on this series.
>>>>>
>>>>> Thanks and regards,
>>>>> Lokesh
>>>>
>>>
>>> [...]
>>>
>>>> It is also racy, as there is no locking in place to avoid concurrent
>>>> access to
>>>> the lock/unlock registers across hwmod+driver.
>>>
>>> I don't see the race.  Where is it?
>>
>> See drivers/rtc/rtc-omap.c, am3352_rtc_unlock and am3352_rtc_lock.
>>
>> That code is accessing the exact same registers.
>
> I guess my question is, when is it possible that code could race with the
> hwmod code for the same device?

Hmm yea I think you are right, this only gets potentially called within 
pm_runtime_get/put_sync for RTC.

The current sequence is highly inefficient though, as we are doing 
multiple lock/unlock operations to the RTC from multiple sources. See 
following rtcwake trace on am43xx-gp-evm as an example.


/ # rtcwake -s 4 -m mem
[    7.425322] am3352_rtc_unlock
[    7.428330] am3352_rtc_lock
[    7.431139] am3352_rtc_unlock
[    7.434116] am3352_rtc_lock
wakeup from "mem" at Sat Jan  1 00:00:11 2000
[    7.448549] PM: Syncing filesystems ... done.
[    7.455425] Freezing user space processes ... (elapsed 0.001 seconds) 
done.
[    7.463738] Freezing remaining freezable tasks ... (elapsed 0.001 
seconds) do
ne.
[    7.472532] Suspending console(s) (use no_console_suspend to debug)
[    7.481878] am3352_rtc_unlock
[    7.481889] am3352_rtc_lock
[    7.482307] PM: suspend of devices complete after 2.713 msecs
[    7.483479] PM: late suspend of devices complete after 1.153 msecs
[    7.484727] omap_hwmod_rtc_unlock
[    7.484733] omap_hwmod_rtc_lock
[    7.485182] PM: noirq suspend of devices complete after 1.685 msecs
[    7.485190] Disabling non-boot CPUs ...
[    7.485199] PM: Successfully put all powerdomains to target state
[    7.485199] PM: Wakeup source RTC Alarm
[    7.499853] PM: noirq resume of devices complete after 14.558 msecs
[    7.500047] am3352_rtc_unlock
[    7.500052] am3352_rtc_lock
[    7.500123] am3352_rtc_unlock
[    7.500128] am3352_rtc_lock
[    7.501019] PM: early resume of devices complete after 0.809 msecs
[    7.501464] am3352_rtc_unlock
[    7.501472] am3352_rtc_lock
[    7.558046] PM: resume of devices complete after 57.007 msecs
[    7.638807] Restarting tasks ... done.
[    7.643173] am3352_rtc_unlock
[    7.646162] am3352_rtc_lock

But, I guess this is for some interested party to optimize if needed, 
and it is mostly an issue with the RTC driver itself.

-Tero
