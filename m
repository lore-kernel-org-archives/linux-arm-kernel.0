From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Jun 2011 11:06:10 +0100
Subject: [PATCH 25/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
In-Reply-To: <E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
Message-ID: <20110623100610.GD9449@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 04:16:58PM +0100, Russell King - ARM Linux wrote:
> +	/* Now branch to the common CPU resume function */
> +	ldr	r0, =cpu_resume
> +	bx	r0
>  
> +	.ltorg

A slight correction - firstly this code does not run from SRAM.
Secondly, this will try to branch to the virtual address of cpu_resume
which is not a good idea.

Replace this with:
	b	cpu_resume

and comment out the auxillary control register write in proc-v7.S, and
it should work on OMAP3.
