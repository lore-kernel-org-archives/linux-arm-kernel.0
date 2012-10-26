From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Oct 2012 11:03:13 +0100
Subject: [PATCH V2] ARM: PMU: fix runtime PM enable
In-Reply-To: <1351196598-26667-1-git-send-email-jon-hunter@ti.com>
References: <1351196598-26667-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121026100312.GF20914@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 09:23:18PM +0100, Jon Hunter wrote:
> Commit 7be2958 (ARM: PMU: Add runtime PM Support) updated the ARM PMU code to
> use runtime PM which was prototyped and validated on the OMAP devices. In this
> commit, there is no call pm_runtime_enable() and for OMAP devices
> pm_runtime_enable() is currently being called from the OMAP PMU code when the
> PMU device is created. However, there are two problems with this:
> 
> 1. For any other ARM device wishing to use runtime PM for PMU they will need
>    to call pm_runtime_enable() for runtime PM to work.
> 2. When booting with device-tree and using device-tree to create the PMU
>    device, pm_runtime_enable() needs to be called from within the ARM PERF
>    driver as we are no longer calling any device specific code to create the
>    device. Hence, PMU does not work on OMAP devices that use the runtime PM
>    callbacks when using device-tree to create the PMU device.
> 
> Therefore,  call pm_runtime_enable() directly from the ARM PMU driver when
> registering the device. For platforms that do not use runtime PM,
> pm_runtime_enable() does nothing and for platforms that do use runtime PM but
> may not require it specifically for PMU, this will just add a little overhead
> when initialising and uninitialising the PMU device.
> 
> Tested with PERF on OMAP2420, OMAP3430 and OMAP4460.
> 
> V2 changes:
> - Call pm_runtime_enable() unconditionally on registering the PMU device.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---

Cheers Jon! Looks a bit weird without the matching pm_runtime_disable, but
we don't really have anywhere to put that since the PMU is not deregistered.

Can we split this patch into two (even smaller!) patches so that I can take
the perf part and the omap bit can go to Tony?

Will
