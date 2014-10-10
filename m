From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Oct 2014 11:01:46 +0100
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <1879331.AWtSrdvUyc@wuerfel>
References: <54345FA7.9030606@gmail.com> <54370A1E.6070707@gmail.com>
 <20141009223244.GJ5182@n2100.arm.linux.org.uk> <1879331.AWtSrdvUyc@wuerfel>
Message-ID: <20141010100146.GM5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 11:45:34AM +0200, Arnd Bergmann wrote:
> On Thursday 09 October 2014 23:32:44 Russell King - ARM Linux wrote:
> > > there is a new piece of information:
> > > the FP corruption seems to only happen in these android devices if the  
> > > display is off. the charger may be connected or not, but if the display  
> > > is on, the corruption won't happen.
> > >
> > > i wonder if the kernel could be turning off the FPU and then back on  
> > > without saving the FPU state. i would think corruption would be seen  
> > > more often then.
> > 
> > No.  We don't "turn off" the VFP.  We disable and enable access to VFP
> > via the coprocessor access register.  If the VFP access is disabled and
> > then re-enabled, all state is preserved.
> > 
> > The only time which state would be lost is if (eg) we hot-unplug the
> > entire CPU, but that first requires a context switch which implies that
> > the state will already be saved.
> 
> Could the problem be caused by a bug in the exynos CPU suspend/resume
> path then? E.g. if we go to sleep with VFP access disabled but it
> comes back with VFP access enabled (or vice versa) that could lead
> to the wrong register state being seen by the user space application.

Well, an interesting test would be to save out the entire VFP state
both before and after the pread64 call, and then inspect that to
determine whether it is a single register or multiple registers
which are being corrupted.

However, looking at the mainline code, we do the right thing with the
CPU PM infrastructure, and that is called appropriately by the exynos
CPU idle driver.

So, another possible test for Lanchon would be to see whether disabling
CPU idle support fixes the problem.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
