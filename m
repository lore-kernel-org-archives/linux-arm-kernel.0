From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Jul 2013 00:59:38 +0100
Subject: [RFC PATCH 4/5] arm64: add CPU_HOTPLUG infrastructure
In-Reply-To: <1373494549-24972-1-git-send-email-mark.rutland@arm.com>
References: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
 <1373494549-24972-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20130710235938.GA24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 11:15:49PM +0100, Mark Rutland wrote:
> +	/*
> +	 * actual CPU shutdown procedure is at least platform (if not
> +	 * CPU) specific.
> +	 */
> +	if (smp_ops[cpu]->cpu_die)
> +		smp_ops[cpu]->cpu_die(cpu);
> +
> +	/*
> +	 * Do not return to the idle loop - jump back to the secondary
> +	 * cpu initialisation.  There's some initialisation which needs
> +	 * to be repeated to undo the effects of taking the CPU offline.
> +	 */
> +	__asm__("mov	sp, %0\n"
> +	"	mov	x29, #0\n"
> +	"	b	secondary_start_kernel"
> +		:
> +		: "r" (task_stack_page(current) + THREAD_START_SP));

Don't make that same mistake as on AArch32 - this will result in some
people thinking its acceptable for them to return from cpu_die().  Hot
unplug is supposed to take the CPU offline so it can be restarted as if
it was never booted in the first place.

The above "hack" in AArch32 is only there because of the sillyness of
the 32-bit ARM evaluation boards not having a way to place the
secondary CPUs back into reset or power the secondary CPUs off.
