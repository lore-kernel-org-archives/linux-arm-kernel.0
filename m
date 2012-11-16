From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 16 Nov 2012 09:15:13 +0200
Subject: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
In-Reply-To: <20121112225037.GU6801@atomide.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com>
Message-ID: <50A5E801.3000100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-13 00:50, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [121112 02:27]:
>> Hi,
>>
>> This series changes omapfb to use standard dma_alloc funcs instead of omap
>> specific vram allocator. This let's us remove the omap vram allocator, making
>> omapfb platform independent.
>>
>> However, note that using standard dma funcs causes the following downsides:
>>
>> 1) dma_alloc_attrs doesn't let us allocate at certain physical address.
>> However, this should not be a problem as this feature of vram allocator
>> is only used when reserving the framebuffer that was initialized by the
>> bootloader, and we don't currently support "passing" a framebuffer from
>> the bootloader to the kernel anyway.
>>
>> 2) dma_alloc_attrs, as of now, always ioremaps the allocated area, and
>> we don't need the ioremap when using VRFB. This patch uses
>> DMA_ATTR_NO_KERNEL_MAPPING for the allocation, but the flag is currently
>> not operational.
>>
>> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
>> changed the ioctl to return 64M for all the values, which, I hope, the
>> applications will interpret as "there's enough vram".
>>
>> 4) "vram" kernel parameter to define how much ram to reserve for video use no
>> longer works. The user needs to enable CMA and use "cma" parameter.
> 
> Great, thanks for fixing these. Could you please queue these into
> a separate branch against v3.7-rc5 that I can also merge into
> omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3?
> 
> Feel free to add my Acked-by: Tony Lindgren <tony@atomide.com> to the
> arch/arm/*omap*/* parts.

I added your acks, and pushed:

git://gitorious.org/linux-omap-dss2/linux.git 3.8/vram-conversion

It's based on -rc4 as my other branches are based on that.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/826d1247/attachment.sig>
