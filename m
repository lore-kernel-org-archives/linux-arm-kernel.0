From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Jan 2017 15:13:54 +0000
Subject: Unhandled level 2 translation fault (11) at 0x000000b8, esr
 0x92000046, rpi3 (aarch64)
In-Reply-To: <CAGDbNAAGqFqt7X+=XYRLAp=L_fTv9dAAe=wu4T_W-FCGqnYHHg@mail.gmail.com>
References: <CAGDbNAD7-TM6+x0A3FebTOPYmqQqbm1w29ZwH+9qePaAvhxTKw@mail.gmail.com>
 <20161230151323.583b7ac5@xhacker>
 <CAGDbNAAGqFqt7X+=XYRLAp=L_fTv9dAAe=wu4T_W-FCGqnYHHg@mail.gmail.com>
Message-ID: <20170109151354.GC7593@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 01:21:00PM +0100, Bas van Tiel wrote:
> >> when using a signal handler as a way to context switch between
> >> different usercontexts a reproducible exception occurs on my rpi3 in
> >> 64-bit mode. (https://gist.github.com/DanGe42/7148946)
> >>
> >> Running the context_demo program as a 32-bit ARM executable on a
> >> 64-bit kernel is OK, running as a 32 || 64 bit executable on an x86
> >> kernel is OK.
> >>
> >> In the first exception the PC doesn?t look correct, and the *pmd is 0.
> >> The 2nd exception happens after running the program again, the PC is 0x0.
> >>
> >> A successful function trace was not possible -> complete kernel hangup
> >> when enabling.
> >>
> >> Is there another way to gather more information about what is happening?
> >
> > I can reproduce Segmentation fault with your program on Marvell berlin SoCs
> > my kernel version is 4.1, I didn't tested 4.9, 4.10-rc1 etc..
> >
> > Then I increased the STACKSIZE from 4096 to 8192 in context_demo.c,
> > everything works fine now. Maybe arm64 need a bit larger signalstack?
> 
> yes, increased STACKSIZE to 8192 helps on 4.9/4,10-rc1 but after a
> while the exception still occurs, although the message is different.
> The *pmd is not 0 in this case.

I defined STACKSIZE to the kernel's SIGSTKSZ (16384) and it seems to run
fine, though I'll leave it longer/overnight (on a Juno board). With the
4K signal stack it was crashing shortly after start.

-- 
Catalin
