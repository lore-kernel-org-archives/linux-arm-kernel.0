From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 15 Nov 2013 17:38:53 +0000
Subject: [PATCH v2] ARM: kexec: Use the right ISA for relocate_new_kernel
In-Reply-To: <52860555.7010307@linaro.org>
References: <1383913444-9153-1-git-send-email-Dave.Martin@arm.com>
 <20131108133426.GE17461@mudshark.cambridge.arm.com>
 <20131108184625.GE2602@localhost.localdomain>
 <5282818B.9030903@linaro.org> <52860555.7010307@linaro.org>
Message-ID: <20131115173113.GB4028@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:28:21PM +0200, Taras Kondratiuk wrote:
> On 11/12/2013 09:29 PM, Taras Kondratiuk wrote:
> > Hi Dave
> > 
> > Yes. I've tested it on Pandaboard and results are quite weird.
> > ARM->ARM, Thumb->Thumb and Thumb->ARM kernel transition works fine
> > for both kexec and kdump ways. But ARM->Thumb works for only kdump
> > via kernel panic. In case of "kexec -e" the second Thumb kernel
> > doesn't come up.
> > 
> > I don't have JTAG now. I will check this tomorrow morning.
> 
> Hi Dave, Will
> 
> The issue I observed is not caused by this patch.
> I was able to reproduce it with my initial simple patch.
> 
> So for this one:
> Reported-and-Tested-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>

Thanks for that.

> 
> And the issue I'm frequently facing in reloaded kernel (Thumb from ARM)
> is random crashes caused by undefined instructions.
> 
> My observation summary:
> - Before starting a second kernel I'm dumping loaded zImage and then
>   unpacked Image at final location and they are correct, so no issue
>   with loading.
> - I observe two types of crash:
>   1) Undefined instruction in the middle of kernel code. After a crash
>      I check failing address and there is always a *valid* Thumb
>      instruction (CPU is in Thumb mode).
>   2) Jump to a wrong address which consequently causes undefined
>      instruction exception. A trace of one example of a wrong jump is
>      captured in [1]. Instead of jumping to 0xC049097C code gets
>      executed at 0xED85E008. BTW the wrong address suspiciously looks
>      like an ARM instruction.

That jump to 0xED85E008 certainly looks strange ... I wonder whether
there could be some instructions missing from the trace.


How early do these crashes happen?

Is this happening on SMP, and if so, what is the state of secondary
CPUs across kexec?

If secondary CPUs are not safely parked, or their caches are not drained
before the kexec occurs, this can cause corruption of the new kernel
or unpredictable behaviour of the secondary CPUs.

> - If second kernel is placed at different address (like in kdump case),
>   then it boots fine and I don't observe any crashes.
> - If I check failing address in the first kernel (ARM) the code there
>   is really undefined instruction if executed as Thumb.
> - Looks like pieces of old ARM kernel gets executed instead of new
>   Thumb kernel. But as I've mentioned I'm reading physical memory via
>   JTAG before starting second kernel and memory is matching a compiled
>   Thumb 'Image'. Icache also gets cleaned...
> - Once when stopped on breakpoint I've seen a piece of ARM code in
>   Thumb kernel. Interesting that I was looking at the same memory

Thumb kernels do contain a small amount of ARM code, in the vectors
page for example.  But it's possible you were also looking at stale
data.

>   location via physical and virtual addresses simultaneously and only
>   virtual address showed an old code. After a few memory browsing

It's possible that those views could be inconsistent either due to
the behaviour of the debugger, or because inconsistent memory types
are used to construct the two views.

>   operations, data at both addresses got synced to correct Thumb code.
>   Sure it could be a debugger lag, but it fits nicely with other
>   observations.
> 
> Do you have some ideas what could cause such behavior?

Not really, apart from the above ideas.

> 
> Unfortunately I don't have more time now to debug it further,
> but I will try to return to this later.

OK ... let me know if you see this again or get any more clues.

Cheers
---Dave

> 
> [1]
> https://drive.google.com/file/d/0ByfnRzd5ZYtdQWJKc1k0VmxrZlE/edit?usp=sharing
> 
> -- 
> Taras Kondratiuk
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
