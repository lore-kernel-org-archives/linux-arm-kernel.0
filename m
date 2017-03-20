From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 20 Mar 2017 10:19:35 +0100
Subject: [PATCH] drm/etnaviv: add etnaviv cooling device
In-Reply-To: <CAFXsbZoT22pz2CuRWaQ2M2TyomNcByHc-SfmNn6=KrfNaubnjQ@mail.gmail.com>
References: <E1cn8jj-0002mp-SO@rmk-PC.armlinux.org.uk>
 <1489582989.16018.4.camel@pengutronix.de>
 <20170315140541.GT21222@n2100.armlinux.org.uk>
 <CAFXsbZoT22pz2CuRWaQ2M2TyomNcByHc-SfmNn6=KrfNaubnjQ@mail.gmail.com>
Message-ID: <1490001575.2895.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 19.03.2017, 13:03 -0700 schrieb Chris Healy:
> I don't have any input on this binary divider subject but I do want to
> bring up some observations regarding Etnaviv GPU power management that
> seems relevant.
> 
> I've done some comparisons between the Freescale Vivante GPU driver
> stack (1) and the Marvell PXA1928 Vivante GPU driver stack (2) and see
> more functionality in the PXA1928 stack than the Freescale i.MX6 stack
> that may be of value for Etnaviv.  When I look at the Marvell PXA1928
> Vivante GPU driver stack, (2) I see "gpufreq" code (3) that includes
> support for conservative, ondemand, performance, powersave, and
> userspace governors.  Additionally, AFAIK the key feature needed to
> support a gpufreq driver and associated governors is to be able to
> know what the load is on the GPU.  When looking at the PXA1928 driver,
> it seems that it is looking at some load counters within the GPU that
> are likely to be common across platforms.  (Check
> "gpufreq_get_gpu_load" (4) in gpufreq.c.)
> 
> Also, given the wealth of counters present in the 3DGPU and my
> understanding that there are 3 different controllable GPU frequencies
> (at least with the i.MX6), it seems that one could dynamically adjust
> each of these 3 different controllable frequencies independently based
> on associated load counters.  The i.MX6 has 3 different frequencies,
> IIRC, AXI, 3DGPU core, and 3DGPU shader.  I believe there are counters
> associated with each of these GPU sub-blocks so it seems feasible to
> adjust each of the 3 buses based on the sub-block load.  (I'm no
> expert by any means with any of this so this may be crazy talk...)
> 
> If my observations are correct that the gpufreq functionality present
> in the PXA1928 driver is portable across SoC platforms with the
> Vivante 3D GPUs, does it make sense to add a gpufreq driver with the
> Etnaviv driver?
> 
> What are the benefits and drawbacks of implementing a gpufreq driver
> with associated governors in comparison to adding this cooling device
> driver functionality?  (It seems to me that a gpufreq driver is more
> proactive and the cooling device is more reactive.)
> 
> Can and should gpufreq driver functionality (such as that present in
> the PXA1928 driver) and the proposed cooling device functionality
> co-exist?

Yes, probably we want to have both at some point. The cooling-device
stuff is about throttling the GPU when the SoC reaches critical
temperatures.

The devfreq governors are about providing exactly the right performance
point.
Though as I have not yet seen any SoCs where the voltage would be scaled
with GPU frequency, downclocking the GPU is of limited value. For most
of those SoCs a race-to-idle policy is probably okay, as this allows
other components of the system like the DRAM to go into lower power
operating modes when the GPU is idle.

Regards,
Lucas
