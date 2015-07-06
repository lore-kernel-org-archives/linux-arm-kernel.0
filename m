From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 6 Jul 2015 23:04:45 +0200
Subject: weird behavior of get/set_fiq_regs()
In-Reply-To: <20150706160230.GG7557@n2100.arm.linux.org.uk>
References: <CAOpc7mHkynAfmZKJhbwF0q0rco+3t7=wzh9owf6Brz6fmPRHsw@mail.gmail.com>
 <20150706160230.GG7557@n2100.arm.linux.org.uk>
Message-ID: <CAOpc7mE5oJFzHXH2bOGRnEDfQ3Go-QpROSZ7KJeTsPxG0ibqZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We should probably make the FIQ code depend on !SMP, or at least complain
> if num_online_cpus > 1 and if we're in a schedulable context,  because the
> issue you're running into is precisely that.

Oh. Or at least make the set_fiq_reqs depends on #ifndef CONFIG_SMP.

The code in arch/arm/mach-imx/ssi-fiq.S should be SMP safe, because
they don't use set_fiq_regs(), but define places for the variables:

imx_ssi_fiq_start:
                ldr r12, .L_imx_ssi_fiq_base
...
.L_imx_ssi_fiq_base:
imx_ssi_fiq_base:
                .word 0x0

> Also note that you'll get into hot water if you try to have FIQ handlers
> in module code.

Why?  I was under the impression that the assembly code from my *.S
routine get's copied directly after the exception vectors. Why would
it matter if the bytes between myfiq_start and myfiq_end come from a
module or from somewhere else?
