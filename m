From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 30 Mar 2017 10:00:30 +0100
Subject: [PATCH v5 6/9] coresight: add support for CPU debug module
In-Reply-To: <20170330010343.GA31843@leoy-linaro>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
 <20170328165010.GA21937@linaro.org> <20170329015423.GA5035@leoy-linaro>
 <CAJ9a7VhQRuVOCJkjPc9RANGo=fgA8wjtB65dC5f19ZX22a5FHQ@mail.gmail.com>
 <20170330010343.GA31843@leoy-linaro>
Message-ID: <a9078a4e-152e-01ae-8750-1396da2bc623@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/17 02:03, Leo Yan wrote:
> On Wed, Mar 29, 2017 at 03:56:23PM +0100, Mike Leach wrote:
>
> [...]
>
>>>>> +   /*
>>>>> +    * Unfortunately the CPU cannot be powered up, so return
>>>>> +    * back and later has no permission to access other
>>>>> +    * registers. For this case, should set 'idle_constraint'
>>>>> +    * to ensure CPU power domain is enabled!
>>>>> +    */
>>>>> +   if (!(drvdata->edprsr & EDPRSR_PU)) {
>>>>> +           pr_err("%s: power up request for CPU%d failed\n",
>>>>> +                   __func__, drvdata->cpu);
>>>>> +           goto out;
>>>>> +   }
>>>>> +
>>>>> +out_powered_up:
>>>>> +   debug_os_unlock(drvdata);
>>>>> +
>>>>> +   /*
>>>>> +    * At this point the CPU is powered up, so set the no powerdown
>>>>> +    * request bit so we don't lose power and emulate power down.
>>>>> +    */
>>>>> +   drvdata->edprsr = readl(drvdata->base + EDPRCR);
>>>>> +   drvdata->edprsr |= EDPRCR_COREPURQ | EDPRCR_CORENPDRQ;
>>>>
>>>> If we are here the core is already up.  Shouldn't we need to set
>>>> EDPRCR_CORENPDRQ only?
>>>
>>> Yeah. Will fix.
>>
>> No - EDPRCR_COREPURQ and EDPRCR_CORENPDRQ have different semantics and purposes
>>
>> EDPRCR_COREPURQ is in the debug power domain an is tied to an external
>> debug request that should be an input to the external (to the PE)
>> system power controller.
>> The requirement is that the system power controller powers up the core
>> domain and does not power it down while it remains asserted.
>>
>> EDPRCR_CORENPDRQ is in the core power domain and thus to the specific
>> core only. This ensures that any power control software running on
>> that core should emulate a power down if this is set to one.
>
> I'm curious the exact meaning for "power control software".
>
> Does it mean EDPRCR_CORENPDRQ should be checked by kernel or PSCI
> liked code in ARM trusted firmware to avoid to run CPU power off flow?
>
> Or will EDPRCR_CORENPDRQ assert CPU external signal to notify power
> controller so power controller emulate a power down?
>
>> We cannot know the power control design of the system, so the safe
>> solution is to set both bits.
>
> Thanks a lot for the suggestion. Will set both bits.

Leo,

Also, it would be good to restore the PRCR register back to the original state
after we read the registers (if we changed them). I am exploring ways to make
use of this feature on demand (e.g, tie it to sysrq-t or sysrq-l) and not just
at panic time. So it would be good to have the state restored to not affect the
normal functioning even after dumping the registers.

PS: I have a small hack to hook this into a sysrq-x at runtime, but on a second thought
it is better not to consume the key and rather tie it to something which already exist,
as mentioned above.

Thanks
Suzuki

>
> Thanks,
> Leo Yan
>
