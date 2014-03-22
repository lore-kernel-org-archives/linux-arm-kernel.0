From: anup.patel@linaro.org (Anup Patel)
Date: Sat, 22 Mar 2014 09:54:55 +0530
Subject: [PATCH v5 02/11] ARM/ARM64: KVM: Add base for PSCI v0.2 emulation
In-Reply-To: <20140321232704.GB25519@cbox>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
 <1395406414-11707-3-git-send-email-anup.patel@linaro.org>
 <20140321232704.GB25519@cbox>
Message-ID: <CALrVBkvRqRWnnzgBYCLGwYbiOy-JnezgE=89nq8O3rvdv7RqFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 March 2014 04:57, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Fri, Mar 21, 2014 at 06:23:25PM +0530, Anup Patel wrote:
>> Currently, the in-kernel PSCI emulation provides PSCI v0.1 interface to
>> VCPUs. This patch extends current in-kernel PSCI emulation to provide
>> PSCI v0.2 interface to VCPUs.
>>
>> By default, ARM/ARM64 KVM will always provide PSCI v0.1 interface for
>> keeping the ABI backward-compatible.
>>
>> To select PSCI v0.2 interface for VCPUs, the user space (i.e. QEMU or
>> KVMTOOL) will have to set KVM_ARM_VCPU_PSCI_0_2 feature when doing VCPU
>> init using KVM_ARM_VCPU_INIT ioctl.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>
> The content here can carry my Reviewed-by tag, but I think Rob's point
> about sharing this code between KVM arm/arm64 and the PSCI code itself
> it important, see:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241792.html

My apologies, I totally missed Rob's comment.

My suggestion would be to have:
arch/arm/include/uapi/asm/psci.h
arch/arm64/include/uapi/asm/psci.h

These headers can have following defines:

/* PSCI v0.1 interface */
#define PSCI_FN(base, n)            (base + (n))

#define PSCI_FN_CPU_SUSPEND(base)        PSCI_FN(base, 0)
#define PSCI_FN_CPU_OFF(base)        PSCI_FN(base, 1)
#define PSCI_FN_CPU_ON(base)        PSCI_FN(base, 2)
#define PSCI_FN_MIGRATE(base)        PSCI_FN(base, 3)

/* PSCI v0.2 interface */
#define PSCI_0_2_FN_BASE        0x84000000
#define PSCI_0_2_FN(n)        (PSCI_0_2_FN_BASE + (n))
#define PSCI_0_2_FN64_BASE        0xC4000000
#define PSCI_0_2_FN64(n)        (PSCI_0_2_FN64_BASE + (n))

#define PSCI_0_2_FN_PSCI_VERSION    PSCI_0_2_FN(0)
#define PSCI_0_2_FN_CPU_SUSPEND    PSCI_0_2_FN(1)
#define PSCI_0_2_FN_CPU_OFF        PSCI_0_2_FN(2)
#define PSCI_0_2_FN_CPU_ON        PSCI_0_2_FN(3)
#define PSCI_0_2_FN_AFFINITY_INFO    PSCI_0_2_FN(4)
#define PSCI_0_2_FN_MIGRATE        PSCI_0_2_FN(5)
#define PSCI_0_2_FN_MIGRATE_INFO_TYPE \
                    PSCI_0_2_FN(6)
#define PSCI_0_2_FN_MIGRATE_INFO_UP_CPU \
                    PSCI_0_2_FN(7)
#define PSCI_0_2_FN_SYSTEM_OFF    PSCI_0_2_FN(8)
#define PSCI_0_2_FN_SYSTEM_RESET    PSCI_0_2_FN(9)

#define PSCI_0_2_FN64_CPU_SUSPEND    PSCI_0_2_FN64(1)
#define PSCI_0_2_FN64_CPU_ON    PSCI_0_2_FN64(3)
#define PSCI_0_2_FN64_AFFINITY_INFO    PSCI_0_2_FN64(4)
#define PSCI_0_2_FN64_MIGRATE    PSCI_0_2_FN64(5)
#define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU \
                    PSCI_0_2_FN64(7)

/* PSCI return values */
#define PSCI_RET_SUCCESS        0
#define PSCI_RET_NI            ((unsigned long)-1)
#define PSCI_RET_INVAL        ((unsigned long)-2)
#define PSCI_RET_DENIED        ((unsigned long)-3)
#define PSCI_RET_ALREADY_ON        ((unsigned long)-4)
#define PSCI_RET_ON_PENDING        ((unsigned long)-5)
#define PSCI_RET_INTERNAL_FAILURE    ((unsigned long)-6)
#define PSCI_RET_NOT_PRESENT    ((unsigned long)-7)
#define PSCI_RET_DISABLED        ((unsigned long)-8)

The usual headers arch/arm/include/uapi/asm/kvm.h and
arch/arm64/include/uapi/asm/kvm.h will only define
KVM_PSCI_FN_BASE for PSCI v0.1

Regards,
Anup

>
>
> Thanks,
> -Christoffer
