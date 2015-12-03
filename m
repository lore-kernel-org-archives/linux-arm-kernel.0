From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 03 Dec 2015 15:32:37 +0100
Subject: [PATCH] drivers: dma-coherent: free memory when failed to init
 DMA memory pool
In-Reply-To: <CY1PR0301MB12257F63F594E65DE67E64DFF50D0@CY1PR0301MB1225.namprd03.prod.outlook.com>
References: <1449138962-8264-1-git-send-email-b38611@freescale.com>
 <xa1toae7y9u8.fsf@mina86.com>
 <CY1PR0301MB12257F63F594E65DE67E64DFF50D0@CY1PR0301MB1225.namprd03.prod.outlook.com>
Message-ID: <xa1tio4fy54q.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03 2015, Duan Andy wrote:
> From: Mike Nazarewicz <mpn@google.com> Sent: Thursday, December 03, 2015 8:51 PM
>> To: Duan Fugang-B38611; torvalds at linux-foundation.org;
>> gregkh at linuxfoundation.org; m.szyprowski at samsung.com
>> Cc: linux-arm-kernel at lists.infradead.org; arnd at arndb.de;
>> iamjoonsoo.kim at lge.com; Duan Fugang-B38611
>> Subject: Re: [PATCH] drivers: dma-coherent: free memory when failed to
>> init DMA memory pool
>> 
>> On Thu, Dec 03 2015, Fugang Duan wrote:
>> > Free dma coherent memory when it failed to init DMA memory pool after
>> > calling .dma_init_coherent_memory(), otherwise it causes memmory leak.
>> >
>> > Signed-off-by: Fugang Duan <B38611@freescale.com>
>> > ---
>> >  drivers/base/dma-coherent.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
>> > index 55b8398..beb6bbe 100644
>> > --- a/drivers/base/dma-coherent.c
>> > +++ b/drivers/base/dma-coherent.c
>> > @@ -286,6 +286,7 @@ static int rmem_dma_device_init(struct reserved_mem
>> *rmem, struct device *dev)
>> >  				     &mem) != DMA_MEMORY_MAP) {
>> >  		pr_err("Reserved memory: failed to init DMA memory pool
>> at %pa, size %ld MiB\n",
>> >  			&rmem->base, (unsigned long)rmem->size / SZ_1M);
>> > +		kfree(mem);
>> 
>> mem == NULL at this point.  If dma_init_coherent_memory doesn?t return
>> DMA_MEMORY_MAP, mem pointer is not assigned any value.  If you think
>> there is a memory leak, please demonstrate a path of it happening.

> Kfree() will check mem NULL condition, so no need to add check in
> here.

Sure, but besides the point.  mem is always NULL so kfree(mem) is
a no-op so why add it?  There is no memory leak possible.  What is this
patch fixing?

>> >  		return -ENODEV;
>> >  	}
>> >  	rmem->priv = mem;

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  ??? ?mina86? ??????  (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
