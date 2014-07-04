From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 4 Jul 2014 10:16:59 +0000
Subject: [PATCH 5/5] ARM: imx: Add Freescale LS1021A SMP support
In-Reply-To: <20140702113058.GF14665@leverpostej>
References: <1404291772-2644-1-git-send-email-jingchang.lu@freescale.com>
 <1404291772-2644-6-git-send-email-jingchang.lu@freescale.com>
 <20140702113058.GF14665@leverpostej>
Message-ID: <69cc715ea3d54e64a04c3765b02f9ff8@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Mark Rutland [mailto:mark.rutland at arm.com]
>Sent: Wednesday, July 02, 2014 7:31 PM
>To: Lu Jingchang-B35083
>Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org;
>devicetree at vger.kernel.org; Lu Jingchang-B35083
>Subject: Re: [PATCH 5/5] ARM: imx: Add Freescale LS1021A SMP support
>
>On Wed, Jul 02, 2014 at 10:02:52AM +0100, Jingchang Lu wrote:
>> From: Jingchang Lu <b35083@freescale.com>
>>
>> Freescale LS1021A SoC deploys two cortex-A7 processors, this adds
>> bring-up support for the secondary core.
>>
>> Signed-off-by: Jingchang Lu <b35083@freescale.com>
>> ---
>>  arch/arm/mach-imx/common.h       |  2 ++
>>  arch/arm/mach-imx/headsmp.S      | 11 ++++++++++
>>  arch/arm/mach-imx/mach-ls1021a.c |  1 +
>>  arch/arm/mach-imx/platsmp.c      | 44
>++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 58 insertions(+)
>
>[...]
>
>> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
>> index de5047c..fdd93d9 100644
>> --- a/arch/arm/mach-imx/headsmp.S
>> +++ b/arch/arm/mach-imx/headsmp.S
>> @@ -29,3 +29,14 @@ ENTRY(v7_secondary_startup)
>>  	set_diag_reg
>>  	b	secondary_startup
>>  ENDPROC(v7_secondary_startup)
>> +
>> +ENTRY(ls1021a_secondary_startup)
>> +	/* set CNTFREQ of secondary core */
>> +	ldr	r0, =12500000
>> +	mcr 	p15, 0, r0, c14, c0, 0
>> +	/* disable Physical and Virtural Timer */
>> +	mov	r0, #0x0
>> +	mcr	p15, 0, r0, c14, c2, 1
>> +	mcr	p15, 0, r0, c14, c3, 1
>> +	b	secondary_startup
>
>Urrgh...
>
>What about CNTVOFF? That's been a source of problems elsewhere.
>
>Is the boot CPU set up correctly?
>
>Is that frequency always going to be correct?
>
We use 12.5Mhz as the counter clock, and We have found the virtual counter offset issue.
We currently use the physical counter as a workaround for this, we are also working on
to clear the CNTVOFF in u-boot, when it is finished, the virtual counter would be sync
and work well.
Thanks.

>[...]
>
>> +static void __init ls1021a_smp_init_cpus(void) {
>> +	int i, ncores;
>> +	/* get number of cores from CP15 L2 controller register(L2CTLR)*/
>> +	asm volatile ("mrc p15, 1, %0, c9, c0, 2" : "=r" (ncores));
>> +
>> +	ncores = ((ncores >> 24) & 0x3) + 1;
>> +	for (i = ncores; i < NR_CPUS; i++)
>> +		set_cpu_possible(i, false);
>> +}
>
>NAK.
>
>This information is _already_ in the DT. This adds more code to do
>redundant work, and it's broken.
>
>The physical<->logical CPU ID mapping is arbitrary, so you set arbitrary
>CPUs as being online despite this not necessarily being the case.
>
>Get rid of this, and rely on the DT being correct. There;s no reason it
>shouldn't be for a new platform.
>
>Thanks,
>Mark.
I will remove this. Thanks.



Best Regards,
Jingchang
