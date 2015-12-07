From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Mon, 07 Dec 2015 22:37:57 +0800
Subject: [PATCH v5 21/21] KVM: ARM64: Add a new kvm ARM PMU device
In-Reply-To: <56659029.7040102@arm.com>
References: <1449123091-20252-1-git-send-email-zhaoshenglong@huawei.com>
 <1449123091-20252-22-git-send-email-zhaoshenglong@huawei.com>
 <56659029.7040102@arm.com>
Message-ID: <566599C5.4030400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/7 21:56, Marc Zyngier wrote:
>> +static int kvm_arm_pmu_set_attr(struct kvm_device *dev,
>> >+				struct kvm_device_attr *attr)
>> >+{
>> >+	switch (attr->group) {
>> >+	case KVM_DEV_ARM_PMU_GRP_IRQ: {
>> >+		int __user *uaddr = (int __user *)(long)attr->addr;
>> >+		int reg;
>> >+
>> >+		if (get_user(reg, uaddr))
>> >+			return -EFAULT;
>> >+
>> >+		if (reg < VGIC_NR_SGIS || reg >= VGIC_NR_PRIVATE_IRQS)
>> >+			return -EINVAL;
>> >+
>> >+		return kvm_arm_pmu_set_irq(dev->kvm, reg);
> What prevents the IRQ to be changed while the VM is already running?
> This should probably be a one-shot thing (change it once, be denied
> other changes).

So add a helper like vgic_initialized to check whether vPMU is initialized?

Thanks,
-- 
Shannon
