From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 27 Sep 2017 20:42:32 +0800
Subject: [PATCH v3 1/3] arm64/ras: support sea error recovery
In-Reply-To: <59BC1CEE.8010708@arm.com>
References: <1504770316-4327-1-git-send-email-xiexiuqi@huawei.com>
 <1504770316-4327-2-git-send-email-xiexiuqi@huawei.com>
 <59B2DE26.4060002@arm.com> <52d2868c-79cd-8ff8-8e1d-6078d02d5a0c@huawei.com>
 <59BC1CEE.8010708@arm.com>
Message-ID: <9bff629e-020a-d6f9-b688-36f8347ac5e5@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

I'll send v4 to fix some small issue, for same one who interested
with this feature could test it. For the question you mentioned,
I will study in depth.

Any comments is welcome.

On 2017/9/16 2:33, James Morse wrote:
> Hi Xie XiuQi,
> 
> On 11/09/17 15:11, Xie XiuQi wrote:
>> I first describe the approach of this patchset:
>>
>> A memory access error on the execution path usually triggers SEA.
>> According to the existing process, errors occurred in the kernel,
>> leading to direct panic, if it occurred the user-space, we should
>> just kill process.
>>
>> But there is a class of error, in fact, is not necessary to kill
>> process, you can recover and continue to run the process. Such as
>> the instruction data corrupted, where the memory page might be
>> read-only, which is has not been modified, the disk might have the
>> correct data, so you can directly drop the page, ant reload it when
>> necessary.
>>
>> So this patchset is just try to solve such problem: if the error is
>> consumed in user-space and the error occurs on a clean page, you can
>> directly drop the memory page without killing process.
>>
>> This is implemented in memory_failure, which is generic process.
> 
>> The error reported by SEA should be handled before re-enter the process,
>> or we must kill the process to prevent error propagation.
>>
>> memory_failure_queue() is asynchronous, in which, error info was saved
>> at ghes_proc, but handled in kworker. During this period there is a context
>> switching, so we can not determine which process would be switch to. So
>> memory_failure_queue is not suitable for handling the problem.
> 
> Thanks for this summary. I see the problem you're trying to solve is when
> memory_failure() runs, in your scenario its not guaranteed to run before we
> return to user space.
> 
> What is the user-visible symptom of this? SIGBUS, code=0 instead of SIGBUS,
> code=...MCEERR_A?
> 
> ..in which case I'm looking at this as a race with the memory_failure() bottom
> half via schedule_work().
> 
> How does x86 avoid this same problem?
> 
> 
>> And memory_failure is not nmi-safe, so it can not be called directly in the
>> SEA context. So we just handle this error at SEA exit path, and before context
>> switching.
> 
> (I need to look more into which locks memory_failure() is taking)
> 
> 
>> In FFH mode, physical address can only be obtained by parsing the GHES table.
>> But we only care about SEA, so the error handling is tied to the type of notification.
> 
> I care about all the notification methods. Once the notification has been passed
> to APEI I want them to behave the same so that we don't have subtle bugs between
> the 11 different ways we could get a notification. This code is rarely tested
> enough as it is.
> 
>>From the arch code I just want to call out to APEI asking 'is this yours?'. If
> so I expect APEI to have done all the work, if not we take the v8.0 behaviour.
> 
> 
> Here you need APEI and the arch code to spot 'SEA' and treat it differently,
> invoking some arm64-specific behaviour for APEI, and some
> not-really-arch-specific code under /arch/arm64. There is nothing arm64 specific
> about your arm_process_error(), how come the core APEI code doesn't need to do this?
> 
> 
> I think this is caused by the way memory_failure() schedules its work, and that
> is where I'd like to try and fix this, so that its the same for all notification
> methods and all (cough: both) architectures.
> 
> 
>> The TIF flag is checked on a generic path, but it will only be set when SEA occurs.
>> And if we use unlikely optimization, it should have little impact on performance.
> 
> Yes, the arch code checks _TIF_WORK_MASK in one go so there is no performance
> problem for code that hasn't taken the RAS-Error. (and once we've taken a RAS
> error performance is out the window!)
> 
> 
>> And the TIF flag approach was used on x86 platform for years, until commit d4812e169d
> 
> ... so x86 doesn't do this ...
> 
>> (x86, mce: Get rid of TIF_MCE_NOTIFY and associated mce tricks)[0]. On currently arm64
>> platform, there is no IST interrupt[1] function, so we could not call memory_failure
>> directly in SEA context. So the way to use TIF notification, is also a good choice,
>> after all, the same way on x86 platform is verified.
> 
> Thanks, looks like I need to read more of the history of x86's kernel-first
> handling...
> 
> 
> Thanks,
> 
> James
> 
> 
> .
> 

-- 
Thanks,
Xie XiuQi
