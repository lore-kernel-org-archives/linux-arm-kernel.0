From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 May 2015 10:40:32 +0100
Subject: [RFC V2] arm:consider THUMB and BE endian kernel build
In-Reply-To: <5559966A.5010006@gmail.com>
References: <5559527F.9090300@gmail.com>
 <5559966A.5010006@gmail.com>
Message-ID: <20150518094032.GR2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 03:36:10PM +0800, yalin wang wrote:
> this patch fix the function in kernel_thread(),
> when kernel is build as THUMB2 or BE8 endian, we should
> also set the correct bit in CPSR, so that kernel can return to
> the correct state to execute.

Why do you think any of this is needed?

When a kernel thread is created via kernel_thread(), copy_thread() is
called with the function pointer in stack_start, and the functions
argument in stk_size.

When the scheduler switches to the thread, it reads the register state
from thread->cpu_context, thereby loading r4 and r5 with the function
argument and function pointer, and directing the PC to ret_from_fork.
(For normal user clones and forks, r4 and r5 in kernel space will be
zero.)

The scheduler switch preserves the CPSR from the previous task, so if
we're running a T2 BE8 kernel, the new thread will have its ret_from_fork
called in T2 BE8 mode.

ret_from_fork checks for a non-zero r5, and if so, calls that function,
which will also see the CPSR set appropriately for the kernel mode.

Functions called from kernel_thread() are not permitted to return, so
we will never read the "childregs" off the top of the kernel stack.
Childregs are initialised because we expect them to be at the top of
every kernel stack.

Ergo, this patch is not needed at all.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
