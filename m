From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Oct 2014 11:45:34 +0200
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <20141009223244.GJ5182@n2100.arm.linux.org.uk>
References: <54345FA7.9030606@gmail.com> <54370A1E.6070707@gmail.com>
 <20141009223244.GJ5182@n2100.arm.linux.org.uk>
Message-ID: <1879331.AWtSrdvUyc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 October 2014 23:32:44 Russell King - ARM Linux wrote:
> > there is a new piece of information:
> > the FP corruption seems to only happen in these android devices if the  
> > display is off. the charger may be connected or not, but if the display  
> > is on, the corruption won't happen.
> >
> > i wonder if the kernel could be turning off the FPU and then back on  
> > without saving the FPU state. i would think corruption would be seen  
> > more often then.
> 
> No.  We don't "turn off" the VFP.  We disable and enable access to VFP
> via the coprocessor access register.  If the VFP access is disabled and
> then re-enabled, all state is preserved.
> 
> The only time which state would be lost is if (eg) we hot-unplug the
> entire CPU, but that first requires a context switch which implies that
> the state will already be saved.

Could the problem be caused by a bug in the exynos CPU suspend/resume
path then? E.g. if we go to sleep with VFP access disabled but it
comes back with VFP access enabled (or vice versa) that could lead
to the wrong register state being seen by the user space application.

	Arnd
