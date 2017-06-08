From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 8 Jun 2017 10:36:04 +0100
Subject: [kvmtool PATCH v10 00/15] kvmtool: arm: ITS emulation and GSI
 routing support
In-Reply-To: <87wp8mj12p.fsf@arm.com>
References: <20170425143932.17235-1-andre.przywara@arm.com>
 <87wp8mj12p.fsf@arm.com>
Message-ID: <887621e2-83d2-300f-ae13-f5b86c101ae3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/06/17 10:11, Marc Zyngier wrote:
> On Tue, Apr 25 2017 at  3:39:17 pm BST, Andre Przywara <andre.przywara@arm.com> wrote:
>> Hi,
>>
>> another update to the ITS emulation series for kvmtool.
>> This addresses the comments Marc and Jean-Philippe had on the last
>> version (thanks for that!): I moved the DevID feature detection to avoid
>> static variables, rewrote the error path on creating IRQ routes and
>> extended the MMIO reservation to cover the ITS doorbell page as well.
>> Not sure if that's the right way to do, though.
>> Also we now ignore writes to the PBA region, which is what the spec
>> somewhat recommends.
>> -------------------------------------------
>>
>> This series teaches kvmtool how to support KVM's ITS emulation. Also
>> (as this is somewhat related and has been co-developed) it enables GSI
>> routing for ARM/ARM64, which allows IRQFDs to be used, for instance
>> to use vhost_net. At the moment this is dependent on the guest
>> using the ITS emulation, but GICv2M support may be added at a later time.
>>
>> The first six patches are generic fixes and refactoring to pave the
>> road for the rest of the patches. Most importantly patch 3/15 pulls
>> the GSI routing code from x86 into generic code.
>> Patch 7 updates the Linux headers to pull the new ITS and 32-bit
>> GICv3 definitions in. This allows us to enable GICv3 emulation for 32-bit
>> ARM and also get rid of some placeholder lines in patch 8.
>> The following four patches add ITS emulation support. They reserve and
>> register the required ITS register frame and populate a DT node with
>> the necessary data. Also the patches add the required device ID to the
>> KVM_SIGNAL_MSI ioctl.
>> Patches 13 and 14 enable IRQ GSI routing for ARM/ARM64.
>> This is needed to use IRQFDs, which is a prerequisite for vhost
>> functionality, for instance. The code sets up the (dummy) SPI
>> routing table and adds the device ID to the routing entry.
>> The last patch finally enables the guest ITS support by extending the
>> existing --irqchip= parameter to allow "--irqchip=gicv3-its".
>>
>> These patches make use of the KVM kernel functionality merged into
>> 4.8-rc: both Eric's IRQ routing series and the ITS emulation.
>> It can also be found in my kvmtool git repository [1].
> 
> [...]
> 
> Apologies for having dropped the ball on this series. Apart from the
> Linux include import which should be that of 4.11,

I copied the headers five days before the 4.11 release, and just
confirmed that the files are identical with the release (even with
4.11.4), so I think it's just the commit message of patch 07/15 that is
a bit wrong here. Hopefully we can ignore this then.

> this looks good to
> me. For the whole series:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks a lot!

Cheers,
Andre.
