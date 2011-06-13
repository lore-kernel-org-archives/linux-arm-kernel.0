From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 13 Jun 2011 15:16:08 -0400 (EDT)
Subject: [PATCH 00/14] Re-jig cpu_suspend for a saner calling convention
In-Reply-To: <20110613171446.GF13643@n2100.arm.linux.org.uk>
References: <20110613171446.GF13643@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1106131513210.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:

> Currently cpu_suspend is not like a normal C function - when it's called
> it returns normally to a bunch of code which is not expected to return.
> The return path is via code pointed to by 'r3'.
> 
> It also corrupts a bunch of registers in ways which make it non-compliant
> with a C API.
> 
> If we do make this complaint as a normal C-like function, it eliminates
> this register saving.  We also swap 'lr' and 'r3', so cpu_suspend
> effectively only returns to following code on resume - and r3 points
> to the suspend code.
> 
> So, this becomes:
>         ENTRY(acmeSoC_cpu_suspend)
>                 stmfd   sp!, {lr}
>                 adr     r3, soc_finish_suspend
>                 bl      cpu_suspend
>                 ldmfd   sp!, {pc}
>         ENDPROC(acmeSoC_cpu_suspend)
> 
>         soc_finish_suspend:
>                 blah
>                 blah
>                 put soc to sleep
>                 never return
> 
> or even:
> 
> static void soc_suspend(void)
> {
>         [soc specific preparation]
> 
>         cpu_suspend(0, PLAT_PHYS_OFFSET - PAGE_OFFSET,

Please let's try not to use PLAT_PHYS_OFFSET if it can be avoided, 
especially when the plain PHYS_OFFSET would do just as well.  I'm 
currently trying to get rid of all instances of PLAT_PHYS_OFFSET from 
the kernel in order to eventually support multiple SOCs in a single 
kernel image.


Nicolas
