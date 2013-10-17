From: anup@brainfault.org (Anup Patel)
Date: Thu, 17 Oct 2013 10:38:47 +0530
Subject: [RFC PATCH 4/5] ARM: psci: Add support for system reboot and
 poweroff
In-Reply-To: <525F1074.8000208@gmail.com>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-5-git-send-email-anup.patel@linaro.org>
 <525F1074.8000208@gmail.com>
Message-ID: <CAAhSdy3VdRnuGEMzeDrAigkD=FM+rp4VL9yC+QVaRaJRAbEunQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 3:47 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 10/16/2013 12:02 PM, Anup Patel wrote:
>> We have PSCI SYSTEM_OFF and SYSTEM_RESET function call emulation
>> available when running as Guest using KVM ARM.
>>
>> This patch implements system reboot and poweroff using PSCI
>> SYSTEM_OFF and SYSTEM_RESET.
>
> I've done a similar patch [1] which also needs binding documentation to
> go with it. The last version of which there is no agreement on is here [2].
>
> Rob
>
> [1] http://www.spinics.net/lists/arm-kernel/msg262217.html
> [2] http://www.spinics.net/lists/devicetree/msg05348.html

Thanks, for the early warning.

I would be happy to go with your patch since you have already the device tree
bindings covered.

IMHO, we should try to go ahead with existing scheme of PSCI device tree
bindings for SYSTEM_OFF and SYSTEM_RESET. Later anyone can propose
revised PSCI device tree bindings. Its not nice to hold off good changes just
because people don't agree on the device tree bindings.

Also, are you planning to revise the device tree bindings for PSCI ?

--
Anup

>
>>
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  arch/arm/kernel/psci.c |   36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
>> index 4693188..30d9d65 100644
>> --- a/arch/arm/kernel/psci.c
>> +++ b/arch/arm/kernel/psci.c
>> @@ -17,11 +17,13 @@
>>
>>  #include <linux/init.h>
>>  #include <linux/of.h>
>> +#include <linux/pm.h>
>>
>>  #include <asm/compiler.h>
>>  #include <asm/errno.h>
>>  #include <asm/opcodes-sec.h>
>>  #include <asm/opcodes-virt.h>
>> +#include <asm/system_misc.h>
>>  #include <asm/psci.h>
>>
>>  struct psci_operations psci_ops;
>> @@ -33,6 +35,8 @@ enum psci_function {
>>       PSCI_FN_CPU_ON,
>>       PSCI_FN_CPU_OFF,
>>       PSCI_FN_MIGRATE,
>> +     PSCI_FN_SYSTEM_OFF,
>> +     PSCI_FN_SYSTEM_RESET,
>>       PSCI_FN_MAX,
>>  };
>>
>> @@ -153,6 +157,28 @@ static int psci_migrate(unsigned long cpuid)
>>       return psci_to_linux_errno(err);
>>  }
>>
>> +static void psci_power_off(void)
>> +{
>> +     int err;
>> +     u32 fn;
>> +
>> +     fn = psci_function_id[PSCI_FN_SYSTEM_OFF];
>> +     err = invoke_psci_fn(fn, 0, 0, 0);
>> +     if (err)
>> +             pr_warning("%s: failed\n", __func__);
>> +}
>> +
>> +static void psci_restart(enum reboot_mode reboot_mode, const char *cmd)
>> +{
>> +     int err;
>> +     u32 fn;
>> +
>> +     fn = psci_function_id[PSCI_FN_SYSTEM_RESET];
>> +     err = invoke_psci_fn(fn, 0, 0, 0);
>> +     if (err)
>> +             pr_warning("%s: failed\n", __func__);
>> +}
>> +
>>  static const struct of_device_id psci_of_match[] __initconst = {
>>       { .compatible = "arm,psci",     },
>>       {},
>> @@ -204,6 +230,16 @@ void __init psci_init(void)
>>               psci_ops.migrate = psci_migrate;
>>       }
>>
>> +     if (!of_property_read_u32(np, "system_off", &id)) {
>> +             psci_function_id[PSCI_FN_SYSTEM_OFF] = id;
>> +             pm_power_off = psci_power_off;
>> +     }
>> +
>> +     if (!of_property_read_u32(np, "system_reset", &id)) {
>> +             psci_function_id[PSCI_FN_SYSTEM_RESET] = id;
>> +             arm_pm_restart = psci_restart;
>> +     }
>> +
>>  out_put_node:
>>       of_node_put(np);
>>       return;
>>
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
