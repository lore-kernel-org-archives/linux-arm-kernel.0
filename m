From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 9 Jul 2018 09:42:40 +0100
Subject: [PATCH v2 6/6] KVM: arm/arm64: vgic: Allow configuration of
 interrupt groups
In-Reply-To: <1530697100-22419-7-git-send-email-christoffer.dall@arm.com>
References: <1530697100-22419-1-git-send-email-christoffer.dall@arm.com>
 <1530697100-22419-7-git-send-email-christoffer.dall@arm.com>
Message-ID: <7f875ead-d3cb-1fec-bc84-56e64526e6a7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/18 10:38, Christoffer Dall wrote:
> Implement the required MMIO accessors for GICv2 and GICv3 for the
> IGROUPR distributor and redistributor registers.
> 
> This can allow guests to change behavior compared to running on previous
> versions of KVM, but only to align with the architecture and hardware
> implementations.
> 
> This also allows userspace to configure the groups for interrupts.  Note
> that this potentially results in GICv2 guests not receiving interrupts
> after migration if migrating from an older kernel that exposes GICv2
> interrupts as group 1.
> 
> Cc: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
> I implemented (but stashed) a version of this which predicated the
> behavior based on the value of GICD_IIDR revision field, falling back to
> ignoring writes and resetting GICv2 groups to 0 if the guest wrote a
> revision less than 2.  However, current QEMU implementations simply
> don't write the GICD_IIDR, so this doesn't help at all without changing
> QEMU anyhow.
> 
> The only actual fix I can see here to work around the problem in the
> kernel is to require an opt-in to allow restoring groups from userspace,
> but that's a lot of logic to support cross-kernel version migration.
> 
> Question: Do we expect that cross-kernel version migration is a critical
> feature that people really expect to work, and do we actually have
> examples of catering to this in the kernel elsewhere?  (Also, how would
> then that relate to the whole 'adding a new sysreg breaks migration'
> situation?)

I don't really get why QEMU doesn't try to restore GICD_IIDR, while it
is definitely trying to restore RO sysregs (and that's how we detect
incompatibilities).

I think we should at least give userspace a chance to do the right
thing. If it doesn't, well, too bad.

How bad is that "writable GICD_IIDR" patch? Because at this stage, and
in the absence of any comment, I'm close to just pick that series and
merge it for 4.19.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
