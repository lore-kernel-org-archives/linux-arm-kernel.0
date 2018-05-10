From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 May 2018 15:12:02 +0100
Subject: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69F09954@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A69EECF90@G01JPEXMBKW03>
 <ce2c6191-1f74-4cec-9009-0a770d32673a@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69EF9AF9@G01JPEXMBKW03>
 <78df845d-0788-3cbd-e435-5a3a8221fdc8@redhat.com>
 <8898674D84E3B24BA3A2D289B872026A69F09954@G01JPEXMBKW03>
Message-ID: <907eb976-7a26-2800-bf1a-563aca482235@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,

On 10/05/18 14:09, Zhang, Lei wrote:
> Hi Mark, Marc
> 
>> -----Original Message-----
>> From: linux-arm-kernel
>> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
>> Mark Langsdorf
>> Sent: Wednesday, May 09, 2018 11:32 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
>>
>  
>> Marc's suggestion of implementing a glue layer, and then changing the
>> glue layer interface to pass the allocation requirements up to this
>> driver is the best solution that can be supported for server products.
> 
> Thanks for your comments.
> ?
> I'm considering implementing a glue layer. But the management of 
> whole LPI resource is implemented by core ITS driver (irq-gic-v3-its.c),
> So I think core ITS driver also need to be modified.
> ?
> Below is my idea for core ITS driver. 
> Would you give me comments?
> ?
> Add an interface that can specify the number of LPIs allocation requirements on Core ITS driver.
> My idea is extend its_msi_prepare function by adding two argument.
> 
> SYNOPSIS
> its_msi_prepare(struct irq_domain *domain, struct device *dev,int nvec,
>  msi_alloc_info_t *info,int request_nr_lpis, int request_lpis_align)
> ?
> Argument "request_nr_lpis" means request LPIs total number for device. 

I do not believe this is required. nvec already describes the number of
LPIs that are expected by the device. Why should we add a new parameter
that looks to be the exact same thing?

> Argument "request_lpis_align" means request of LPIs alignment. 0 means do not specify alignment.

Another problem is that this approach isn't really practical.
msi_prepare is part of a generic structure, and changing it will impact
all the others users of that structure. I'd rather you don't change its
prototype for something that is implementation specific.

Instead, we have the msi_alloc_info_t structure, which is explicitly
designed to collate information pertaining to the allocation
requirements in an implementation agnostic way.

At the moment, the ITS code only uses the first entry of the scratchpad
area to store the DeviceID (and subsequently a pointer to the
corresponding its_device).

You could use the second entry to encode the alignment requirement.

> For PCI, PCI glue layer specifies, request_nr_lpis = 32, request_lpis_align = 32.
> For our device, the glue layer specifies, request_nr_lpis = 1, request_lpis_align = 0.
> (We have lots of device but each device only need a single LPI on our original bus. )
> ?
> 
> For expanding two arguments, core ITS driver maybe need to discard chunk mechanism 
> and use bitmap to manage LPI resource directly.
> ?
> Example:
>  (1) Non PCI glue layer requires ?request_nr_lpis? = 1, ?request_lpis_align? = 0.
> ?
>     Bitmap will become  ...0000000000000000001
> ?
>  (2) PCI glue layer requires ?request_nr_lpis? = 32, ?request_lpis_align? = 32.
> ?
>     Bitmap will become  ...000FFFFFFFF00000001
> ?
> ?
>  (3) Non PCI glue layer requires ?request_nr_lpis? = 1, ?request_lpis_align? = 0.
> ?
>     Bitmap will become  ...000FFFFFFFF00000003
> ?> I think it may be easy to implement by using
> bitmap_find_next_zero_area, because it has ?align_mask? argument.

The problem is that you now increase the footprint of the bitmap by a
factor of 32:

- For a system with 16bit INTIDs, you go from 256 bytes to 8kB. That's
bad, but OK, fine.

- For a system with 32bit INTIDs, you go from 16MB (which was already
horrible) to 512MB. That's unacceptable.

At that point, using a simple bitmap doesn't work anymore, and we're
better off switching to a free list of some sort that would keep the
memory overhead to a minimum (and actually radically reduce the
footprint even in the smallest configurations).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
