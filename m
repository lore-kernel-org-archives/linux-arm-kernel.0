From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 21 Feb 2017 19:56:31 +0800
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
In-Reply-To: <6c3a2952-731b-dfae-ba22-f9d7df25d691@arm.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com> <589D6776.2010400@huawei.com>
 <6c3a2952-731b-dfae-ba22-f9d7df25d691@arm.com>
Message-ID: <58AC2AEF.1030803@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2017/2/21 3:00, Marc Zyngier wrote:
> On 10/02/17 07:10, Hanjun Guo wrote:
>> Hi Marc,
>>
>> On 2017/1/24 19:32, Marc Zyngier wrote:
>>> On 24/01/17 10:57, Mark Rutland wrote:
>>>> On Tue, Jan 24, 2017 at 06:39:51PM +0800, Hanjun Guo wrote:
>>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>>
>>>>> Add hisilicon timer specific erratum fixes.
>>>>>
>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>> ---
>>>>>  drivers/clocksource/arm_arch_timer.c | 22 ++++++++++++++++++++++
>>>>>  1 file changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>>>> index 80d6f76..3e62a09 100644
>>>>> --- a/drivers/clocksource/arm_arch_timer.c
>>>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>>>> @@ -1156,10 +1156,32 @@ struct gtdt_arch_timer_fixup {
>>>>>  	void *context;
>>>>>  };
>>>>>  
>>>>> +#ifdef CONFIG_HISILICON_ERRATUM_161010101
>>>>> +static void __init hisi_erratum_workaroud_enable(void *context)
>>>>> +{
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
>>>>> +		if (!strcmp(context, ool_workarounds[i].id)) {
>>>>> +			timer_unstable_counter_workaround = &ool_workarounds[i];
>>>>> +			static_branch_enable(&arch_timer_read_ool_enabled);
>>>>> +			pr_info("arch_timer: Enabling workaround for %s\n",
>>>>> +				timer_unstable_counter_workaround->id);
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>  /* note: this needs to be updated according to the doc of OEM ID
>>>>>   * and TABLE ID for different board.
>>>>>   */
>>>>>  static struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
>>>>> +#ifdef CONFIG_HISILICON_ERRATUM_161010101
>>>>> +	{"HISI  ", "HIP05   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>>>> +	{"HISI  ", "HIP06   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>>>> +	{"HISI  ", "HIP07   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>>>> +#endif
>>>>>  };
>>>> NAK. This duplicates logic unnecessarily (for enabling the workaround),
>>>> and (ab)uses the id, which was intended to be specific to DT (since it
>>>> is a DT property name).
>>> Agreed, that's properly revolting.
>>>
>>>> We should split the matching from the particular workaround (and
>>>> enabling thereof), so that we can go straight from ACPI match to
>>>> workaround (without having to use the DT id in this manner), and don't
>>>> have to duplicate the logic to enable the workaround.
>>>>
>>>> I believe Marc is looking at some rework in this area which may enable
>>>> this, so please wait for that to appear.
>>> Yeah, I'm implementing a semi-flexible way to add new quirk types, and
>>> the last thing I want to see is two (or more) tables describing the same
>>> thing.
>> Kindly ping, if you have patches in hand, I can test against our platforms,
>> thank you very much.
> I've just pushed out a branch based on arm64/for-next/core, plus the
> HiSi timer workaround:
>
> https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/log/?h=timers/errata-rework
>
> I'll post the patches for review once the merge window is open, but
> hopefully that should get you going.

Thank you very much! I prepared an ACPI patch based on your branch, I was
trying to reuse the "const void *id" for ACPI as well but we need to match the
oem_id, oem_table_id and oem_revision in GTDT table, so I introduced new
matching information for ACPI, please take a look if it's OK.

commit 02d531ae4a88c483db849a611bd9bf7c39d2e1bf
Author: Hanjun Guo <hanjun.guo@linaro.org>
Date:   Tue Feb 21 15:17:14 2017 +0800

    arm64: arch_timer: enable the erratums in ACPI way
   
    Match OEM information which are oem_id, oem_table_id and oem_revision
    to enable the erratum for specific platforms.
   
    Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/arch_timer.h  |  7 +++++++
 drivers/clocksource/arm_arch_timer.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 1595134..79d033c 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -22,6 +22,7 @@
 #include <asm/barrier.h>
 #include <asm/sysreg.h>
 
+#include <linux/acpi.h>
 #include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/jump_label.h>
@@ -42,6 +43,7 @@ enum arch_timer_erratum_match_type {
        ate_match_dt,
        ate_match_global_cap_id,
        ate_match_local_cap_id,
+ ate_match_acpi,
 };
 
 struct clock_event_device;
@@ -49,6 +51,11 @@ enum arch_timer_erratum_match_type {
 struct arch_timer_erratum_workaround {
        enum arch_timer_erratum_match_type match_type;
        const void *id;         /* Indicate the Erratum ID */
+#ifdef CONFIG_ACPI
+ char oem_id[ACPI_OEM_ID_SIZE + 1];
+ char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+ u32 oem_revision;
+#endif
        const char *desc_str;
        u32 (*read_cntp_tval_el0)(void);
        u32 (*read_cntv_tval_el0)(void);
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index bbd9361..82ff6e4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -363,6 +363,32 @@ bool arch_timer_check_dt_erratum(const struct arch_timer_erratum_workaround
*wa,
        return of_property_read_bool(np, wa->id);
 }
 
+#ifdef CONFIG_ACPI
+static bool
+arch_timer_check_acpi_erratum(const struct arch_timer_erratum_workaround *wa,
+                       const void *arg)
+{
+ const struct acpi_table_header *table = arg;
+
+ if (!wa->oem_id || !wa->oem_table_id)
+         return false;
+
+ if (!memcmp(wa->oem_id, table->oem_id, ACPI_OEM_ID_SIZE) &&
+     !memcmp(wa->oem_table_id, table->oem_table_id,
+             ACPI_OEM_TABLE_ID_SIZE) &&
+     wa->oem_revision == table->oem_revision) {
+         return true;
+ }
+
+ return false;
+}
+#else
+static inline bool
+arch_timer_check_acpi_erratum(const struct arch_timer_erratum_workaround *wa,
+                       const void *arg)
+{ return false; }
+#endif
+
 static
 bool arch_timer_check_global_cap_erratum(const struct arch_timer_erratum_workaround *wa,
                                         const void *arg)
@@ -440,6 +466,9 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_typ
e t
                match_fn = arch_timer_check_local_cap_erratum;
                local = true;
                break;
+ case ate_match_acpi:
+         match_fn = arch_timer_check_acpi_erratum;
+         break;
        }

        wa = arch_timer_iterate_errata(type, match_fn, arg);
@@ -1284,6 +1313,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
        /* Check for globally applicable workarounds */
        arch_timer_check_ool_workaround(ate_match_global_cap_id, NULL);
 
+ arch_timer_check_ool_workaround(ate_match_acpi, table);
+
        arch_timer_init();
        return 0;
 }

And I got compile errors for this patch [1], seems "#include <linux/acpi.h>" in
arch/arm64/include/asm/arch_timer.h triggers the problem of head
file inclusions (too early to include <linux/sched.h>?), I'm looking into it,
if you can help to take a look too, that will be great :)

Thanks
Hanjun

[1]:
In file included from ./arch/arm64/include/asm/spinlock.h:21:0,
                 from ./include/linux/spinlock.h:87,
                 from ./include/linux/seqlock.h:35,
                 from ./include/linux/time.h:5,
                 from ./include/uapi/linux/timex.h:56,
                 from ./include/linux/timex.h:56,
                 from ./include/linux/sched.h:19,
                 from arch/arm64/kernel/asm-offsets.c:21:
./arch/arm64/include/asm/compat.h: In function ?arch_compat_alloc_user_space?:
./arch/arm64/include/asm/processor.h:157:11: error: implicit declaration of function ?task_stack_page? [-Werror=implicit-function-declaration]
  ((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
           ^
./arch/arm64/include/asm/compat.h:236:57: note: in expansion of macro ?task_pt_regs?
 #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
                                                         ^
./arch/arm64/include/asm/compat.h:240:24: note: in expansion of macro ?compat_user_stack_pointer?
  return (void __user *)compat_user_stack_pointer() - len;
                        ^
./arch/arm64/include/asm/processor.h:157:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  ((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
   ^
./arch/arm64/include/asm/compat.h:236:57: note: in expansion of macro ?task_pt_regs?
 #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
                                                         ^
./arch/arm64/include/asm/compat.h:240:24: note: in expansion of macro ?compat_user_stack_pointer?
  return (void __user *)compat_user_stack_pointer() - len;
                        ^
In file included from ./include/linux/kernel.h:13:0,
                 from ./include/linux/sched.h:17,
                 from arch/arm64/kernel/asm-offsets.c:21:
./include/linux/ratelimit.h: In function ?ratelimit_state_exit?:
./include/linux/ratelimit.h:62:11: error: dereferencing pointer to incomplete type
    current->comm, rs->missed);
           ^
./include/linux/printk.h:294:37: note: in definition of macro ?pr_warning?
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                     ^
./include/linux/ratelimit.h:61:3: note: in expansion of macro ?pr_warn?
   pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
   ^
In file included from ./arch/arm64/include/asm/arch_timer.h:25:0,
                 from ./arch/arm64/include/asm/timex.h:19,
                 from ./include/linux/timex.h:65,
                 from ./include/linux/sched.h:19,
                 from arch/arm64/kernel/asm-offsets.c:21:
./include/linux/acpi.h: At top level:
./include/linux/acpi.h:604:37: warning: ?struct arch_timer_mem? declared inside parameter list
 int acpi_arch_timer_mem_init(struct arch_timer_mem *data, int *timer_count);
                                     ^
./include/linux/acpi.h:604:37: warning: its scope is only this definition or declaration, which is probably not what you want
In file included from arch/arm64/kernel/asm-offsets.c:21:0:
./include/linux/sched.h:3190:21: error: conflicting types for ?task_stack_page?
 static inline void *task_stack_page(const struct task_struct *task)
                     ^
In file included from ./arch/arm64/include/asm/spinlock.h:21:0,
                 from ./include/linux/spinlock.h:87,
                 from ./include/linux/seqlock.h:35,
                 from ./include/linux/time.h:5,
                 from ./include/uapi/linux/timex.h:56,
                 from ./include/linux/timex.h:56,
                 from ./include/linux/sched.h:19,
                 from arch/arm64/kernel/asm-offsets.c:21:
./arch/arm64/include/asm/processor.h:157:40: note: previous implicit declaration of ?task_stack_page? was here
  ((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
                                        ^
./arch/arm64/include/asm/compat.h:236:57: note: in expansion of macro ?task_pt_regs?
 #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
                                                         ^
./arch/arm64/include/asm/compat.h:240:24: note: in expansion of macro ?compat_user_stack_pointer?
  return (void __user *)compat_user_stack_pointer() - len;
                        ^
cc1: some warnings being treated as errors
make[1]: *** [arch/arm64/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
