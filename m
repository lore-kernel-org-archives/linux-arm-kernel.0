From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 23 Oct 2009 10:57:16 -0700
Subject: [PATCH v2 12/32] OMAP: PM: DMA context save/restore for off-mode
	support
In-Reply-To: <618f0c910910230654l3a7e241esd3f838878424310b@mail.gmail.com>
	(Venkatraman S.'s message of "Fri\, 23 Oct 2009 19\:24\:47 +0530")
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
	<618f0c910910230654l3a7e241esd3f838878424310b@mail.gmail.com>
Message-ID: <87ljj2f0xv.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Venkatraman S <svenkatr@ti.com> writes:

> On Fri, Oct 23, 2009 at 4:39 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> For HS/EMU devices, these additional features are also used:
>>
>> - DMA interrupt disable routine added
>> - Added DMA controller reset to DMA context restore
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

[...]

>> +void omap_dma_disable_irq(int lch)
>> +{
>> + ? ? ? u32 val;
>> +
>> + ? ? ? if (cpu_class_is_omap2()) {
>> + ? ? ? ? ? ? ? /* Disable interrupts */
>> + ? ? ? ? ? ? ? val = dma_read(IRQENABLE_L0);
>> + ? ? ? ? ? ? ? val &= ~(1 << lch);
>> + ? ? ? ? ? ? ? dma_write(val, IRQENABLE_L0);
>> + ? ? ? }
>> +}
>> +
> Just curious - Doesn't it need EXPORT_SYMBOL() ?

No, was not meant to be used by modules.  In fact, when I update this
patch for the chmod problem, I'm going to drop the EXPORT_SYMBOL() for
the context save/restore as well since that is only meant to be called
from the PM core.

> Is this used somewhere ? If yes,
> would be nice to have omap_dma_enable_irq as well

Looking closer, it looks like the user of this was removed in 
"[PATCH v2 17/32] OMAP3: PM: Fix secure SRAM context save/restore", so I'll
remove this function in that patch as well.

Kevin
