From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 01 Aug 2013 10:25:55 -0600
Subject: [PATCH] ARM: kexec: offline non panic CPUs on Kdump panic
In-Reply-To: <CALicx6u5tkf_wvX8ZcVwbhUOkt3=Zz7214yR9pVce0TJ82Vt4A@mail.gmail.com>
References: <1374817287-27952-1-git-send-email-vijay.kilari@gmail.com>
 <20130726104908.GC17886@mudshark.cambridge.arm.com>
 <51F2ACF7.9000008@wwwdotorg.org>
 <CALicx6ugumPG__rSAsTS95SH=6fTGqhpPFsQ8bLG-u-fbk0=pQ@mail.gmail.com>
 <51F7F0E1.5030200@wwwdotorg.org>
 <CALicx6tJFkGbvKO+-XZixj+8RSh1awFnXK91Pdew1+5Oa+dDqg@mail.gmail.com>
 <51F945F9.3050906@wwwdotorg.org>
 <CALicx6u5tkf_wvX8ZcVwbhUOkt3=Zz7214yR9pVce0TJ82Vt4A@mail.gmail.com>
Message-ID: <51FA8C13.2060807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2013 07:49 AM, Vijay Kilari wrote:
> On Wed, Jul 31, 2013 at 10:44 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 07/31/2013 05:37 AM, Vijay Kilari wrote:
>>> On Tue, Jul 30, 2013 at 10:29 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> On 07/30/2013 04:37 AM, Vijay Kilari wrote:
>>>>> On Fri, Jul 26, 2013 at 10:38 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> ...
>>>>>> Does a kernel that's used as the crash kernel guarantee:
>>>>>>
>>>>>> * Never to re-use the memory that was used by the previous kernel, so
>>>>>> that the spin loop code/data won't be corrupted, ever, no matter how
>>>>>> long the crash recovery kernel runs.
>>>>>>
>>>>>> * Not use SMP, so there's never a need to re-activate the non-boot CPUs,
>>>>>> which might not work if they aren't truly disabled but rather just
>>>>>> running a pin loop?
>>>>>
>>>>> From cat /proc/iomem, normal kernel is executed from (0x80xxxxxx) with crash
>>>>> kernel reserved 64M at 0xa0000000
>>>>>
>>>>> 80000000-bfffffff : System RAM
>>>>>   80008000-805aeddf : Kernel code
>>>>>   805e2000-8063e427 : Kernel data
>>>>>   a0000000-a3ffffff : Crash kernel
>>>>>
>>>>> crash kernel is loaded to reserved memory location and is executed from there.
>>>>> I could confirm this from /proc/iomem when crash kernel is running
>>>>>
>>>>> a0000000-a3efffff : System RAM
>>>>>   a0008000-a05aeddf : Kernel code
>>>>>   a05e2000-a063e427 : Kernel data
>>>>
>>>> OK, but in the crash dump kernel, is 80008000..8063e427 reserved as
>>>> well, which would guarantee that the spin loop being executed by the
>>>> non-crash CPUs won't be corrupted?
>>>
>>> The crash dump kernel runs from reserved memory area (0xa0000000 - 0xa3effffff).
>>>  So it should not corrupt the memory area of original kernel that was running
>>>  at 0x80000000,where other CPU's are in spin loop.
>>
>> What about dynamic allocations?
>
> IMHO, it is the kdump functionality to ensure that it won't corrupt
> original kernel's dynamic allocations

OK, if there are explicit measure to assure this already, then there's
no issue.
