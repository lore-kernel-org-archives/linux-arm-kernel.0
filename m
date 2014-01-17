From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Fri, 17 Jan 2014 03:03:41 +0000
Subject: [PATCH V7 3/3] ARM: imx: add suspend in ocram support for i.mx6sl
In-Reply-To: <20140117021614.GB1565@shlinux1.ap.freescale.net>
References: <1389864907-4040-1-git-send-email-b20788@freescale.com>
 <1389864907-4040-3-git-send-email-b20788@freescale.com>
 <20140117021614.GB1565@shlinux1.ap.freescale.net>
Message-ID: <a85c539427af4c26bac0609eb468fd7f@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Great found, I miss this one, only tested the function before... Will do it in V8.

Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Friday, January 17, 2014 10:16 AM
>To: Huang Yongcai-B20788
>Cc: kernel at pengutronix.de; linux at arm.linux.org.uk; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH V7 3/3] ARM: imx: add suspend in ocram support for i.mx6sl
>
>On Thu, Jan 16, 2014 at 05:35:07PM +0800, Anson Huang wrote:
>> @@ -63,6 +63,7 @@
>>  #define MX6Q_SRC_GPR1	0x20
>>  #define MX6Q_SRC_GPR2	0x24
>>  #define MX6Q_MMDC_MAPSR	0x404
>> +#define MX6Q_MMDC_MPDGCTRL0	0x83c
>>  #define MX6Q_GPC_IMR1	0x08
>>  #define MX6Q_GPC_IMR2	0x0c
>>  #define MX6Q_GPC_IMR3	0x10
>> @@ -107,14 +108,36 @@
>>  	ldreq	r11, [r0, #PM_INFO_MX6Q_MMDC_V_OFFSET]
>>  	ldrne	r11, [r0, #PM_INFO_MX6Q_MMDC_P_OFFSET]
>>
>> +	cmp 	r3, #MXC_CPU_IMX6SL
>> +	bne	4f
>> +
>> +	/* reset read FIFO, RST_RD_FIFO */
>> +	ldr	r7, =MX6Q_MMDC_MPDGCTRL0
>> +	ldr	r6, [r11, r7]
>> +	orr     r6, r6, #(1 << 31)
>> +	str	r6, [r11, r7]
>> +2:
>> +	ldr	r6, [r11, r7]
>> +	ands	r6, r6, #(1 << 31)
>> +	bne	2b
>> +
>> +	/* reset FIFO a second time */
>> +	ldr	r6, [r11, r7]
>> +	orr     r6, r6, #(1 << 31)
>> +	str	r6, [r11, r7]
>> +3:
>> +	ldr	r6, [r11, r7]
>> +	ands	r6, r6, #(1 << 31)
>> +	bne	3b
>> +4:
>>  	/* let DDR out of self-refresh */
>>  	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
>>  	bic	r7, r7, #(1 << 21)
>>  	str	r7, [r11, #MX6Q_MMDC_MAPSR]
>> -2:
>> +5:
>>  	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
>>  	ands	r7, r7, #(1 << 25)
>> -	bne	2b
>> +	bne	5b
>>
>>  	/* enable DDR auto power saving */
>>  	ldr	r7, [r11, #MX6Q_MMDC_MAPSR]
>> @@ -282,6 +305,7 @@ resume:
>>  	str	r7, [r11, #MX6Q_SRC_GPR1]
>>  	str	r7, [r11, #MX6Q_SRC_GPR2]
>>
>> +	ldr	r3, [r0, #PM_INFO_CPU_TYPE_OFFSET]
>>  	mov	r5, #0x1
>>  	resume_mmdc
>
>The IMX6SL special handling in suspend/set_mmdc_lpm gets lost?
>
>Shawn
>
>>
>> --
>> 1.7.9.5
>>
>>
