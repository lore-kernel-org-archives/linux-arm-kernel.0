From: Andrew.Pinski@cavium.com (Pinski, Andrew)
Date: Wed, 26 Apr 2017 07:22:46 +0000
Subject: [PATCH v2] arm64: perf: Use only exclude_kernel attribute when
 kernel is running in HYP
In-Reply-To: <CA+7sy7D-ZB84xQ2pE-io1v7pmnAuWUszh1B=Zq+Ezup=sysQ2g@mail.gmail.com>
References: <1492623846-29335-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170420084928.GC31436@leverpostej>
 <CAFpQJXVSsg8CX28vEo2LzmOi3pknHiH233spMD6ip4LZO4vw=Q@mail.gmail.com>
 <20170424154530.GO12323@arm.com>
 <CAFpQJXWX=0GQ5hse4E_OSdnYhMOA7CvqeoHe9AdMsyoZJmrPQQ@mail.gmail.com>
 <20170425165259.GS24484@arm.com>
 <CA+7sy7D-ZB84xQ2pE-io1v7pmnAuWUszh1B=Zq+Ezup=sysQ2g@mail.gmail.com>
Message-ID: <CY4PR07MB3415C0CEBB9D3DF0C249DC6793110@CY4PR07MB3415.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2017 11:53 PM, Jayachandran C. wrote:
> Hi Will,
>
> On Tue, Apr 25, 2017 at 10:23 PM, Will Deacon <will.deacon@arm.com> wrote:
>> On Tue, Apr 25, 2017 at 09:13:40AM +0530, Ganapatrao Kulkarni wrote:
>>> On Mon, Apr 24, 2017 at 9:15 PM, Will Deacon <will.deacon@arm.com> wrote:
>>>> On Thu, Apr 20, 2017 at 02:56:50PM +0530, Ganapatrao Kulkarni wrote:
>>>>> On Thu, Apr 20, 2017 at 2:19 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>> On Wed, Apr 19, 2017 at 11:14:06PM +0530, Ganapatrao Kulkarni wrote:
>>>>>>> commit d98ecda (arm64: perf: Count EL2 events if the kernel is running in HYP)
>>>>>>> is returning error for perf syscall with mixed attribute set for exclude_kernel
>>>>>>> and exclude_hv. This change is breaking some applications (observed with hhvm)
>>>>>>> when ran on VHE enabled platforms.
>>>>>>>
>>>>>>> Adding fix to consider only exclude_kernel attribute when kernel is
>>>>>>> running in HYP. Also adding sysfs file to notify the bhehaviour
>>>>>>> of attribute exclude_hv.
>>>>>>>
>>>>>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Changelog:
>>>>>>>
>>>>>>> V2:
>>>>>>>   - Changes as per Will Deacon's suggestion.
>>>>>>>
>>>>>>> V1: Initial patch
>>>>>>>
>>>>>>>   arch/arm64/kernel/perf_event.c | 28 ++++++++++++++++++++++++----
>>>>>>>   include/linux/perf/arm_pmu.h   |  1 +
>>>>>>>   2 files changed, 25 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> @@ -871,14 +890,13 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>>>>>>>
>>>>>>>        if (attr->exclude_idle)
>>>>>>>                return -EPERM;
>>>>>>> -     if (is_kernel_in_hyp_mode() &&
>>>>>>> -         attr->exclude_kernel != attr->exclude_hv)
>>>>>>> -             return -EINVAL;
>>>>>>> +     if (is_kernel_in_hyp_mode() && !attr->exclude_kernel)
>>>>>>> +             config_base |= ARMV8_PMU_INCLUDE_EL2;
>>>>>>>        if (attr->exclude_user)
>>>>>>>                config_base |= ARMV8_PMU_EXCLUDE_EL0;
>>>>>>>        if (!is_kernel_in_hyp_mode() && attr->exclude_kernel)
>>>>>>>                config_base |= ARMV8_PMU_EXCLUDE_EL1;
>>>>>>> -     if (!attr->exclude_hv)
>>>>>>> +     if (!is_kernel_in_hyp_mode() && !attr->exclude_hv)
>>>>>>>                config_base |= ARMV8_PMU_INCLUDE_EL2;
>>>>>> This isn't quite what Will suggested.
>>>>>>
>>>>>> The idea was that userspace would read sysfs, then use that to determine
>>>>>> the correct exclusion parameters [1,2]. This logic was not expected to
>>>>>> change; it correctly validates whether we can provide what the user
>>>>>> requests.
>>>>> OK, if you are ok with sysfs part, i can send next version with that
>>>>> change only?.
>>>> I think the sysfs part is still a little dodgy, since you still expose the
>>>> "exclude_hv" file with a value of 0 when not running at EL2, which would
>>>> imply that exclude_hv is forced to zero. I don't think that's correct.
>>> okay, i can make exclude_hv visible only when kernel booted in EL2.
>>> is it ok to have empty directory "attr" when kernel booted to EL1?
>>> attr can be place holder for any other miscellaneous attributes, that
>>> can be added in future.
>> Sounds good to me, although I'll seek comment from the other perf folks
>> before merging anything with ABI implications.
> Do you really think this is the solution given:
> - this is an arm64 specific sysfs interface that is tied to the perf API
> - the perf API documentation has to be updated for this
> - All the applications that use the perf API have to be modified to
> check this sysfs interface
> - If the application fails to do so, a very narrow corner case
> (exclude_hv != exclude_kernel and VHE enabled) fails.
>
> Any application that really cares can already do see if exclude_hv !=
> exclude_kernel case works by calling perf_open_event() with those
> options and checking the return value.

An example of an application which needs to changed is HHVM. Currently 
it sets exclude_hv to true but exclude_kernel to false as it does not 
care about the hypervisor associated perf events associated with the 
code, only the kernel and userspace associated evnts.
Yes we could submit a patch to use the sysfs interface to check but it 
would look funny and the facebook folks might reject the patch as it is 
ARM64 specific in generic code.  Note this is how all of this discussion 
started was HHVM's call to perf_open_event was failing.

Thanks,
Andrew Pinski

>
> Hope I am mistake here, otherwise this does not sound like a good idea.
>
> JC.
