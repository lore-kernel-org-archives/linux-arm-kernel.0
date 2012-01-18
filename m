From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 15:07:24 +0000
Subject: [PATCH] ARM: kexec: EOI active and mask all interrupts in
 kexec crash path
In-Reply-To: <1326898885-28105-1-git-send-email-will.deacon@arm.com>
References: <1326898885-28105-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120118150724.GH1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 03:01:25PM +0000, Will Deacon wrote:
> The kexec machine crash code can be called in interrupt context via a
> sysrq trigger made using the magic key combination. If the irq chip
> dealing with the serial interrupt is using the fasteoi flow handler,
> then we will never EOI the interrupt because the interrupt handler will
> be fatal. In the case of a GIC, this results in the crash kernel not
> receiving interrupts on that CPU interface.
> 
> This patch adds code (based on the PowerPC implementation) to EOI any
> pending interrupts on the crash CPU before masking and disabling all
> interrupts. Secondary cores are not a problem since they are placed into
> a cpu_relax() loop via an IPI.

So, what happens if we fault in an interrupt handler, we have
panic_on_oops set, and we have panic configured to automatically
reboot after a period?

I think we actually want this to happen at boot to make sure that the
CPU interfaces are properly initialized each time the kernel is brought
up.

> @@ -53,6 +54,28 @@ void machine_crash_nonpanic_core(void *unused)
>  		cpu_relax();
>  }
>  
> +static void machine_kexec_mask_interrupts(void) {

Coding style error.
