From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 31 Jan 2014 16:59:41 +0100
Subject: Why are imprecise external aborts masked on recent kernel while
 booting ?
Message-ID: <52EBC86D.1010509@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm working on a PCIe driver that uses an "imprecise external abort" 
handler to detect when a port is behind a switch.
This mechanism is used when enumerating PCIe bus upon kernel boot.

In prior kernel (3.4), I noticed it's possible to use an abort handler 
registered by using hook_fault_code(16+6, ...);
These aborts are detected and the relevant handler is called as long as 
it is registered, when probing the bus.

In more recent kernel (3.10), abort handler is no longer triggered 
during kernel boot. At PCIe bus enumeration, imprecise aborts are not 
enabled. It seems unmasked later when starting userland init process 
(e.g. when CPSR.A bit on arm is cleared). Aborts are deferred until then.

I found another thread that looks like similar :
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/208641.html

I looked for where imprecise aborts were enabled on 3.4. I found out 
that it was enabled when the first schedule() happens. More precisely in 
kernel_thread_helper() when doing: "msr	cpsr_c, r7".
There has been changes beetween 3.6 or 3.7, like in commit 
9e14f828ee4a7a4a98703e380d180717a579fb35 (and others) that i believe 
changes the behavior of unmasking CPSR.A bit. kernel_thread_helper has 
been removed in that patch.

Is it a desired change in recent kernels ?

Is it possible to unmask imprecise data aborts earlier in the boot 
process (e.g. before PCIe bus enumeration, when drivers are being probed) ?


Best regards,
Fabrice
