From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 29 Apr 2010 07:01:53 +0800
Subject: PXA270 Errata and Data Cache question
In-Reply-To: <0470B16A-38C3-403F-A4EB-D1117364BB07@prograde.net>
References: <19E645CD-EDC9-478B-9D72-BEDF37F3AF4F@prograde.net>
	<l2if17812d71004271851p485543fdm7108251ebccf36e8@mail.gmail.com>
	<0470B16A-38C3-403F-A4EB-D1117364BB07@prograde.net>
Message-ID: <q2mf17812d71004281601i7ccc3042n38c4d2c9d8c1907d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 4:20 AM, Michael Cashwell <mboards@prograde.net> wrote:
> On Apr 27, 2010, at 9:51 PM, Eric Miao wrote:
>
>>> So setting that confusion aside, it seems simpler to use an uncached kernel SDRAM VA. In other instances I've used: "arch/arm/mach-pxa/include/mach/hardware.h:#define UNCACHED_ADDR UNCACHED_PHYS_0"
>>> I could extend this to provide an uncached SDRAM page but choosing the VA and PA looks tricky.
>>>
>>> Before I embark on all of that I'm wondering if such an uncached SDRAM mapping might not already exist.
>>
>> Not such mapping as far as I know.
>
> OK, I was being a little dense I think. What I've gone with for the errata workaround is to have the cpufreq-pxa2xx.c module do this in its init function:
>
> /* Errata E88 workaround needs to do uncached reads from SDRAM. ? ? ? ? */
> /* so we allocate a small amount of memory suitable for DMA. ? ? ? ? ? ?*/
> /* since all PXA2xx CPUs have incoherent DMA this forces the ? ? ? ? ? ?*/
> /* UNCACHED attribute on the mapping for the returned address. ? ? ? ? ?*/
> /* it's a bit hinky since DMA has nothing to do with our intent, ? ? ? ?*/
> /* but lacking a more appropirate API this seems to be a reasonable ? ? */
> /* way to do it. these CPUs are not going to reatroactively get ? ? ? ? */
> /* coherent DMA engines and later CPUs neither use this code nor ? ? ? ?*/
> /* suffer from from this errata anyway. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? */
>
> uncachedSDRAM = (unsigned int *)kmalloc(sizeof(unsigned int), GFP_KERNEL | GFP_DMA);
> if (!uncachedSDRAM)
> ? ? ? ?return -ENOMEM;
>
> I can then dereference that where needed. This seems to work well.
>
> I am planning on submitting all this once I have it wrapped up, but to that end does anyone have significant heartburn over using a DMA allocation this way? If there's a more direct alternative, I'm all ears.
>

I don't think it's a non-cached memory allocated this way.
Use dma_alloc_coherent() instead.
