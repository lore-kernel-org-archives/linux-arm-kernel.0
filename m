From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Wed, 7 Sep 2011 17:00:03 +0530
Subject: [PATCH 2/5] ARM: SAMSUNG: Make the sleep code common for S3C64XX
	and newer SoCs
In-Reply-To: <20110907095513.GQ6619@n2100.arm.linux.org.uk>
References: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
	<1313144787-30666-3-git-send-email-a.kesavan@samsung.com>
	<20110907095513.GQ6619@n2100.arm.linux.org.uk>
Message-ID: <CAM4voak8Bp3AfRiSwvruBkfLr5djCpD-aU6d3AZKqa=FQJOyjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Sep 7, 2011 at 3:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Aug 12, 2011 at 03:56:24PM +0530, Abhilash Kesavan wrote:
>> +ENTRY(s3c_cpu_resume)
>> +#if defined(CONFIG_S3C_PM_DEBUG_LED_SMDK)
>> +
>> +#undef S3C64XX_VA_GPIO
>> +#define S3C64XX_VA_GPIO (0x0)
>> +#define S3C64XX_GPNCON ? ? ? ? ? ? ? ? ? ? ? (S3C64XX_GPN_BASE + 0x00)
>> +#define S3C64XX_GPNDAT ? ? ? ? ? ? ? ? ? ? ? (S3C64XX_GPN_BASE + 0x04)
>> +
>> +#define S3C64XX_GPN_CONMASK(__gpio) ?(0x3 << ((__gpio) * 2))
>> +#define S3C64XX_GPN_OUTPUT(__gpio) ? (0x1 << ((__gpio) * 2))
>> +
>> + ? ? /* Initialise the GPIO state if we are debugging via the SMDK LEDs,
>> + ? ? ?* as the uboot version supplied resets these to inputs during the
>> + ? ? ?* resume checks.
>> + ? ? */
>> +
>> + ? ? ldr ? ? r3, =S3C64XX_PA_GPIO
>> + ? ? ldr ? ? r0, [ r3, #S3C64XX_GPNCON ]
>> + ? ? bic ? ? r0, r0, #(S3C64XX_GPN_CONMASK(12) | S3C64XX_GPN_CONMASK(13) | \
>> + ? ? ? ? ? ? ? ? ? ? ? S3C64XX_GPN_CONMASK(14) | S3C64XX_GPN_CONMASK(15))
>> + ? ? orr ? ? r0, r0, #(S3C64XX_GPN_OUTPUT(12) | S3C64XX_GPN_OUTPUT(13) | \
>> + ? ? ? ? ? ? ? ? ? ? ? S3C64XX_GPN_OUTPUT(14) | S3C64XX_GPN_OUTPUT(15))
>> + ? ? str ? ? r0, [ r3, #S3C64XX_GPNCON ]
>> +
>> + ? ? ldr ? ? r0, [ r3, #S3C64XX_GPNDAT ]
>> + ? ? bic ? ? r0, r0, #0xf << 12 ? ? ? ? ? ? ? ? ? ? ?@ GPN12..15
>> + ? ? orr ? ? r0, r0, #1 << 15 ? ? ? ? ? ? ? ? ? ? ? ?@ GPN15
>> + ? ? str ? ? r0, [ r3, #S3C64XX_GPNDAT ]
>> +#endif
>
> This is incompatible with the aim of a single kernel booting on many ARM
> platforms.
>
> Rather than consolidating down to just one implementation, how about
> consolidating to two - one for everything but SMDK, and one for the SMDK
> with the LED stuff. ?You can then chose which you want - either the
> s3c_generic_resume (which is just the magic code plus the branch)
> or s3c_smdk_leds_resume (which would be the magic code plus the LEDS
> stuff plus the branch.)
I'll follow this suggestion for only S3C64XX and newer SoCs if that is
OK with Kukjin.
If however the consolidation is needed for all Samsung SoCs including the older
S3C24XX as well then this may not be workable.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
Regards,
Abhilash
