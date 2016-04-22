From: james.morse@arm.com (James Morse)
Date: Fri, 22 Apr 2016 16:32:19 +0100
Subject: [PATCH v7 17/16] arm64: hibernate: Refuse to hibernate if the
 boot cpu is offline
In-Reply-To: <20160422104148.GD10606@leverpostej>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1460565110-26341-1-git-send-email-james.morse@arm.com>
 <20160421114415.GJ6879@leverpostej> <20160421123335.GK6879@leverpostej>
 <20160421162852.GB14030@red-moon> <20160422104148.GD10606@leverpostej>
Message-ID: <571A4403.7090100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Lorenzo,

On 22/04/16 11:41, Mark Rutland wrote:
> On Thu, Apr 21, 2016 at 05:28:52PM +0100, Lorenzo Pieralisi wrote:
>> On Thu, Apr 21, 2016 at 01:33:35PM +0100, Mark Rutland wrote:
>>> On Thu, Apr 21, 2016 at 12:44:16PM +0100, Mark Rutland wrote:
>>>> On Wed, Apr 13, 2016 at 05:31:50PM +0100, James Morse wrote:
>>>>> It is important to hibernate/resume on the same CPU, otherwise we may
>>>>> change the cpu order or restore a big cpu's register state on a little
>>>>> cpu.
>>>>>
>>>>> We know cpu 0 is the cpu the firmware booted us on last time, 
>>>>
>>>> This assumes that we only kexec from CPU0 also, which we will have to
>>>> enforce. For example, disable_nonboot_cpus() does not enforce this if
>>>> CPU0 has been hotplugged out.
>>>>
>>>> Otherwise, this kernel's CPU0 is not necessarily the CPU the FW booted
>>>> a kernel on.
>>>
>>> A better approach might be:
>>>
>>> * When going down for hibernate, store the physical CPU ID (e.g.
>>>   MPIDR_EL1.Aff*) in the header for the hibernate image.
>>>
>>> * When restoring a hibernate image, first switch over to the CPU
>>>   described in the header (rather than assuming CPU0). 
>>>
>>> I think this is a matter of adding a new disable_non_hibernate_cpus()
>>> function (defaulting to disable_nonboot_cpus()), and overriding that in
>>> the arch code. Then that can be called in resume_target_kernel.
>>
>> Yes, it looks feasible at least by code inspection, given that it
>> requires changes in core code I wonder whether it is a restriction
>> that we can remove later or we want it in from the beginning (given
>> that the issue with kexec you mention above is not present in the
>> current kernel, hopefully not for long :)).

I think this will work, the arch-header read/write happens in the right order
for it to influence which cores get plugged out.

Curiously, migrate_to_reboot_cpu() would allow us to specify which cpu we want
to run on, but disable_nonboot_cpus() doesn't...


> So long as we're not tied to a specific ABI for the hibernate image then
> we should be fine to change that later; I agree that this can be a
> subsequent improvement.
> 
> So long as we have a mechanism to detect that the hibernate image format
> changed, we should be OK to add stuff to it.

We only need to worry about this if we support resuming with a different kernel
version. I don't think we should yet, so patch 16 puts some build specific data
in the header so that even a rebuild of the same kernel will refuse to
hibernate/restore. This is roughly what the core code does if the arch doesn't
need the header. With this we are free to extend the header as we see fit.

(If a distribution wants to support different-kernel-resume, its a one line
change, and an awful lot of testing!)

One thing that really bugs me about different-kernel-resume is that if the
combination you try is not supported, the first hint you get is a regular login
screen, when you were expecting your precious in-memory data.


Thanks,

James
