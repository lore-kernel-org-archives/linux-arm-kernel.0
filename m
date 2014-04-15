From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Apr 2014 13:18:34 +0100
Subject: [PATCH v9 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <CAAhSdy2PLWy+KFTjoLAo0d65RQij30skUdB=0HCWxNLcDE0-7g@mail.gmail.com>
 (Anup Patel's message of "Tue, 15 Apr 2014 12:10:30 +0100")
References: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
 <1397542455-354-3-git-send-email-anup.patel@linaro.org>
 <87eh0y29fk.fsf@approximate.cambridge.arm.com>
 <CAAhSdy2PLWy+KFTjoLAo0d65RQij30skUdB=0HCWxNLcDE0-7g@mail.gmail.com>
Message-ID: <87zjjmyeed.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15 2014 at 12:10:30 pm BST, Anup Patel <anup@brainfault.org> wrote:
> On Tue, Apr 15, 2014 at 3:36 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Tue, Apr 15 2014 at  7:14:05 am BST, Anup Patel <anup.patel@linaro.org> wrote:
>>> We need a common place to share PSCI related defines among ARM kernel,
>>> ARM64 kernel, KVM ARM/ARM64 PSCI emulation, and user space.
>>>
>>> We introduce uapi/linux/psci.h for this purpose. This newly added
>>> header will be first used by KVM ARM/ARM64 in-kernel PSCI emulation
>>> and user space (i.e. QEMU or KVMTOOL).
>>>
>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>>> ---
>>>  include/uapi/linux/Kbuild |    1 +
>>>  include/uapi/linux/psci.h |   78 +++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 79 insertions(+)
>>>  create mode 100644 include/uapi/linux/psci.h
>>>
>>> diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
>>> index 6929571..24e9033 100644
>>> --- a/include/uapi/linux/Kbuild
>>> +++ b/include/uapi/linux/Kbuild
>>> @@ -317,6 +317,7 @@ header-y += ppp-ioctl.h
>>>  header-y += ppp_defs.h
>>>  header-y += pps.h
>>>  header-y += prctl.h
>>> +header-y += psci.h
>>>  header-y += ptp_clock.h
>>>  header-y += ptrace.h
>>>  header-y += qnx4_fs.h
>>> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
>>> new file mode 100644
>>> index 0000000..077b623
>>> --- /dev/null
>>> +++ b/include/uapi/linux/psci.h
>>> @@ -0,0 +1,78 @@
>>> +/*
>>> + * ARM Power State and Coordination Interface (PSCI) header
>>> + *
>>> + * This header holds common PSCI defines and macros shared
>>> + * by: ARM kernel, ARM64 kernel, KVM ARM/ARM64 and user space.
>>> + *
>>> + * Copyright (C) 2014 Linaro Ltd.
>>> + * Author: Anup Patel <anup.patel@linaro.org>
>>> + */
>>> +
>>> +#ifndef _UAPI_LINUX_PSCI_H
>>> +#define _UAPI_LINUX_PSCI_H
>>> +
>>> +/* PSCI v0.1 interface */
>>> +#define PSCI_FN(base, n)                     ((base) + (n))
>>> +
>>> +#define PSCI_FN_CPU_SUSPEND(base)            PSCI_FN(base, 0)
>>> +#define PSCI_FN_CPU_OFF(base)                        PSCI_FN(base, 1)
>>> +#define PSCI_FN_CPU_ON(base)                 PSCI_FN(base, 2)
>>> +#define PSCI_FN_MIGRATE(base)                        PSCI_FN(base, 3)
>>
>> For PSCI v0.1, all the function numbers are independent (the spec didn't
>> specify any number...). You cannot assume contiguous numbering.
>
> This is more like KVM recommended function numbering for PSCI v0.1.
> We were already having it in uapi/asm/kvm.h to share between KVM and
> user space so I felt this to be better place for it.
>
> Do you want me to drop these or add some comment about PSCI v0.1
> function numbering ?

Both. Add a comment saying that v0.1 function numbering is
implementation defined, and remove these defines.

>
>>
>>> +/* PSCI v0.2 interface */
>>> +#define PSCI_0_2_FN_BASE                     0x84000000
>>> +#define PSCI_0_2_FN(n)                               (PSCI_0_2_FN_BASE + (n))
>>> +#define PSCI_0_2_64BIT                               0x40000000
>>> +#define PSCI_0_2_FN64_BASE                   \
>>> +                                     (PSCI_0_2_FN_BASE + PSCI_0_2_64BIT)
>>> +#define PSCI_0_2_FN64(n)                     (PSCI_0_2_FN64_BASE + (n))
>>> +
>>> +#define PSCI_0_2_FN_PSCI_VERSION             PSCI_0_2_FN(0)
>>> +#define PSCI_0_2_FN_CPU_SUSPEND                      PSCI_0_2_FN(1)
>>> +#define PSCI_0_2_FN_CPU_OFF                  PSCI_0_2_FN(2)
>>> +#define PSCI_0_2_FN_CPU_ON                   PSCI_0_2_FN(3)
>>> +#define PSCI_0_2_FN_AFFINITY_INFO            PSCI_0_2_FN(4)
>>> +#define PSCI_0_2_FN_MIGRATE                  PSCI_0_2_FN(5)
>>> +#define PSCI_0_2_FN_MIGRATE_INFO_TYPE                PSCI_0_2_FN(6)
>>> +#define PSCI_0_2_FN_MIGRATE_INFO_UP_CPU              PSCI_0_2_FN(7)
>>> +#define PSCI_0_2_FN_SYSTEM_OFF                       PSCI_0_2_FN(8)
>>> +#define PSCI_0_2_FN_SYSTEM_RESET             PSCI_0_2_FN(9)
>>> +
>>> +#define PSCI_0_2_FN64_CPU_SUSPEND            PSCI_0_2_FN64(1)
>>> +#define PSCI_0_2_FN64_CPU_ON                 PSCI_0_2_FN64(3)
>>> +#define PSCI_0_2_FN64_AFFINITY_INFO          PSCI_0_2_FN64(4)
>>> +#define PSCI_0_2_FN64_MIGRATE                        PSCI_0_2_FN64(5)
>>> +#define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU    PSCI_0_2_FN64(7)
>>> +
>>> +#define PSCI_0_2_POWER_STATE_ID_MASK         0xffff
>>> +#define PSCI_0_2_POWER_STATE_ID_SHIFT                0
>>> +#define PSCI_0_2_POWER_STATE_TYPE_MASK               0x1
>>> +#define PSCI_0_2_POWER_STATE_TYPE_SHIFT              16
>>> +#define PSCI_0_2_POWER_STATE_AFFL_MASK               0x3
>>> +#define PSCI_0_2_POWER_STATE_AFFL_SHIFT              24
>>> +
>>> +#define PSCI_0_2_TOS_UP_MIGRATE                      0
>>> +#define PSCI_0_2_TOS_UP_NO_MIGRATE           1
>>> +#define PSCI_0_2_TOS_MP                              2
>>> +
>>> +/* PSCI version decoding (independent of PSCI version) */
>>> +#define PSCI_VERSION_MAJOR_MASK                      0xffff0000
>>> +#define PSCI_VERSION_MINOR_MASK                      0x0000ffff
>>> +#define PSCI_VERSION_MAJOR_SHIFT             16
>>
>> What about:
>>
>> #define PSCI_VERSION_MINOR_MASK ((1U << PSCI_VERSION_MAJOR_SHIFT) - 1)
>> #define PSCI_VERSION_MAJOR_MASK ~PSCI_VERSION_MINOR_MASK
>
> OK, I will update this.

Thanks,

	M.

>>
>>> +#define PSCI_VERSION_MAJOR(ver)                      \
>>> +             (((ver) & PSCI_VERSION_MAJOR_MASK) >> PSCI_VERSION_MAJOR_SHIFT)
>>> +#define PSCI_VERSION_MINOR(ver)                      \
>>> +             ((ver) & PSCI_VERSION_MINOR_MASK)
>>> +
>>> +/* PSCI return values (inclusive of all PSCI versions) */
>>> +#define PSCI_RET_SUCCESS                     0
>>> +#define PSCI_RET_NOT_SUPPORTED                       -1
>>> +#define PSCI_RET_INVALID_PARAMS                      -2
>>> +#define PSCI_RET_DENIED                              -3
>>> +#define PSCI_RET_ALREADY_ON                  -4
>>> +#define PSCI_RET_ON_PENDING                  -5
>>> +#define PSCI_RET_INTERNAL_FAILURE            -6
>>> +#define PSCI_RET_NOT_PRESENT                 -7
>>> +#define PSCI_RET_DISABLED                    -8
>>> +
>>> +#endif /* _UAPI_LINUX_PSCI_H */
>>
>> --
>> Jazz is not dead. It just smells funny.
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm at lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>
> --
> Anup
>

-- 
Jazz is not dead. It just smells funny.
