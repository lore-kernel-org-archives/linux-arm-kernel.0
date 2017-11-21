From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 21 Nov 2017 19:31:32 +0800
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <5A0C8696.7020002@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <5A049B20.6000501@arm.com> <20171113112946.GK14144@cbox>
 <5A0B13B5.3000205@arm.com> <e0dea261-a9ef-9d00-682a-a4449d1de5ec@huawei.com>
 <5A0C8696.7020002@arm.com>
Message-ID: <5de0ad2e-a6dc-705d-80b9-2baf16a480b4@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi james,

On 2017/11/16 2:25, James Morse wrote:
> What about 32bit? The register names and sizes are different. User-space would
> need a separate implementation to drive this. This is easier for the kernel to do
I agree with you that using different register names and sizes, such as 32 bit.
For the hcr_el2.VSE/hcr_el2.VF/hcr_el2.IF(KVM_IRQ_LINE needs hcr_el2.VF/hcr_el2.IF),  we can only export
the necessary bits that user space need.

Then add the renamed registers to the sys_reg_desc sys_reg_descs[], user space will save these registers in sys_reg_desc sys_reg_descs[]
before migration, and load these saved value after finish migration, which should be current user space logic, this way will avoid do much change.
Not sure whether other people have better idea.

static const struct sys_reg_desc sys_reg_descs[] = {
	..................................
        { SYS_DESC(SYS_AFSR0_EL1), access_vm_reg, reset_unknown, AFSR0_EL1 },
        { SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
        { SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
	.................................
}

> 
> We should have an API specific to the feature we are offering user-space. We are
> offering a way to trigger an SError, with a specified ESR if the system supports
> that. To be migrated it needs to be able to read this information back.
> 
> This way we can change the implementation without changing the API.
