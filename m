From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 15 Nov 2013 20:11:43 +0200
Subject: [PATCH v2] ARM: kexec: Use the right ISA for relocate_new_kernel
In-Reply-To: <20131115173113.GB4028@e103592.cambridge.arm.com>
References: <1383913444-9153-1-git-send-email-Dave.Martin@arm.com>
 <20131108133426.GE17461@mudshark.cambridge.arm.com>
 <20131108184625.GE2602@localhost.localdomain> <5282818B.9030903@linaro.org>
 <52860555.7010307@linaro.org>
 <20131115173113.GB4028@e103592.cambridge.arm.com>
Message-ID: <528663DF.1010008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2013 07:38 PM, Dave Martin wrote:
> On Fri, Nov 15, 2013 at 01:28:21PM +0200, Taras Kondratiuk wrote:
>> And the issue I'm frequently facing in reloaded kernel (Thumb from ARM)
>> is random crashes caused by undefined instructions.
>>
>> My observation summary:
>> - Before starting a second kernel I'm dumping loaded zImage and then
>>   unpacked Image at final location and they are correct, so no issue
>>   with loading.
>> - I observe two types of crash:
>>   1) Undefined instruction in the middle of kernel code. After a crash
>>      I check failing address and there is always a *valid* Thumb
>>      instruction (CPU is in Thumb mode).
>>   2) Jump to a wrong address which consequently causes undefined
>>      instruction exception. A trace of one example of a wrong jump is
>>      captured in [1]. Instead of jumping to 0xC049097C code gets
>>      executed at 0xED85E008. BTW the wrong address suspiciously looks
>>      like an ARM instruction.
> 
> That jump to 0xED85E008 certainly looks strange ... I wonder whether
> there could be some instructions missing from the trace.
> 
> 
> How early do these crashes happen?

At very early stages starting from setup_arch() up to early initcalls.

> Is this happening on SMP, and if so, what is the state of secondary
> CPUs across kexec?

I have disabled CONFIG_SMP. Second CPU is busy-looping in ROM code and
shouldn't cause any issues.

> If secondary CPUs are not safely parked, or their caches are not drained
> before the kexec occurs, this can cause corruption of the new kernel
> or unpredictable behaviour of the secondary CPUs.
> 
>> - If second kernel is placed at different address (like in kdump case),
>>   then it boots fine and I don't observe any crashes.
>> - If I check failing address in the first kernel (ARM) the code there
>>   is really undefined instruction if executed as Thumb.
>> - Looks like pieces of old ARM kernel gets executed instead of new
>>   Thumb kernel. But as I've mentioned I'm reading physical memory via
>>   JTAG before starting second kernel and memory is matching a compiled
>>   Thumb 'Image'. Icache also gets cleaned...
>> - Once when stopped on breakpoint I've seen a piece of ARM code in
>>   Thumb kernel. Interesting that I was looking at the same memory
> 
> Thumb kernels do contain a small amount of ARM code, in the vectors
> page for example.  But it's possible you were also looking at stale
> data.

Right, but I mean there was an ARM code in place where definitely a
Thumb code should be.

> 
>>   location via physical and virtual addresses simultaneously and only
>>   virtual address showed an old code. After a few memory browsing
> 
> It's possible that those views could be inconsistent either due to
> the behaviour of the debugger, or because inconsistent memory types
> are used to construct the two views.
> 
>>   operations, data at both addresses got synced to correct Thumb code.
>>   Sure it could be a debugger lag, but it fits nicely with other
>>   observations.
>>
>> Do you have some ideas what could cause such behavior?
> 
> Not really, apart from the above ideas.
> 
>>
>> Unfortunately I don't have more time now to debug it further,
>> but I will try to return to this later.
> 
> OK ... let me know if you see this again or get any more clues.
> 
> Cheers
> ---Dave
> 
>>
>> [1]
>> https://drive.google.com/file/d/0ByfnRzd5ZYtdQWJKc1k0VmxrZlE/edit?usp=sharing
>>
>> -- 
>> Taras Kondratiuk

-- 
Taras Kondratiuk
