From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Mar 2018 14:21:50 +0000
Subject: [3/3] irqchip/gic-v3: Bounds check redistributor accesses
In-Reply-To: <28f9c1cd-e1df-f4db-32b4-c9ca0f0f256a@ti.com>
References: <20171011094148.15674-4-punit.agrawal@arm.com>
 <28f9c1cd-e1df-f4db-32b4-c9ca0f0f256a@ti.com>
Message-ID: <8366ba39-a5a1-7734-752e-f3dce18e8007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lokesh,

On 13/03/18 13:38, Lokesh Vutla wrote:
> Hi All,
> 
> On Wednesday 11 October 2017 03:11 PM, Punit Agrawal wrote:
>> The kernel crashes while iterating over a redistributor that is
>> in-correctly sized by the platform firmware or doesn't contain the last
>> record.
>>
>> Prevent the crash by checking accesses against the size of the region
>> provided by the firmware. While we are at it, warn the user about
>> incorrect region size.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
> 
> Sorry to bring up an old thread. Just wanted to check what is the status
> on this series.

So far, I wasn't inclined to merge it, as it only allowed you to detect
a broken system, as opposed to help with a working one.

> This will also be useful when we try to boot linux + hypervisor with
> less number of cores than the SoC supports. For example:
> - SoC has 4 cores and Linux tries to boot with 2 cores.
> - then a type-2 hypervisor gets installed.
> - Hypervisor tries to boot a VM with linux on core 1.
> 
> Now the VM boot will fail while it iterates over all the GICR regions
> till GICR_TYPER is found. Hypervisor will trap any accesses to GICR
> regions of any invalid cpus(cpu 2, cpu 3 in this case).

It you're passing the redistributors to a guest, you're doing something
terribly wrong. You're putting the guest in a position to do a DoS on
the hypervisor (disabling its timer interrupt, for example). Not the
greatest move. There is a number of other gotchas with this approach
(virtual interrupts, distributor virtualization...).

> If the $patch is not the right approach, can you suggest on how to
> handle the above scenario?

The proper way to handle this is to virtualize the distributor and
redistributor by trap/emulate. The only thing you can safely pass to a
guest is the CPU interface, either as system registers or in its MMIO
form (if you have the GICv2 compatibility interface).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
