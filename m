From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Aug 2012 09:06:48 +0100
Subject: imx6q restart is broken
In-Reply-To: <20120809044131.GF14718@S2101-09.ap.freescale.net>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809044131.GF14718@S2101-09.ap.freescale.net>
Message-ID: <20120809080648.GB14102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 05:41:38AM +0100, Shawn Guo wrote:
> On Thu, Aug 09, 2012 at 11:18:47AM +0800, Hui Wang wrote:
> > Dirk Behme wrote:
> > >On 08.08.2012 12:18, Shawn Guo wrote:
> > >>Thanks Dirk for reporting that imx6q restart (reboot command) is broken.
> > >>
> > >>I tracked down the issue a little bit and found imx6q_restart hangs
> > >>on the of_iomap/ioremap call. The following change, moving the call
> > >>somewhere else than imx6q_restart, will just fix the problem.
> > >>
> > >>Does that mean ioremap call is not allowed in platform restart hook?
> > >>I'm not sure about that, because I found it works just fine if I build
> > >>imx_v6_v7_defconfig with V6 (imx3) platforms excluded (IOW, build a V7
> > >>only kernel - imx5 and imx6), which is the case how I tested imx6q
> > >>restart feature when I was adding it.
> > >>
> > >>To summarize, the imx6q_restart hangs at ioremap call on a V6 + V7
> > >>kernel, while it works fine on a V7 only image. I need some help to
> > >>understand that.
> > >
> > >Some additional information from my debugging:
> > >
> > >a) Having a JTAG debugger attached to the i.MX6 SabreLite board I
> > >use (kernel built with imx_v6_v7_defconfig) the reboot does work.
> > >No hang. This does mean I can't debug the reboot hang with a JTAG
> > >debugger. Therefore I added some printk debugging:
> > >
> > >b) Adding some printk statements [1] in the of_iomap/ioremap call,
> > >it looks to me that the system hangs in
> > >
> > >of_iomap() -> ... -> set_pte_at() -> set_pte_ext() /
> > >cpu_v7_set_pte_ext() <= hang
> > >
> > I noticed this problem several weeks ago, and did some debug, what i
> > found is following:
> > 
> Thanks for these great findings.  I also just tracked it down to that
> cpu_v7_set_pte_ext hangs on
> 
> 	mcr   p15, 0, r0, c7, c10, 1          @ flush_pte
> 
> > - at the last stage of reset, all non-boot cpus will call
> > ipi_cpu_stop()->cpu_relax(), the cpu_relax() is defined to smp_mb()
> > for V6, and smp_mb() is defined to dmb ("mcr p15, 0, %0, c7, c10,
> > 5")
> > 
> > - the boot cpu will call cpu_v7_set_pte_ext() in the
> > proc-v7-2level.S, at the end of this function, boot cpu will call
> > flush_pte (mcr p15, 0, r0, c7, c10, 1), after executing this
> > function, the system will hang. That is to say, all non-boot cpus
> > repeatedly call ("mcr p15, 0, %0, c7, c10, 5"), if boot cpu call
> > flush_pte (mcr p15, 0, r0, c7, c10, 1), the system will hang, this
> > occurs on the cortexa9 r2p10 cpus (freescale i.MX6Q), i don't know
> > the root cause for this problem, but if we split imx_v6_v7_defconfig
> > into v7_only and use v7_only to build kernel image for imx6q, this
> > problem will disappear, since the cpu_relax() will be defined to
> > barrier().

Does this work if you always define cpu_relax() to smp_mb() (even on
ARMv7) and compile the kernel to v7-only? In this case, the smp_mb()
would use the DMB instruction rather than the CP15 equivalent. It's not
a solution, just trying to understand the problem better.

Thanks.

-- 
Catalin
