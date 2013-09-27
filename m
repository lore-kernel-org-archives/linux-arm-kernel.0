From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Sep 2013 17:16:22 +0100
Subject: [RFT PATCH v1 0/7] enable FPSIMD lazy save and restore for arm64
In-Reply-To: <5245A22F.7020305@gmail.com>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
 <20130927105045.GA11063@MacBook-Pro.local>
 <20130927112332.GD9520@mudshark.cambridge.arm.com>
 <5245A22F.7020305@gmail.com>
Message-ID: <20130927161622.GH26069@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 04:20:15PM +0100, Jiang Liu wrote:
> 	The patchset actually includes three optimizations.
> 
> The first one uses PF_USED_MATH to track whether the thread has
> accessed FPSIMD registers since it has been created. If the thread
> hasn't accessed FPSIMD registers since it's birth, we don't need to
> save and restore FPSIMD context on thread context switching.

But for detecting whether a thread used the FP/SIMD registers, you need
to disable the FP at context switch and trap the initial access. That's
one of the main issues with lazy saving/restoring and sometimes it could
be less efficient.

> The second one uses a percpu variable to track the owner of the
> FPSIMD hardware. When switching a thread, if it's the owner of
> the FPSIMD hardware, we don't need to load FPSIMD registers again.
> This is useful when context switching between user thread and
> kernel(idle) threads.

fpsimd_thread_switch() checks whether it switches to/from kernel thread.
I think we could do a bit better and avoid restoring if returning to the
same user thread but without the need for disabling the FP on thread
switch. I'm happy to take this part if factored out of the lazy patches
(for the rest I'd like to see benchmarks).

> The third one disable access to FPSIMD registers when switching a
> thread. When the thread tries to access FPSIMD registers the first
> time since it has been switched in, an exception is raised and then
> we will load FPSIMD context onto hardware.
> 
> The overhead (penalty) of the first and second optimizations is
> relatively small, so we could always enable them.

How do you detect that a thread used fpsimd?

-- 
Catalin
