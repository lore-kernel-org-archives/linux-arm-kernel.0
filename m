From: cphealy@gmail.com (Chris Healy)
Date: Sun, 19 Mar 2017 13:03:42 -0700
Subject: [PATCH] drm/etnaviv: add etnaviv cooling device
In-Reply-To: <20170315140541.GT21222@n2100.armlinux.org.uk>
References: <E1cn8jj-0002mp-SO@rmk-PC.armlinux.org.uk>
 <1489582989.16018.4.camel@pengutronix.de>
 <20170315140541.GT21222@n2100.armlinux.org.uk>
Message-ID: <CAFXsbZoT22pz2CuRWaQ2M2TyomNcByHc-SfmNn6=KrfNaubnjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't have any input on this binary divider subject but I do want to
bring up some observations regarding Etnaviv GPU power management that
seems relevant.

I've done some comparisons between the Freescale Vivante GPU driver
stack (1) and the Marvell PXA1928 Vivante GPU driver stack (2) and see
more functionality in the PXA1928 stack than the Freescale i.MX6 stack
that may be of value for Etnaviv.  When I look at the Marvell PXA1928
Vivante GPU driver stack, (2) I see "gpufreq" code (3) that includes
support for conservative, ondemand, performance, powersave, and
userspace governors.  Additionally, AFAIK the key feature needed to
support a gpufreq driver and associated governors is to be able to
know what the load is on the GPU.  When looking at the PXA1928 driver,
it seems that it is looking at some load counters within the GPU that
are likely to be common across platforms.  (Check
"gpufreq_get_gpu_load" (4) in gpufreq.c.)

Also, given the wealth of counters present in the 3DGPU and my
understanding that there are 3 different controllable GPU frequencies
(at least with the i.MX6), it seems that one could dynamically adjust
each of these 3 different controllable frequencies independently based
on associated load counters.  The i.MX6 has 3 different frequencies,
IIRC, AXI, 3DGPU core, and 3DGPU shader.  I believe there are counters
associated with each of these GPU sub-blocks so it seems feasible to
adjust each of the 3 buses based on the sub-block load.  (I'm no
expert by any means with any of this so this may be crazy talk...)

If my observations are correct that the gpufreq functionality present
in the PXA1928 driver is portable across SoC platforms with the
Vivante 3D GPUs, does it make sense to add a gpufreq driver with the
Etnaviv driver?

What are the benefits and drawbacks of implementing a gpufreq driver
with associated governors in comparison to adding this cooling device
driver functionality?  (It seems to me that a gpufreq driver is more
proactive and the cooling device is more reactive.)

Can and should gpufreq driver functionality (such as that present in
the PXA1928 driver) and the proposed cooling device functionality
co-exist?

(1) - https://github.com/etnaviv/vivante_kernel_drivers/tree/master/imx6_v4_0_0
(2) - https://github.com/etnaviv/vivante_kernel_drivers/tree/master/pxa1928
(3) - https://github.com/etnaviv/vivante_kernel_drivers/tree/master/pxa1928/hal/os/linux/kernel/gpufreq
(4) - https://github.com/etnaviv/vivante_kernel_drivers/blob/master/pxa1928/hal/os/linux/kernel/gpufreq/gpufreq.c#L1294

On Wed, Mar 15, 2017 at 7:05 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Mar 15, 2017 at 02:03:09PM +0100, Lucas Stach wrote:
>> Am Sonntag, den 12.03.2017, 19:00 +0000 schrieb Russell King:
>> > Each Vivante GPU contains a clock divider which can divide the GPU clock
>> > by 2^n, which can lower the power dissipation from the GPU.  It has been
>> > suggested that the GC600 on Dove is responsible for 20-30% of the power
>> > dissipation from the SoC, so lowering the GPU clock rate provides a way
>> > to throttle the power dissiptation, and reduce the temperature when the
>> > SoC gets hot.
>> >
>> > This patch hooks the Etnaviv driver into the kernel's thermal management
>> > to allow the GPUs to be throttled when necessary, allowing a reduction in
>> > GPU clock rate from /1 to /64 in power of 2 steps.
>>
>> Are those power of 2 steps a hardware limitation, or is it something you
>> implemented this way to get a smaller number of steps, with a more
>> meaningful difference in clock speed?
>> My understanding was that the FSCALE value is just a regular divider
>> with all steps values in the range of 1-64 being usable.
>
> I don't share your understanding.  The Vivante GAL kernel driver only
> ever sets power-of-two values.  I have no evidence to support your
> suggestion.
>
> There's evidence that says your understanding is incorrect however.
> It isn't a divider.  A value of 0x40 gives the fastest clock rate,
> a value of 0x01 gives the slowest.  If it were a binary divider,
> a value of 0x7f would give the slowest rate - so why doesn't Vivante
> use that in galcore when putting the GPU into idle/lower power - why
> do they just 0x01.
>
> This all leads me to believe that it's not a binary divider, but a
> set of bits that select the clock from a set of divide-by-two stages,
> and having more than one bit set is invalid.
>
> However, without definitive information from Vivante, we'll never
> really know.  We're unlikely to get that.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> _______________________________________________
> etnaviv mailing list
> etnaviv at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/etnaviv
