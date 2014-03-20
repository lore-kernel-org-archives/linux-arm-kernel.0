From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 19:51:35 -0700
Subject: [PATCH v1 1/2] PSCI: Use DT Function ID values only for old
 versions of spec
In-Reply-To: <CAL_Jsq+XXMjZ_qCCWD7u98Tq-u4Pj+fHyupJbAov98Zs8xttKg@mail.gmail.com>
References: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
 <CAL_Jsq+XXMjZ_qCCWD7u98Tq-u4Pj+fHyupJbAov98Zs8xttKg@mail.gmail.com>
Message-ID: <CAMJs5B_4caC_zZc-FAcRLVVNJNOrXWaQ0CHgsHgxyN4jPsWung@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2014 18:25, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Mar 19, 2014 at 7:54 PM, Ashwin Chaugule
> <ashwin.chaugule@linaro.org> wrote:
>> The PSCI v0.2+ spec mandates specific values of Function IDs
>> for ARM32 and ARM64. Use DT bindings of Function IDs only
>> when using older versions. Use static values otherwise.
>> This patch also prepares the code to easily use the ACPI API
>> which is based off of PSCI v0.2+.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> ---
>>  arch/arm/include/asm/psci.h   |  15 ++++++
>>  arch/arm/kernel/psci.c        | 110 +++++++++++++++++++++++++++++++++++++-----
>>  arch/arm64/include/asm/psci.h |  12 +++++
>>  arch/arm64/kernel/psci.c      | 106 +++++++++++++++++++++++++++++++++++-----
>>  4 files changed, 218 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
>> index c4ae171..3f8ebf9 100644
>> --- a/arch/arm/include/asm/psci.h
>> +++ b/arch/arm/include/asm/psci.h
>> @@ -17,6 +17,19 @@
>>  #define PSCI_POWER_STATE_TYPE_STANDBY          0
>>  #define PSCI_POWER_STATE_TYPE_POWER_DOWN       1
>>
>> +/* PSCI Function ID's for ARM32 as per PSCI spec v0.2 */
>> +
>> +#define PSCI_ID_VERSION                                0x84000000
>> +#define PSCI_ID_CPU_SUSPEND                    0x84000001
>> +#define PSCI_ID_CPU_OFF                                0x84000002
>> +#define PSCI_ID_CPU_ON                         0x84000003
>> +#define PSCI_ID_AFFINITY_INFO          0x84000004
>> +#define PSCI_ID_CPU_MIGRATE                    0x84000005
>> +#define PSCI_ID_MIGRATE_INFO_TYPE      0x84000006
>> +#define PSCI_ID_MIGRATE_INFO_UP_CPU    0x84000007
>> +#define PSCI_ID_SYSTEM_OFF                     0x84000008
>> +#define PSCI_ID_SYSTEM_RESET           0x84000009
>
> With the KVM patches[1], this makes 4 copies of these defines in the
> kernel (and then QEMU has more). This needs to go into a common header
> under include/linux. Probably under uapi so QEMU can use. There is
> some sync of headers between the kernel and QEMU I think.
>
yep, whenever something is in kvm/next or linus/master we can run a
script in the qemu directory which updates the headers and we commit
them in qemu with a reference to the kernel commit the headers come
from.

-Christoffer
