From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Jul 2014 12:26:41 -0600
Subject: [PATCH 6/6] thermal: Add Tegra SOCTHERM thermal management driver
In-Reply-To: <53B26BF2.7090009@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-7-git-send-email-mperttunen@nvidia.com>
 <53B1D538.6000704@wwwdotorg.org> <53B26BF2.7090009@nvidia.com>
Message-ID: <53B2FD61.9000101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 02:06 AM, Mikko Perttunen wrote:
> Inline.
> 
> On 01/07/14 00:23, Stephen Warren wrote:
>> On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
>>> This adds support for the Tegra SOCTHERM thermal sensing and management
>>> system found in the Tegra124 system-on-chip. This initial driver
>>> supports
>>> the four thermal zones with hardware-tracked trip points.
>>
>>> diff --git a/drivers/thermal/tegra_soctherm.c
>>> b/drivers/thermal/tegra_soctherm.c
>>
>>> +static struct tegra_tsensor t124_tsensors[] = {
>>> +    {
>>> +        .base = 0xc0,
>>> +        .name = "cpu0",
>>> +        .config = &t124_tsensor_config,
>>> +        .calib_fuse_offset = 0x098,
>>> +        .fuse_corr_alpha = 1135400,
>>> +        .fuse_corr_beta = -6266900,
>>> +    },
>>
>> I wonder why some of those fields are named "fuse_xxx" when the values
>> are hard-coded in these tables rather than read from fuses? These values
>> don't seem to be used to adjust values read from fuses.
> 
> They are used to when calculating the thermal calibration in
> calculate_tsensor_calibration, which is based on the value read from the
> fuse. Downstream calls them fuse correction values, so I kept that. (I
> guess the meaning of corr might not be obvious..) On downstream there is
> another set of these correction values used depending on the fuse
> revision, but I believe the older revision is only found internally.

Ah, so there's some manufacturing calibration process that sets some
fuse value, and the HW uses a combination of that fuse value, and some
parameters of the manufacturing process as represented by the
SENSOR_CONFIG2 register, to apply the calibration? I wonder why
SENSOR_CONFIG2 is a register not a fuse in that case, but anyway...

Perhaps some comments or kerneldoc in the definition of struct
tegra_tsensor would be useful?

I did notice some inconsistency in bracketing at:

> +	*calib = ((u16)(therma) << SENSOR_CONFIG2_THERMA_SHIFT) |
> +		 ((u16)thermb << SENSOR_CONFIG2_THERMB_SHIFT);

>>> +        err = devm_request_threaded_irq(&pdev->dev, irq, soctherm_isr,
>>> +                        soctherm_isr_thread,
>>> +                        IRQF_SHARED, "tegra_soctherm",
>>> +                        zone);
>>
>> Why request the same IRQ 4 times here. Rather, shouldn't the IRQ be
>> requested once, and the ISR simply loop over the status register (or
>> whatever there are 4 of)?
> 
> I had that variant as well, but since we need to pass the list of
> tripped sensors to soctherm_isr_thread somehow, I guess some kind of
> locking or atomic is needed. This version doesn't need that, so I went
> with it.

Why not read THERMCTL_INTR_STATUS inside the IRQ thread. IIRC, if the
ISR wakes an IRQ thread, the interrupt remains disable until the thread
has run its course, so there's no issue deferring the register read
until the thread runs, at which point, the thread can simply loop over
all the sensors.
