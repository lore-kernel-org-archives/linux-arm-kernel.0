From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Oct 2014 23:15:15 +0100
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <54345FA7.9030606@gmail.com>
References: <54345FA7.9030606@gmail.com>
Message-ID: <20141007221515.GY5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 06:48:23PM -0300, Lanchon wrote:
> Simply busy-spinning in userland waiting for FP corruption does not seem  
> to trigger the issue. Concurrently accessing storage in another process  
> while spinning also does not work; power management (sleep, etc) may be  
> involved.

You need two processes accessing VFP to cause VFP state to be saved and
restored.

> We do not have 'kernel_neon_begin' nor 'kernel_vfp_begin' support in  
> these kernels; the code is just not there.

Which means that the kernel itself must /never/ make use of floating
point itself - if it does, it /will/ corrupt the user state in the way
you are seeing.  That's a pretty hard requirement, and something that
we have enforced with mainline kernels by building the kernel in
soft FP mode, thereby preventing the compiler emitting FP instructions.
Hence, the only way to get VFP instructions in the kernel is via
explicit assembly sequences.

The exception to this rule is the VFP support code itself, which
maintains the VFP state on behalf of the hardware and userspace (and
even then, that code is only concerned with reading and writing the
VFP registers, not using FP itself.)

In SMP environments, VFP state is saved each time we context switch
away from a thread.  If we resume the thread on the _same_ CPU and
no one else has used the VFP since, we just re-enable access to VFP.
Otherwise, we re-load the VFP state from the previously saved state.

In UP environments, we do something similar, but we don't save until
we need to.

However, neon shares the VFP registers, and we have some code (crypto
stuff) which uses neon, and this has appropriate guards to ensure that
userspace does not see any changes.  This is only available when
CONFIG_KERNEL_MODE_NEON is enabled (but as you say you don't have
kernel_neon_begin anywhere, you should /never/ execute any neon
instructions in the kernel.)

I hope this helps; I didn't answer your specific questions because it
seemed I would just end up repeating what I've said above.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
