From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 28 Feb 2011 13:27:34 +0300
Subject: [PATCH v4 2/2] Defines DA850/AM18xx/OMAPL1-38 SOC resources used
	by PRUSS UIO driver
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BF3591A@dbde02.ent.ti.com>
References: <1298556402-26456-1-git-send-email-pratheesh@ti.com>
	<1298556402-26456-2-git-send-email-pratheesh@ti.com>
	<1298556402-26456-3-git-send-email-pratheesh@ti.com>
	<4D6796D6.5050008@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BF3591A@dbde02.ent.ti.com>
Message-ID: <4D6B7896.6000703@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-02-2011 7:46, TK, Pratheesh Gangadhar wrote:

>>> This patch defines PRUSS, ECAP clocks, memory and IRQ resources
>>> used by PRUSS UIO driver in DA850/AM18xx/OMAPL1-38 devices. UIO

>>      It's OMAP-L138.
> Ok.

>>> driver exports 64K I/O region of PRUSS, 128KB L3 RAM and 256KB
>>> DDR buffer to user space. PRUSS has 8 host event interrupt lines
>>> mapped to IRQ_DA8XX_EVTOUT0..7 of ARM9 INTC.These in conjunction
>>> with shared memory can be used to implement IPC between ARM9 and
>>> PRUSS.

>>> Signed-off-by: Pratheesh Gangadhar<pratheesh@ti.com>

[...]

>>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-
>> davinci/devices-da8xx.c
>>> index beda8a4..4ea3d1f 100644
>>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>>> @@ -725,3 +725,76 @@ int __init da8xx_register_cpuidle(void)
>>>
>>>    	return platform_device_register(&da8xx_cpuidle_device);
>>>    }
>>> +static struct resource pruss_resources[] = {
>>> +	[0] = {
>>> +		.start  = DA8XX_PRUSS_BASE,
>>> +		.end    = DA8XX_PRUSS_BASE + SZ_64K - 1,
>>> +		.flags  = IORESOURCE_MEM,
>>> +	},
>>> +	[1] = {
>>> +		.start  = DA8XX_L3RAM_BASE,
>>> +		.end    = DA8XX_L3RAM_BASE + SZ_128K - 1,
>>> +		.flags  = IORESOURCE_MEM,
>>> +	},
>>> +	[2] = {
>>> +		.start  = 0,
>>> +		.end    = SZ_256K - 1,

>>      Huh? I don't see where it's filled...

> The current use is only to indicate memory block size to the PRUSS UIO driver when we allocate DDR memory using dma_alloc_coherent.

    Why not pass this size via the platform data? There shouldn't be "dummy" 
resources.

> sram_alloc is changed to use L3_RAM (128KB) instead of ARM RAM (8KB) in Mistral patch set - I need to follow the same convention
 > for L3 RAM as well if I need to align with that patch. Is there a better 
way to do this?

    Didn't understand about L3 RAM.
    Also, please wrap your text at 80 columns.

WBR, Sergei
