From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Nov 2012 07:30:44 -0800
Subject: [PATCH V2] ARM: PMU: fix runtime PM enable
In-Reply-To: <20121026100312.GF20914@mudshark.cambridge.arm.com>
References: <1351196598-26667-1-git-send-email-jon-hunter@ti.com>
 <20121026100312.GF20914@mudshark.cambridge.arm.com>
Message-ID: <20121105153044.GE4953@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Will Deacon <will.deacon@arm.com> [121026 03:04]:
> On Thu, Oct 25, 2012 at 09:23:18PM +0100, Jon Hunter wrote:
> > Commit 7be2958 (ARM: PMU: Add runtime PM Support) updated the ARM PMU code to
> > use runtime PM which was prototyped and validated on the OMAP devices. In this
> > commit, there is no call pm_runtime_enable() and for OMAP devices
> > pm_runtime_enable() is currently being called from the OMAP PMU code when the
> > PMU device is created. However, there are two problems with this:
> > 
> > 1. For any other ARM device wishing to use runtime PM for PMU they will need
> >    to call pm_runtime_enable() for runtime PM to work.
> > 2. When booting with device-tree and using device-tree to create the PMU
> >    device, pm_runtime_enable() needs to be called from within the ARM PERF
> >    driver as we are no longer calling any device specific code to create the
> >    device. Hence, PMU does not work on OMAP devices that use the runtime PM
> >    callbacks when using device-tree to create the PMU device.
> > 
> > Therefore,  call pm_runtime_enable() directly from the ARM PMU driver when
> > registering the device. For platforms that do not use runtime PM,
> > pm_runtime_enable() does nothing and for platforms that do use runtime PM but
> > may not require it specifically for PMU, this will just add a little overhead
> > when initialising and uninitialising the PMU device.
> > 
> > Tested with PERF on OMAP2420, OMAP3430 and OMAP4460.
> > 
> > V2 changes:
> > - Call pm_runtime_enable() unconditionally on registering the PMU device.
> > 
> > Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> > ---
> 
> Cheers Jon! Looks a bit weird without the matching pm_runtime_disable, but
> we don't really have anywhere to put that since the PMU is not deregistered.
> 
> Can we split this patch into two (even smaller!) patches so that I can take
> the perf part and the omap bit can go to Tony?

The omap bit looks OK for me to queue via perf:

Acked-by: Tony Lindgren <tony@atomide.com>
