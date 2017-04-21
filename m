From: rudici.cazeao@litepoint.com (Rudici Cazeao)
Date: Fri, 21 Apr 2017 23:04:19 +0000
Subject: ARM lockup during Kexec operation
Message-ID: <f094f2a481994c31bff01ef7579f1d3c@LPHQEX2013.litepoint.internal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using kexec on a dual-core arm processor (arm7), the non-boot CPU (CPU1) appears to be locking up during kexec.

The SoC is mach-transcede
The kernel version is 3.0.51-rt75

The issue is localized to  linux-3.0.51/arch\arm/mach-transcede/hotplug.c.


                cpu_enter_lowpower();
            platform_do_lowpower(cpu, &spurious);
                cpu_leave_lowpower().                                      / *  bring this CPU back into the world of cache  coherency, and then restore interrupts  */


static inline void platform_do_lowpower(unsigned int cpu, int *spurious) {
                for (;;) {                                                                    / * there is no power-control hardware on this platform, so all we can do is put the core into WFI; this is safe as the calling code will have already disabled interrupts */
                        wfe();
                                if (pen_release == cpu) {
                                                break;                                          / * OK, proper wakeup, we're done */
                                }

                                (*spurious)++;                                         / * Getting here, means that we have come out of WFI without having been woken up - Just note it happening - when we're woken, we can report its occurrence.
                }
}



When the issue occurs the non-boot CPU (ie CPU 1) is entering the platform_do_lowpower sequence where it should wait until pren_release is set to 1 by  CPU1 


Please note that  This failure is random. It usually happens somewhere between 300 and 5000 kexec loops.
