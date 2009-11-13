From: rmartinez@teltronic.es (=?iso-8859-1?Q?Ricardo_Mart=EDnez?=)
Date: Fri, 13 Nov 2009 15:41:17 +0100
Subject: ARM926 Software reset problems
In-Reply-To: <20091113122045.GA29008@n2100.arm.linux.org.uk>
References: <B3925569A02247AFA3847BB80F9342EF@teltronic.es>
	<20091113122045.GA29008@n2100.arm.linux.org.uk>
Message-ID: <8EBD063210E546E0BD6C80E8EF3AAD6B@teltronic.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Thanks for your help.

I'm one step further. kernel_restart() uses arch_reset() which is hardware
dependent.

Most ARM9 make arch_reset() through Watchdog peripheral. But the CPU I'm
using does not have Watchdog timer.

I was trying to find an alternative, based only on software, but It may be
not posible.

For example, in u-boot command line I can do reset just jumping back to
start of u-boot code. This is more or less what "cpu_arm926_reset" does, but
most times system hangs.

Thanks,
Ricardo Martinez


-----Mensaje original-----
De: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Enviado el: viernes, 13 de noviembre de 2009 13:21
Para: Ricardo Mart?nez
CC: linux-arm-kernel at lists.infradead.org
Asunto: Re: ARM926 Software reset problems

On Fri, Nov 13, 2009 at 12:32:16PM +0100, Ricardo Mart?nez wrote:
> I'm using 
>     cpu_arm926_reset(ulong address) function which:
>            - flushes I/D caches
>             - jumps to "address", whose value in my case is NOR flash 
> base address where U-Boot stays (after remapping).

You should not be using this directly.  Software rebooting has a specific
sequence, and the above is the very last step.

>     But it sometimes work, but most times hangs. Can this be caused by 
> MMU not being switched off?

cpu_arm926_reset() turns the MMU and caches off.

> Is there any other prefered method to soft reboot ARM926 from Linux? 
> I've taken a look at some PXA, OMAP & AT91 code about soft rebooting. 
> It seems they use Watchdog timer to reset, but my CPU does not have a
watchdog.

Don't call cpu_arm926_reset() directly.  Use kernel_restart() instead, or
even better the reboot syscall from userspace.
