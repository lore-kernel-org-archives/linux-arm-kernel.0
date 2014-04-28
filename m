From: anup@brainfault.org (Anup Patel)
Date: Mon, 28 Apr 2014 22:43:17 +0530
Subject: [PATCH v10 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <20140428141656.GF2868@lvm>
References: <1398085206-30555-1-git-send-email-anup.patel@linaro.org>
 <1398085206-30555-3-git-send-email-anup.patel@linaro.org>
 <20140428141656.GF2868@lvm>
Message-ID: <CAAhSdy0-U_6GH25n5b6=Od2LVawEyrc8NGORCzGJwdxvVv5yVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 7:46 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Mon, Apr 21, 2014 at 06:29:56PM +0530, Anup Patel wrote:
>> We need a common place to share PSCI related defines among ARM kernel,
>> ARM64 kernel, KVM ARM/ARM64 PSCI emulation, and user space.
>>
>> We introduce uapi/linux/psci.h for this purpose. This newly added
>> header will be first used by KVM ARM/ARM64 in-kernel PSCI emulation
>> and user space (i.e. QEMU or KVMTOOL).
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>  include/uapi/linux/Kbuild |    1 +
>>  include/uapi/linux/psci.h |   85 +++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 86 insertions(+)
>>  create mode 100644 include/uapi/linux/psci.h
>>
>> diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
>> index 6929571..24e9033 100644
>> --- a/include/uapi/linux/Kbuild
>> +++ b/include/uapi/linux/Kbuild
>> @@ -317,6 +317,7 @@ header-y += ppp-ioctl.h
>>  header-y += ppp_defs.h
>>  header-y += pps.h
>>  header-y += prctl.h
>> +header-y += psci.h
>>  header-y += ptp_clock.h
>>  header-y += ptrace.h
>>  header-y += qnx4_fs.h
>> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
>> new file mode 100644
>> index 0000000..0d4a136
>> --- /dev/null
>> +++ b/include/uapi/linux/psci.h
>> @@ -0,0 +1,85 @@
>> +/*
>> + * ARM Power State and Coordination Interface (PSCI) header
>> + *
>> + * This header holds common PSCI defines and macros shared
>> + * by: ARM kernel, ARM64 kernel, KVM ARM/ARM64 and user space.
>> + *
>> + * Copyright (C) 2014 Linaro Ltd.
>> + * Author: Anup Patel <anup.patel@linaro.org>
>> + */
>> +
>> +#ifndef _UAPI_LINUX_PSCI_H
>> +#define _UAPI_LINUX_PSCI_H
>> +
>> +/*
>> + * PSCI v0.1 interface
>> + *
>> + * The PSCI v0.1 function numbers are implementation defined.
>> + *
>> + * Only PSCI return values such as: SUCCESS, NOT_SUPPORTED,
>> + * INVALID_PARAMS, and DENIED defined below are applicable
>> + * to PSCI v0.1.
>> + */
>> +
>> +/* PSCI v0.2 interface */
>> +#define PSCI_0_2_FN_BASE                     0x84000000
>> +#define PSCI_0_2_FN(n)                               (PSCI_0_2_FN_BASE + (n))
>> +#define PSCI_0_2_64BIT                               0x40000000
>> +#define PSCI_0_2_FN64_BASE                   \
>> +                                     (PSCI_0_2_FN_BASE + PSCI_0_2_64BIT)
>> +#define PSCI_0_2_FN64(n)                     (PSCI_0_2_FN64_BASE + (n))
>> +
>> +#define PSCI_0_2_FN_PSCI_VERSION             PSCI_0_2_FN(0)
>> +#define PSCI_0_2_FN_CPU_SUSPEND                      PSCI_0_2_FN(1)
>> +#define PSCI_0_2_FN_CPU_OFF                  PSCI_0_2_FN(2)
>> +#define PSCI_0_2_FN_CPU_ON                   PSCI_0_2_FN(3)
>> +#define PSCI_0_2_FN_AFFINITY_INFO            PSCI_0_2_FN(4)
>> +#define PSCI_0_2_FN_MIGRATE                  PSCI_0_2_FN(5)
>> +#define PSCI_0_2_FN_MIGRATE_INFO_TYPE                PSCI_0_2_FN(6)
>> +#define PSCI_0_2_FN_MIGRATE_INFO_UP_CPU              PSCI_0_2_FN(7)
>> +#define PSCI_0_2_FN_SYSTEM_OFF                       PSCI_0_2_FN(8)
>> +#define PSCI_0_2_FN_SYSTEM_RESET             PSCI_0_2_FN(9)
>> +
>> +#define PSCI_0_2_FN64_CPU_SUSPEND            PSCI_0_2_FN64(1)
>> +#define PSCI_0_2_FN64_CPU_ON                 PSCI_0_2_FN64(3)
>> +#define PSCI_0_2_FN64_AFFINITY_INFO          PSCI_0_2_FN64(4)
>> +#define PSCI_0_2_FN64_MIGRATE                        PSCI_0_2_FN64(5)
>> +#define PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU    PSCI_0_2_FN64(7)
>> +
>> +#define PSCI_0_2_POWER_STATE_ID_MASK         0xffff
>> +#define PSCI_0_2_POWER_STATE_ID_SHIFT                0
>> +#define PSCI_0_2_POWER_STATE_TYPE_MASK               0x1
>
> Shouldn't this be (0x1 << PSCI_0_2_POWER_STATE_TYPE_SHIFT)?
>
> That seems to be the definition of a mask in the PSCI_VERSION_MAJOR_MASK
> below, at least be consistent in this file.

This was blindly adopted from Ashwin's patchset. I kept it this way so
that it works for him. May be I should change this for consistency.

I hope this will be fine for Ashwin ??

>
>> +#define PSCI_0_2_POWER_STATE_TYPE_SHIFT              16
>> +#define PSCI_0_2_POWER_STATE_AFFL_MASK               0x3
>
> same
>
>> +#define PSCI_0_2_POWER_STATE_AFFL_SHIFT              24
>> +
>> +#define PSCI_0_2_AFFINITY_LEVEL_ON           0
>> +#define PSCI_0_2_AFFINITY_LEVEL_OFF          1
>> +#define PSCI_0_2_AFFINITY_LEVEL_ON_PENDING   2
>
> I'm confused, what do these defines signify?  I spent 10 minutes looking
> at the spec and now I think that you probably mean AFFINITY_INFO and
> that these are the possible return values?  Probably warrants a comment.

Actually, this defines represent possible states of given Affinity
Level returned
by AFFINITY_INFO command.

Sure, I will add a comment here.

>
>> +
>> +#define PSCI_0_2_TOS_UP_MIGRATE                      0
>> +#define PSCI_0_2_TOS_UP_NO_MIGRATE           1
>> +#define PSCI_0_2_TOS_MP                              2
>
> Should probably also comment that "TOS" are return values for
> MIGRATE_INFO_TYPE.

OK, I will add a comment here too.

>
>> +
>> +/* PSCI version decoding (independent of PSCI version) */
>> +#define PSCI_VERSION_MAJOR_SHIFT             16
>> +#define PSCI_VERSION_MINOR_MASK                      \
>> +             ((1U << PSCI_VERSION_MAJOR_SHIFT) - 1)
>> +#define PSCI_VERSION_MAJOR_MASK                      ~PSCI_VERSION_MINOR_MASK
>> +#define PSCI_VERSION_MAJOR(ver)                      \
>> +             (((ver) & PSCI_VERSION_MAJOR_MASK) >> PSCI_VERSION_MAJOR_SHIFT)
>> +#define PSCI_VERSION_MINOR(ver)                      \
>> +             ((ver) & PSCI_VERSION_MINOR_MASK)
>
> I find this really complicated compared to "#define MINOR_MASK 0xffff"
> and "#define MAJOR_MASK 0xffff0000" but whatever...

I had defined it this way previously but Marc Z suggested the
current method. I am fine with both ways for these defines.

>
>> +
>> +/* PSCI return values (inclusive of all PSCI versions) */
>> +#define PSCI_RET_SUCCESS                     0
>> +#define PSCI_RET_NOT_SUPPORTED                       -1
>> +#define PSCI_RET_INVALID_PARAMS                      -2
>> +#define PSCI_RET_DENIED                              -3
>> +#define PSCI_RET_ALREADY_ON                  -4
>> +#define PSCI_RET_ON_PENDING                  -5
>> +#define PSCI_RET_INTERNAL_FAILURE            -6
>> +#define PSCI_RET_NOT_PRESENT                 -7
>> +#define PSCI_RET_DISABLED                    -8
>> +
>> +#endif /* _UAPI_LINUX_PSCI_H */
>> --
>> 1.7.9.5
>>
>
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--
Anup
