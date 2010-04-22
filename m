From: siarhei.siamashka@nokia.com (Siarhei Siamashka)
Date: Thu, 22 Apr 2010 15:49:25 +0300
Subject: Can I use VFP in work queue context ?
In-Reply-To: <2A1038AD87AFFA4291065666737B4EAA08CB0BA1BC@dlee06.ent.ti.com>
References: <2A1038AD87AFFA4291065666737B4EAA08CB0BA1BC@dlee06.ent.ti.com>
Message-ID: <201004221549.26344.siarhei.siamashka@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 April 2010 02:11:18 ext Anbumony, Kasi Lakshman Karthi wrote:
> I have done some optimization in NEON (Neon/VFP sharing the same register
> set) and using it in my driver running in (Linux) kernel space. The neon
> optimized code will be used under a work queue context and not under any
> interrupt. Going by the design of Linux kernel, it looks like there is no
> context save and restore on VFP registers whenever there is a context
> switch from user mode to kernel mode, but Linux handles the same for user
> space processes.
>
> Currently I am not seeing any issues (may be lucky) with my implementation
> (any exceptions) and was wondering whether it is safe to use of neon code
> in work queue context? My development platform is OMAP 3 (ARM cortex A-8)
> and using Android with Linux kernel: 2.6.29.

I also thought about the possibility to use NEON in the kernel some time ago,
but did not pursue it further, expecting negative feedback similar to what you
are getting now ;-)

Some MMX/SSE2 code exists in the kernel already if you grep the sources. It
might give you some ideas. Naturally preemption has to be disabled and NEON
state fully saved/restored on entry/exit, like in 'kernel_fpu_begin' and 
'kernel_fpu_end' functions for x86. For ARM Cortex-A8 using NEON may be a bit
more difficult because NEON is in a separate power domain and may be switched
off at the time you want to use it. There may be some other technical problems
for sure, so the comments from someone knowledgeable would be very
interesting to read.

-- 
Best regards,
Siarhei Siamashka
