From: rmartinez@teltronic.es (=?iso-8859-1?Q?Ricardo_Mart=EDnez?=)
Date: Fri, 13 Nov 2009 17:31:44 +0100
Subject: ARM926 Software reset problems
In-Reply-To: <200911131559.51887.dk-arm-linux@gmx.de>
References: <B3925569A02247AFA3847BB80F9342EF@teltronic.es>
	<20091113122045.GA29008@n2100.arm.linux.org.uk>
	<8EBD063210E546E0BD6C80E8EF3AAD6B@teltronic.es>
	<200911131559.51887.dk-arm-linux@gmx.de>
Message-ID: <B4B24B30208E45CE8347F29D228A3C82@teltronic.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
Thanks very much

Russell: now it works, thank you very much. But ... it is still under test
because it sometimes hangs. For example, if I "flashcp" and overwrite
"uImage" and then reboot, it usually hangs. And upgrading kernel image is
something needed (not really often, of course) by my application.

Dieter: CPU is application specific, from a small vendor. Now, reset is
asserted by an external component, an FPGA. CPU writes a command throug SPI
in this FPGA and FPGA asserts RESET line. We want to get rid of any external
components for reset.

Thanks
Ricardo Martinez


-----Mensaje original-----
De: Dieter Kiermaier [mailto:dk-arm-linux at gmx.de] 
Enviado el: viernes, 13 de noviembre de 2009 16:00
Para: linux-arm-kernel at lists.infradead.org
CC: Ricardo Mart?nez
Asunto: Re: ARM926 Software reset problems

Am Freitag 13 November 2009 15:41:17 schrieb Ricardo Mart?nez:
> 
> Hi Russell,
> 
> Thanks for your help.
> 
> I'm one step further. kernel_restart() uses arch_reset() which is 
> hardware dependent.
> 
> Most ARM9 make arch_reset() through Watchdog peripheral. But the CPU 
> I'm using does not have Watchdog timer.
> 
> I was trying to find an alternative, based only on software, but It 
> may be not posible.
> 

Maybe there is another way. Please read the hardware manual careful.
I now it from my last CPU (netsilicon ARM 926) that you have to write e.g.
the CPU PLL register to fire a hardware reset.
What CPU are you using?

Dieter

> For example, in u-boot command line I can do reset just jumping back 
> to start of u-boot code. This is more or less what "cpu_arm926_reset" 
> does, but most times system hangs.
> 
> Thanks,
> Ricardo Martinez
> 
> 
> -----Mensaje original-----
> De: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] Enviado 
> el: viernes, 13 de noviembre de 2009 13:21
> Para: Ricardo Mart?nez
> CC: linux-arm-kernel at lists.infradead.org
> Asunto: Re: ARM926 Software reset problems
> 
> On Fri, Nov 13, 2009 at 12:32:16PM +0100, Ricardo Mart?nez wrote:
> > I'm using 
> >     cpu_arm926_reset(ulong address) function which:
> >            - flushes I/D caches
> >             - jumps to "address", whose value in my case is NOR 
> > flash base address where U-Boot stays (after remapping).
> 
> You should not be using this directly.  Software rebooting has a 
> specific sequence, and the above is the very last step.
> 
> >     But it sometimes work, but most times hangs. Can this be caused 
> > by MMU not being switched off?
> 
> cpu_arm926_reset() turns the MMU and caches off.
> 
> > Is there any other prefered method to soft reboot ARM926 from Linux? 
> > I've taken a look at some PXA, OMAP & AT91 code about soft rebooting. 
> > It seems they use Watchdog timer to reset, but my CPU does not have 
> > a
> watchdog.
> 
> Don't call cpu_arm926_reset() directly.  Use kernel_restart() instead, 
> or even better the reboot syscall from userspace.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
