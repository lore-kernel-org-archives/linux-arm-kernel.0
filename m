From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Thu, 10 May 2018 13:09:11 +0000
Subject: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <78df845d-0788-3cbd-e435-5a3a8221fdc8@redhat.com>
References: <8898674D84E3B24BA3A2D289B872026A69EECF90@G01JPEXMBKW03>
 <ce2c6191-1f74-4cec-9009-0a770d32673a@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69EF9AF9@G01JPEXMBKW03>
 <78df845d-0788-3cbd-e435-5a3a8221fdc8@redhat.com>
Message-ID: <8898674D84E3B24BA3A2D289B872026A69F09954@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Marc

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
> Mark Langsdorf
> Sent: Wednesday, May 09, 2018 11:32 PM
> To: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
> 
 
> Marc's suggestion of implementing a glue layer, and then changing the
> glue layer interface to pass the allocation requirements up to this
> driver is the best solution that can be supported for server products.

Thanks for your comments.
?
I'm considering implementing a glue layer. But the management of 
whole LPI resource is implemented by core ITS driver (irq-gic-v3-its.c),
So I think core ITS driver also need to be modified.
?
Below is my idea for core ITS driver. 
Would you give me comments?
?
Add an interface that can specify the number of LPIs allocation requirements on Core ITS driver.
My idea is extend its_msi_prepare function by adding two argument.

SYNOPSIS
its_msi_prepare(struct irq_domain *domain, struct device *dev,int nvec,
 msi_alloc_info_t *info,int request_nr_lpis, int request_lpis_align)
?
Argument "request_nr_lpis" means request LPIs total number for device. 
Argument "request_lpis_align" means request of LPIs alignment. 0 means do not specify alignment.

For PCI, PCI glue layer specifies, request_nr_lpis = 32, request_lpis_align = 32.
For our device, the glue layer specifies, request_nr_lpis = 1, request_lpis_align = 0.
(We have lots of device but each device only need a single LPI on our original bus. )
?

For expanding two arguments, core ITS driver maybe need to discard chunk mechanism 
and use bitmap to manage LPI resource directly.
?
Example:
 (1) Non PCI glue layer requires ?request_nr_lpis? = 1, ?request_lpis_align? = 0.
?
    Bitmap will become  ...0000000000000000001
?
 (2) PCI glue layer requires ?request_nr_lpis? = 32, ?request_lpis_align? = 32.
?
    Bitmap will become  ...000FFFFFFFF00000001
?
?
 (3) Non PCI glue layer requires ?request_nr_lpis? = 1, ?request_lpis_align? = 0.
?
    Bitmap will become  ...000FFFFFFFF00000003
?
I think it may be easy to implement by using bitmap_find_next_zero_area, because it has ?align_mask? argument.

Regards,
Lei Zhang
--
Lei Zhang  e-mail: zhang.lei at jp.fujitsu.com FUJITSU LIMITED
