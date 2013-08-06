From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 6 Aug 2013 17:19:33 +0800
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <51FFDA20.6050403@wwwdotorg.org>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-4-git-send-email-josephl@nvidia.com>
 <51F6F209.2090309@wwwdotorg.org>
 <1375430985.6761.51.camel@jlo-ubuntu-64.nvidia.com>
 <51FC1751.9010401@wwwdotorg.org>
 <1375689749.1731.36.camel@jlo-ubuntu-64.nvidia.com>
 <51FFDA20.6050403@wwwdotorg.org>
Message-ID: <1375780773.2261.72.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-06 at 01:00 +0800, Stephen Warren wrote:
> On 08/05/2013 02:02 AM, Joseph Lo wrote:
> > On Sat, 2013-08-03 at 04:32 +0800, Stephen Warren wrote:
> >> On 08/02/2013 02:09 AM, Joseph Lo wrote:
> >>> On Tue, 2013-07-30 at 06:51 +0800, Stephen Warren wrote:
> >>>> On 07/26/2013 03:15 AM, Joseph Lo wrote:
> >>>>> When the system suspends to LP1, the clock of the CPU would be switched to
> >>>>> CLK_M (12MHz Oscillator) during suspend/resume flow. The clock driver
> >>>>> needs to restore the clock of CPU after LP1 resume.
> >>>>
[snip]
> >>>> Why don't Tegra20/30 need a similar change?
> >>>
> >>> For Tegra20/30, the same code had been implemented in the suspend/resume
> >>> function of tegra_cpu_car_ops. It restores the CPU clock ASAP when CPU
> >>> resume from a suspend state to get quick performance I believe.
> >>>
> >>> For Tegra114, the resume performance is cool (although we can't see it
> >>> in upstream kernel now, it still need some other functions.). We can
> >>> implement all the clock related suspend/resume function in the clock
> >>> driver.
> >>
> >> OK, I do see something similar in tegra20/30_cpu_clock_suspend/resume.
> >> Why can't this new code be part of the equivalent functions; does the
> >> Tegra114 suspend/resume code in mach-tegra/ not call
> >> tegra_cpu_car_ops.suspend/resume() in the same way it does on Tegra20/30?
> >
> > One of the main reasons is due to DFLL clock. The CPU clock of Tegra114
> > is going to switch to DFLL to a get higher clock rate. But it depends
> > some other HW (i.e. I2C), we can't resume it so early when the CPU just
> > resume like we did in tegra_cpu_car_ops.suspend/resume for Tegra20/30.
> 
> Is there a guarantee that the syscore_ops are run after the call to
> tegar_cpu_car_ops.resume() would be? Perhaps the mach-tegra/ code should
> simply call tegra_cpu_car_ops.resume() later on Tegra114 than it does on
> earlier chips, so it's run at a suitable time?

Yes, the tegra_cpu_car_ops.suspend/resume() is hooked to
suspend_cpu_complex()/resuem_cpu_complex() that in the "pm.c" file. It
would be the final/first function be invoked when system suspend/resume.
