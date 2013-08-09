From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 9 Aug 2013 17:23:10 +0800
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <5203F766.9050100@wwwdotorg.org>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-4-git-send-email-josephl@nvidia.com>
 <51F6F209.2090309@wwwdotorg.org>
 <1375430985.6761.51.camel@jlo-ubuntu-64.nvidia.com>
 <51FC1751.9010401@wwwdotorg.org>
 <1375689749.1731.36.camel@jlo-ubuntu-64.nvidia.com>
 <51FFDA20.6050403@wwwdotorg.org>  <51FFE363.4080603@wwwdotorg.org>
 <1375780249.2261.63.camel@jlo-ubuntu-64.nvidia.com>
 <52014258.9070602@wwwdotorg.org>
 <1375866749.8111.57.camel@jlo-ubuntu-64.nvidia.com>
 <520279FC.1000006@wwwdotorg.org>
 <1375928591.1758.66.camel@jlo-ubuntu-64.nvidia.com>
 <5203F766.9050100@wwwdotorg.org>
Message-ID: <1376040190.12024.10.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 03:54 +0800, Stephen Warren wrote:
> On 08/07/2013 08:23 PM, Joseph Lo wrote:
> > On Thu, 2013-08-08 at 00:46 +0800, Stephen Warren wrote:
> ..
> >> I still have absolutely no idea why Tegra30 and Tegra114 are different.
> >>
> >> You mentioned something about this low-level code only manipulating the
> >> IDLE state, and the clock driver needing to restore the other 4 states.
> >> This raises yet more questions:
> >>
> >> 1) Do we not need to restore the other 4 states on Tegra30? If not, why
> >> not? If we do, presumably Tegra30 (and Tegra20?) need to the syscore_op
> >> this patch series adds to Tegra114 only? If we don't, then why does
> >> Tegra114 have to restore them?
> >
> > We need to restore all of them for all Tegra chips. For Tegra20/30, we
> > had done it in the tegra_cpu_car_ops.suspend/resume. For Tegra114, the
> > patch was here.
> > 
> > The other reason is:
> > 1) The PLLX is the main CPU clock source in Tegra20/30. We can restore
> > it ASAP to get a better performance.
> > 2) For Tegra114, the PLLX is the CPU clock source when CPU runs at low
> > rates. When CPU in high rate, it uses DFLL as clock source. So it
> > depends on what the clock source of the CPU when it goes into suspend.
> > And the DFLL has its own resume code, it needs to be restored before the
> > CPU uses it as clock source again. It makes the CPU clock restore
> > sequence like this.
> 
> So, we don't yet support the DFLL upstream. Presumably, the CPU is
> always running off PLLX on Tegra114 upstream right now. As such, we can
> hard-code that into the resume path just like we do on earlier chips,
> i.e. using tegra_cpu_car_ops.resume().
> 
> Once we do get DFLL support, presumably the DFLL resume path can switch
> the register from PLLX to DFLL, and we still won't need a custom
> syscore_ops.
> 
> Will that work?
Hmm. If we can implement DFLL resume code there, that may be work. But I
can't confirm right now. I can move them to tegra_cpu_car_ops for now.
We can re-visit this later when we get more function to support.

Thanks,
Joseph
