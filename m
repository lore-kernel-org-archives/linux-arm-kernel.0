From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Apr 2017 00:24:16 +0100
Subject: ARM lockup during Kexec operation
In-Reply-To: <f094f2a481994c31bff01ef7579f1d3c@LPHQEX2013.litepoint.internal>
References: <f094f2a481994c31bff01ef7579f1d3c@LPHQEX2013.litepoint.internal>
Message-ID: <20170421232416.GN17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 11:04:19PM +0000, Rudici Cazeao wrote:
> The issue is localized to  linux-3.0.51/arch\arm/mach-transcede/hotplug.c.
> 
>                 cpu_enter_lowpower();
>             platform_do_lowpower(cpu, &spurious);
>                 cpu_leave_lowpower().                                      / *  bring this CPU back into the world of cache  coherency, and then restore interrupts  */
> 
> 
> static inline void platform_do_lowpower(unsigned int cpu, int *spurious) {
>                 for (;;) {                                                                    / * there is no power-control hardware on this platform, so all we can do is put the core into WFI; this is safe as the calling code will have already disabled interrupts */
>                         wfe();
>                                 if (pen_release == cpu) {
>                                                 break;                                          / * OK, proper wakeup, we're done */
>                                 }
> 
>                                 (*spurious)++;                                         / * Getting here, means that we have come out of WFI without having been woken up - Just note it happening - when we're woken, we can report its occurrence.
>                 }
> }

Sorry, but with the above, the platform can't support suspend/resume or
kexec reliably.  It needs a proper implementation - iow, one which
actually takes the CPU offline such that it resumes as it does the very
first time we boot.

This also doesn't seem to be mainline kernel related - and searching
google for "arm/mach-transcede" brings up no relevant results,
certainly not on the first page.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
