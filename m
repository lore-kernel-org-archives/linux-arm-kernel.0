From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 02 Nov 2016 20:59:59 +0000
Subject: Use of GICv3/ITS with PCIe host-generic driver - resizing ITS
 MAPD?
In-Reply-To: <CY1PR07MB2506C9B4133B1CE185AD0260D8A00@CY1PR07MB2506.namprd07.prod.outlook.com>
 (Alan Douglas's message of "Wed, 2 Nov 2016 09:36:14 +0000")
References: <CY1PR07MB2506C5C771B446139A743B99D8A10@CY1PR07MB2506.namprd07.prod.outlook.com>
 <861syvkqcr.fsf@arm.com>
 <CY1PR07MB2506C9B4133B1CE185AD0260D8A00@CY1PR07MB2506.namprd07.prod.outlook.com>
Message-ID: <8637j9iomo.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02 2016 at 09:36:14 AM, Alan Douglas <adouglas@cadence.com> wrote:
> Hi Marc,
>
>> > When setting up bus 0, the ITS device is created, and
>> > its_build_map_cmd() sets the size of the ITS MAPD based on the number
>> > of interrupts claimed by bus 0.  When subsequent buses are enumerated,
>> > the ITS device will be reused, however we do not increase the number
>> > of supported interrupts to allow for the additional interrupts claimed
>> > by the additional devices being enumerated.  (This can be seen in
>> > its_msi_prepare(), which is called for each device which has MSI/MSI-X
>> > enabled, and will reuse an existing ITS. )
>> 
>> Am I right in understanding that all the PCIe devices in your system end-up
>> aliasing to the same RequesterID? If so, that's a major issue. The ITS is
>> designed so that each device exposes its *own* RID, and have its own
>> Interrupt Translation Table (ITT).
>> 
>> In your case, you seem to first discover the root port, which is not upstream
>> of anything, so it doesn't alias with anything at that point. We allocate the
>> corresponding ITT, and it's all fine. Until we start probing the rest, and ugly
>> things happen.
>> 
> Yes, your understanding is correct.  I will dig into this a bit
> further to see what is wrong then send an update.  I suspect my DTS
> msi mapping.

Right. That would explain a lot of what you're seeing. In general, and
unless you have some funky remapping going on, you're better off having
a very straightforward msi-map property in your RC node (such as example
#1 in Documentation/devicetree/bindings/pci/pci-msi.txt).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
