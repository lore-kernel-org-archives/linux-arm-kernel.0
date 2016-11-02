From: adouglas@cadence.com (Alan Douglas)
Date: Wed, 2 Nov 2016 09:36:14 +0000
Subject: Use of GICv3/ITS with PCIe host-generic driver - resizing ITS
 MAPD?
In-Reply-To: <861syvkqcr.fsf@arm.com>
References: <CY1PR07MB2506C5C771B446139A743B99D8A10@CY1PR07MB2506.namprd07.prod.outlook.com>
 <861syvkqcr.fsf@arm.com>
Message-ID: <CY1PR07MB2506C9B4133B1CE185AD0260D8A00@CY1PR07MB2506.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> > When setting up bus 0, the ITS device is created, and
> > its_build_map_cmd() sets the size of the ITS MAPD based on the number
> > of interrupts claimed by bus 0.  When subsequent buses are enumerated,
> > the ITS device will be reused, however we do not increase the number
> > of supported interrupts to allow for the additional interrupts claimed
> > by the additional devices being enumerated.  (This can be seen in
> > its_msi_prepare(), which is called for each device which has MSI/MSI-X
> > enabled, and will reuse an existing ITS. )
> 
> Am I right in understanding that all the PCIe devices in your system end-up
> aliasing to the same RequesterID? If so, that's a major issue. The ITS is
> designed so that each device exposes its *own* RID, and have its own
> Interrupt Translation Table (ITT).
> 
> In your case, you seem to first discover the root port, which is not upstream
> of anything, so it doesn't alias with anything at that point. We allocate the
> corresponding ITT, and it's all fine. Until we start probing the rest, and ugly
> things happen.
> 
Yes, your understanding is correct.  I will dig into this a bit further to see what
is wrong then send an update.  I suspect my DTS msi mapping.

> > The solution I have implemented is in its_alloc_device_irq(), if the
> > offset into the LPI table for the allocated interrupt is greater than
> > the ITS MAPD, I reallocate the itt area, and resize the ITS MAPD.  I'm
> > looking for comments as to whether this is a suitable solution and I
> > should submit as a patch, is there some other recommendation or am I
> > missing something regarding reuse of the ITS?
> 
> Not seeing the patch doesn't help, but in general reallocating an ITT implies
> unmapping everything at the ITS level (LPIs, devices), recreating the ITT,
> remapping everything, and then replaying fake interrupts to cater for
> anything that you;ve missed in between. Not exactly fun.
> 
> So before we have to introduce all of this, it would be good to find out
> *why* are all the devices aliased together. Because this completely screws
> all the ITS isolation, and makes device assignment to guest VM completely
> insecure.
OK, understood.  My current patch doesn't deal with all the issues you point out,
but I will concentrate on avoiding the re-use instead.   Thanks for clarifying that
this re-use is not expected in my case.

Thanks,
Alan
