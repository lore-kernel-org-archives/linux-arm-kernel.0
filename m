From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 25 Feb 2015 12:33:19 -0600
Subject: [PATCH] arm64: vdso: minor ABI fix for clock_getres
In-Reply-To: <20150225163243.GM12377@arm.com>
References: <1424820067-13112-1-git-send-email-nathan_lynch@mentor.com>
 <20150225160226.GL12377@arm.com> <54EDF4DB.5080007@mentor.com>
 <20150225163243.GM12377@arm.com>
Message-ID: <54EE156F.7090907@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2015 10:32 AM, Will Deacon wrote:
> On Wed, Feb 25, 2015 at 04:14:19PM +0000, Nathan Lynch wrote:
>> On 02/25/2015 10:02 AM, Will Deacon wrote:
>>> On Tue, Feb 24, 2015 at 11:21:07PM +0000, Nathan Lynch wrote:
>>>> The vdso implementation of clock_getres currently returns 0 (success)
>>>> whenever a null timespec is provided by the caller, regardless of the
>>>> clock id supplied.
>>>>
>>>> This behavior is incorrect.  It should fall back to syscall when an
>>>> unrecognized clock id is passed, even when the timespec argument is
>>>> null.  This ensures that clock_getres always returns an error for
>>>> invalid clock ids.
>>>>
>>>> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
>>>> ---
>>>>  arch/arm64/kernel/vdso/gettimeofday.S | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>>
>>> Thanks, Nathan.
>>
>> Thank you.  I'm curious -- do you know of a use case for the VDSO
>> implementation of clock_getres?  I.e. what kind of real-world workload
>> sees a benefit from it?
> 
> No, I just implemented it for completeness (and it's also way simpler than
> the other functions!).

Yeah it was the first function I implemented for the arm32 vdso :-)


> Calling it with a NULL timespec is probably even
> less common, so an alternative to your patch would be changing the label
> of the existing cbz to hand-off to the kernel when the thing is NULL.

Yes, but I'll leave it alone unless you'd prefer that to this patch.


>> I'm not suggesting removing it from the arm64 vdso, but I'm considering
>> dropping clock_getres from the 32-bit ARM vdso patch set since I haven't
>> been able to answer this.
> 
> Well, if there aren't any fastpath users then I'm not bothered about
> removing it from arm64 either. I'm not sure how we establish that, though.

FWIW x86 has never implemented it, which makes me think there's little
demand for it.

I stumbled upon another reason to omit clock_getres from the arm32 vdso.
 If you have CONFIG_HIGHRES_TIMERS=y and the kernel doesn't switch to
high-res mode for whatever reason (this happens for me in qemu), the
vdso clock_getres returns a different result than the syscall does:

# vdsotest clock-getres-monotonic verify
clock resolutions differ:
        [0, 10000000] (kernel)
        [0, 1] (vDSO)

Not sure whether this is a concern for arm64 since I think the only way
to provoke it there is to boot with clocksource=jiffies.
