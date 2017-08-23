From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 23 Aug 2017 10:01:11 +0800
Subject: [PATCH v5 0/7] Add RAS virtualization support to SEA/SEI
 notification type
In-Reply-To: <20170822085406.00006e74@huawei.com>
References: <1503065517-7920-1-git-send-email-gengdongjiu@huawei.com>
 <20170822085406.00006e74@huawei.com>
Message-ID: <6ba51a4b-60b4-a71c-9bfb-9b95b1bbd5b9@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jonathan,
   Thanks for the review, will correct the typo issue in the next patch version.


On 2017/8/22 15:54, Jonathan Cameron wrote:
> On Fri, 18 Aug 2017 22:11:50 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
>> In the firmware-first RAS solution, corrupt data is detected in a
>> memory location when guest OS application software executing at EL0
>> or guest OS kernel El1 software are reading from the memory. The
>> memory node records errors in an error record accessible using
>> system registers.
>>
>> Because SCR_EL3.EA is 1, then CPU will trap to El3 firmware, EL3
>> firmware records the error to APEI table through reading system
>> register.
>>
>> Because the error was taken from a lower Exception leve, if the
> 
> leve -> level
> 
>> exception is SEA/SEI and HCR_EL2.TEA/HCR_EL2.AMO is 1, firmware
>> sets ESR_EL2/FAR_El to fake a exception trap to EL2, then
>> transfers to hypervisor.
>>
>> Hypervisor calls the momory failure to deal with this error, momory
> 
> momory -> memory
> 
> memory failure -> memory failure function? Or callback perhaps?
> 
>> failure read the APEI table and decide whether it needs to deliver
>> SIGBUS signal to user space, the advantage of using SIGBUS signal
>> to notify user space is that it can be compatible Non-Kvm users.
> 
> Seems like a good description to me. Thanks.
> 
> Jonathan
> 
>>
>> Dongjiu Geng (5):
>>   acpi: apei: Add SEI notification type support for ARMv8
>>   support user space to query RAS extension feature
>>   arm64: kvm: route synchronous external abort exceptions to el2
>>   KVM: arm/arm64: Allow get exception syndrome and
>>   arm64: kvm: handle SEI notification and inject virtual SError
>>
>> James Morse (1):
>>   KVM: arm64: Save ESR_EL2 on guest SError
>>
>> Xie XiuQi (1):
>>   arm64: cpufeature: Detect CPU RAS Extentions
>>
>>  arch/arm/include/asm/kvm_host.h      |  2 ++
>>  arch/arm/kvm/guest.c                 |  5 +++
>>  arch/arm64/Kconfig                   | 16 ++++++++++
>>  arch/arm64/include/asm/barrier.h     |  1 +
>>  arch/arm64/include/asm/cpucaps.h     |  3 +-
>>  arch/arm64/include/asm/kvm_arm.h     |  2 ++
>>  arch/arm64/include/asm/kvm_emulate.h | 17 ++++++++++
>>  arch/arm64/include/asm/kvm_host.h    |  2 ++
>>  arch/arm64/include/asm/sysreg.h      |  5 +++
>>  arch/arm64/include/asm/system_misc.h |  1 +
>>  arch/arm64/include/uapi/asm/kvm.h    |  5 +++
>>  arch/arm64/kernel/cpufeature.c       | 13 ++++++++
>>  arch/arm64/kernel/process.c          |  3 ++
>>  arch/arm64/kvm/guest.c               | 48 +++++++++++++++++++++++++++++
>>  arch/arm64/kvm/handle_exit.c         | 21 +++++++++++--
>>  arch/arm64/kvm/hyp/switch.c          | 29 +++++++++++++++--
>>  arch/arm64/kvm/reset.c               |  3 ++
>>  arch/arm64/mm/fault.c                | 21 +++++++++++--
>>  drivers/acpi/apei/Kconfig            | 15 +++++++++
>>  drivers/acpi/apei/ghes.c             | 60 +++++++++++++++++++++++-------------
>>  include/acpi/ghes.h                  |  2 +-
>>  include/uapi/linux/kvm.h             |  3 ++
>>  virt/kvm/arm/arm.c                   |  7 +++++
>>  23 files changed, 254 insertions(+), 30 deletions(-)
>>
> 
> 
> .
> 
