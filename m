From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Fri, 08 Jan 2016 21:31:23 +0800
Subject: [PATCH v8 20/20] KVM: ARM64: Add a new kvm ARM PMU device
In-Reply-To: <CAFEAcA9O7WUtPzETvjAwHQeJ8h65bxTjsYtr5_McE26k-5rdUw@mail.gmail.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-21-git-send-email-zhaoshenglong@huawei.com>
 <CAFEAcA_MDiOphseZ7RGNE3G=4ZDF5SFV5krOjanPbVuhgg9gnQ@mail.gmail.com>
 <568E7AF1.9040103@huawei.com>
 <CAFEAcA-Qcda7TSFLSeykLHqZYdP6tYdEjPe2uHN6f_+omqWFZg@mail.gmail.com>
 <568F27A8.80808@huawei.com>
 <CAFEAcA8DO5VksiP55vnuOD3NERJTfr1q=une4n6N=Oj8JUa1_A@mail.gmail.com>
 <568FA861.1080307@linaro.org>
 <CAFEAcA9O7WUtPzETvjAwHQeJ8h65bxTjsYtr5_McE26k-5rdUw@mail.gmail.com>
Message-ID: <568FBA2B.60503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/8 20:56, Peter Maydell wrote:
> On 8 January 2016 at 12:15, Shannon Zhao <shannon.zhao@linaro.org> wrote:
>> Firstly, userspace will call kvm device ioctl to create the PMU device, if
>> it fails it will return an error.
>> Secondly, userspace will call SET_DEVICE_ATTR ioctl to configure the PMU irq
>> number. If the irq is invalid, this will return an error and the userspace
>> will stop if it takes care the error. If the irq is valid, the PMU is well
>> initialized.
>>
>> If userspace doesn't call SET_ATTR ioctl to configure the PMU irq, the PMU
>> is not well initialized and guest can't use the PMU.
>
> Yes, this is my point. If you require userspace to do:
>   * create PMU device
>   * configure PMU device via SET_DEVICE_ATTR
>   * complete init of PMU device via a KVM_DEV_ARM_PMU_CTRL_INIT attr
>
> then any bugs on the userspace side where it isn't configuring
> correctly can be easily caught, and will turn into a "VM fails
> to start with helpful error message", rather than "VM starts but
> doesn't work in an obscure way".
>
> This is particularly important for devices which have userspace
> visible registers, because userspace will also want to be able
> to read and write state of those registers before first vcpu run.
> If there is no "init is complete" ioctl then the kernel code ends
> up having to guess when init has completed for various entry points
> where the guest does something else (register access, vcpu start, etc).
>
> It might happen to not be so important for the PMU, but I think it
> would be very useful if we have a pattern where every device that
> is created via this API works in the same way (and it means that if
> we end up extending the PMU in future we will already have the API
> in place and don't need to worry about legacy userspace).
>
> Speaking of userspace access to registers, what is the intended API
> for migrating the PMU register state ?
>
Since the PMU register states are stored in sys_regs[NR_SYS_REGS], they 
could be migrated with other sys registers. There is only the "struct 
perf_event *perf_event" we should take care of I think. I didn't figure 
out a good way for this especially when guest is using the perf.

Thanks,
-- 
Shannon
