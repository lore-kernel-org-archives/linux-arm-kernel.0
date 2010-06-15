From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 15 Jun 2010 17:47:41 +0300
Subject: [PATCH 1/5] usb/otg/ulpi: extend the generic ulpi driver.
In-Reply-To: <AANLkTimHDBI0grgNrcvZ-BWS9kd0z4lFqEgVoyM4ysVJ@mail.gmail.com>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
	<AANLkTimHDBI0grgNrcvZ-BWS9kd0z4lFqEgVoyM4ysVJ@mail.gmail.com>
Message-ID: <4C17928D.6020402@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/12/10 12:35, Eric Miao wrote:
>> +/* ULPI Function Control Register bits */
>> +#define ULPI_FC_HS     0               /* Enable HS tcvr */
>> +#define ULPI_FC_FS     (0x1 << 0)      /* Enable FS tcvr */
>> +#define ULPI_FC_LS     (0x2 << 0)      /* Enable LS tcvr */
>> +#define ULPI_FC_FS_LS  (0x3 << 0)      /* Enable FS tcvr for LS packets */
>> +#define ULPI_FC_TRM_SEL        (0x1 << 2)      /* Internal pullup and HS termination */
>> +#define ULPI_FC_NODRV  (0x1 << 3)      /* Non-Driving Operation */
>> +#define ULPI_FC_NONRZI (0x1 << 4)      /* Disable bit-stuff and NRZI encode */
>> +#define ULPI_FC_RESET  (0x1 << 5)      /* Reset the UTMI core */
>> +#define ULPI_FC_DEFAULT        0x41            /* Function Control Register Default */
>> +
>> +
>> +/* ULPI Interface Register bits */
>> +#define ULPI_IC_6PIN   (1 << 0)        /* XCVR 6 serial pin mode */
>> +#define ULPI_IC_3PIN   (1 << 1)        /* XCVR 3 serial pin mode */
>> +#define ULPI_IC_CARKIT (1 << 2)        /* Carkit mode */
>> +#define ULPI_IC_CLKSPND        (1 << 3)        /* Active low clock suspend */
>> +#define ULPI_IC_AUTORES        (1 << 4)        /* PHY auto transmit resume signal */
>> +#define ULPI_IC_VBUSINV        (1 << 5)        /* Invert the external VBUS indicator */
>> +#define ULPI_IC_INDPT  (1 << 6)        /* Indicator Pass Through */
>> +#define ULPI_IC_DISPRT (1 << 7)        /* Interface Protect Disable */
>> +#define ULPI_IC_DEFAULT        0x0             /* Interface Control Register Default */
>> +
>>  struct otg_transceiver *otg_ulpi_create(struct otg_io_access_ops *ops,
>> -                                       unsigned int flags);
>> +                                       u8 fc_flags, u8 ic_flags, u8 otg_flags);
>>
>>     
> Just one comment about the API, I might not know all the detail of these two
> FC/IC registers, but maybe it can be even better:
>
> 1. separate flags definition from the FC/IC register bits, i.e. sometimes not
> all the register bits will be used, and some times a meaningful flag name is
> better (though the flag definition can be encoded properly to simplify the
> algorithm to map into the actual register bits)
>
>   

I understand what you mean and I think it is indeed better to keep the
bits and registers private
to the ulpi driver and export only some usable flags.
Meanwhile, there is new ulpi.h, merged between 2.6.34 and 2.6.35-rc1 and
it violates already
the concept of keeping the bits/regs private.
For now there are too many combinations of those bits and it is
impossible to summarize them
in some way usable flags.
pxa310 uses only a reletively small subset of the ulpi register bits, so
we could define
flags specific to pxa310 in the new pxa310-u2d.c or pxa310-u2d.h, so
board will only pass those flags
to the pxa310-u2d.c driver which in turn will translate them to the ulpi
register settings.

> 2. extend the original 'flags' variable and bits for the above definitions, so
> we can keep the API unchanged.
>   

Well, I think that the current API is still fresh and it does only
support current implementation
in which the flags are stored in otg_transceiver and there is no any
private data to the ulpi driver.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

-- 
Regards,
Igor.
