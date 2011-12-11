From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Sun, 11 Dec 2011 20:35:55 +0100
Subject: [patch 1/1] arch/arm/kernel/setup.c: initialize arm_dma_zone_size
 earlier
In-Reply-To: <20111210213836.GP14542@n2100.arm.linux.org.uk> (Russell King's
 message of "Sat, 10 Dec 2011 21:38:36 +0000")
References: <20111208213131.407903305@rtp-net.org>
 <20111210213836.GP14542@n2100.arm.linux.org.uk>
Message-ID: <87d3bux5no.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

Hi,

> On Thu, Dec 08, 2011 at 10:31:09PM +0100, Arnaud Patard wrote:
>> arm_dma_zone_size is used by arm_bootmem_free() which is called by
>> paging_init(). Thus it needs to be set before calling it.
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Acked-by: Nicolas Pitre <nico@linaro.org>
>> CC: stable at kernel.org
>> Index: linux-2.6/arch/arm/kernel/setup.c
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/kernel/setup.c	2011-12-08 22:17:01.000000000 +0100
>> +++ linux-2.6/arch/arm/kernel/setup.c	2011-12-08 22:17:32.000000000 +0100
>> @@ -911,6 +911,12 @@ void __init setup_arch(char **cmdline_p)
>>  	machine_desc = mdesc;
>>  	machine_name = mdesc->name;
>>  
>> +#ifdef CONFIG_ZONE_DMA
>> +	if (mdesc->dma_zone_size) {
>> +		extern unsigned long arm_dma_zone_size;
>> +		arm_dma_zone_size = mdesc->dma_zone_size;
>> +	}
>> +#endif
>>  	if (mdesc->restart_mode)
>>  		reboot_setup(&mdesc->restart_mode);
>
> Just trying to apply this patch, it won't apply to mainline because it's
> based upon the bleeding edge of kernel development, rather than what's
> currently in mainline.  If we're going to fix this in current mainline
> and previous stable versions, the patch needs to be against that, not
> linux-next.
>
> Could you re-generate against an -rc kernel please?

Ok. No problem. Done. It's the patch 7204/1 in the patch system.

Arnaud
