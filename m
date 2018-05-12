From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Sat, 12 May 2018 01:47:44 +0000
Subject: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <907eb976-7a26-2800-bf1a-563aca482235@arm.com>
References: <8898674D84E3B24BA3A2D289B872026A69EECF90@G01JPEXMBKW03>
 <ce2c6191-1f74-4cec-9009-0a770d32673a@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69EF9AF9@G01JPEXMBKW03>
 <78df845d-0788-3cbd-e435-5a3a8221fdc8@redhat.com>
 <8898674D84E3B24BA3A2D289B872026A69F09954@G01JPEXMBKW03>
 <907eb976-7a26-2800-bf1a-563aca482235@arm.com>
Message-ID: <8898674D84E3B24BA3A2D289B872026A69F0ACA3@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc
> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Marc
> Zyngier
> Sent: Thursday, May 10, 2018 11:12 PM
> To: Zhang, Lei/? ?; 'Mark Langsdorf'; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH]irqchip/irq-gic-v3:Avoid a waste of LPI resource
for device.
> 
> I do not believe this is required. nvec already describes the number of
> LPIs that are expected by the device. Why should we add a new parameter
> that looks to be the exact same thing?
yes. As you referred, it seems not really required. I will delete this parameter. 

> 
> Another problem is that this approach isn't really practical.
> msi_prepare is part of a generic structure, and changing it will impact
> all the others users of that structure. I'd rather you don't change its
> prototype for something that is implementation specific.
> 
> Instead, we have the msi_alloc_info_t structure, which is explicitly
> designed to collate information pertaining to the allocation
> requirements in an implementation agnostic way.
> At the moment, the ITS code only uses the first entry of the scratchpad
> area to store the DeviceID (and subsequently a pointer to the
> corresponding its_device).
> 
> You could use the second entry to encode the alignment requirement.
I think it is a good idea for compatibility. I accept your suggestion.
 

> The problem is that you now increase the footprint of the bitmap by a
> factor of 32:
> 
> - For a system with 16bit INTIDs, you go from 256 bytes to 8kB. That's
> bad, but OK, fine.
> 
> - For a system with 32bit INTIDs, you go from 16MB (which was already
> horrible) to 512MB. That's unacceptable.
> 
> At that point, using a simple bitmap doesn't work anymore, and we're
> better off switching to a free list of some sort that would keep the
> memory overhead to a minimum (and actually radically reduce the
> footprint even in the smallest configurations).
I will reconsider how to management LPI with small
memory overhead as possible as I can. 

By the way I will finish my patch in the next week.

Regards,
Lei Zhang
--
Lei Zhang  e-mail: zhang.lei at jp.fujitsu.com FUJITSU LIMITED
