From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 18 Apr 2016 10:28:26 +0100
Subject: [RFC PATCH 2/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-009971
In-Reply-To: <1460856741.32510.161.camel@buserror.net>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
 <1460341353-15619-3-git-send-email-oss@buserror.net>
 <570B7486.3080204@arm.com> <1460440458.32510.110.camel@buserror.net>
 <570CB04B.3090406@arm.com> <1460856741.32510.161.camel@buserror.net>
Message-ID: <5714A8BA.2070209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/16 02:32, Scott Wood wrote:
> On Tue, 2016-04-12 at 09:22 +0100, Marc Zyngier wrote:
>> On 12/04/16 06:54, Scott Wood wrote:
>>> On Mon, 2016-04-11 at 10:55 +0100, Marc Zyngier wrote:
>>>> On 11/04/16 03:22, Scott Wood wrote:
>>>>> @@ -52,6 +53,20 @@ extern bool arm_arch_timer_reread;
>>>>>  	_val; \
>>>>>  })
>>>>>  
>>>>> +#define ARCH_TIMER_TVAL_REWRITE(pv, val) do { \
>>>>> +	u64 _cnt_old, _cnt_new; \
>>>>> +	int _timeout = 200; \
>>>>> +	do { \
>>>>> +		asm volatile("mrs %0, cntvct_el0;" \
>>>>> +			     "msr cnt" pv "_tval_el0, %2;" \
>>>>> +			     "mrs %1, cntvct_el0" \
>>>>> +			     : "=&r" (_cnt_old), "=r" (_cnt_new) \
>>>>> +			     : "r" (val)); \
>>>>> +		_timeout--; \
>>>>> +	} while (_cnt_old != _cnt_new && _timeout); \
>>>>> +	WARN_ON_ONCE(!_timeout); \
>>>>> +} while (0)
>>>>> +
>>>>
>>>> Given how many times you've written that loop, I'm sure you can have a
>>>> preprocessor macro that will do the right thing.
>>>
>>> I did use a preprocessor macro.  Are you asking me to consolidate the read
>>> and
>>> write macros?  That seems like it would create a mess that's worse than an
>>> extra instance of a simple loop.
>>
>> From patch 1:
>>
>> +static __always_inline
>> +u32 arch_timer_reg_tval_reread(int access, enum arch_timer_reg reg)
>> +{
>> +	u32 val, val_new;
>> +	int timeout = 200;
>> +
>> +	do {
>> +		if (access == ARCH_TIMER_PHYS_ACCESS) {
>> +			asm volatile("mrc p15, 0, %0, c14, c2, 0;"
>> +				     "mrc p15, 0, %1, c14, c2, 0"
>> +				     : "=r" (val), "=r" (val_new));
>> +		} else if (access == ARCH_TIMER_VIRT_ACCESS) {
>> +			asm volatile("mrc p15, 0, %0, c14, c3, 0;"
>> +				     "mrc p15, 0, %1, c14, c3, 0"
>> +				     : "=r" (val), "=r" (val_new));
>> +		}
>> +		timeout--;
>> +	} while (val != val_new && timeout);
>> +
>> +	WARN_ON_ONCE(!timeout);
>> +	return val;
>> +}
>>
>> [...]
>>
>> +static __always_inline u64 arch_counter_get_cnt(int opcode, bool reread)
>>  {
>> -	u64 cval;
>> +	u64 val, val_new;
>> +	int timeout = 200;
>>
>>  	isb();
>> -	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (cval));
>> -	return cval;
>> +
>> +	if (reread) {
>> +		do {
>> +			asm volatile("mrrc p15, %2, %Q0, %R0, c14;"
>> +				     "mrrc p15, %2, %Q1, %R1, c14"
>> +				     : "=r" (val), "=r" (val_new)
>> +				     : "i" (opcode));
>> +			timeout--;
>> +		} while (val != val_new && timeout);
>> +
>> +		BUG_ON(!timeout);
>> +	} else {
>> +		asm volatile("mrrc p15, %1, %Q0, %R0, c14" : "=r" (val)
>> +			     : "i" (opcode));
>> +	}
>> +
>> +	return val;
>>  }
>>
>> [...]
>>
>> +/* QorIQ errata workarounds */
>> +#define ARCH_TIMER_REREAD(reg) ({ \
>> +	u64 _val_old, _val_new; \
>> +	int _timeout = 200; \
>> +	do { \
>> +		asm volatile("mrs %0, " reg ";" \
>> +			     "mrs %1, " reg \
>> +			     : "=r" (_val_old), "=r" (_val_new)); \
>> +		_timeout--; \
>> +	} while (_val_old != _val_new && _timeout); \
>> +	WARN_ON_ONCE(!_timeout); \
>> +	_val_old; \
>> +})
>>
>> Do you notice a pattern? You are expressing the same loop in various
>> ways (sometimes in a function, sometimes in a macro). I'm looking for a
>> loop template that encapsulates the read access. You can have a similar
>> macro for writes if you have more than a single instance.
> 
> One that covers arm and arm64?  Where would it go?

In the common code. Not anywhere else.

> If you mean one per arch, that's already the case on 64-bit (and you
> complained in response to the write macro, hence my inferring that you wanted
> read and write combined).  Two instances on 32-bit (of a fairly simple loop)
> didn't seem enough to warrant using ugly macros, but I can if you want (with
> the entire asm statement passed as a macro parameter).

One issue is that you insist on these loops being inlined. They shouldn't.
You're going to loop almost forever on this counter, so there is little
point in saving a branch. Once you've given up on that, you'll find that
you can write things in a much nicer way. Like this:

<untested>
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index fbe0ca3..55ff1d4 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -23,6 +23,7 @@
 
 #include <linux/bug.h>
 #include <linux/init.h>
+#include <linux/static_key.h>
 #include <linux/types.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -114,16 +115,27 @@ static inline u64 arch_counter_get_cntpct(void)
 	return 0;
 }
 
-static inline u64 arch_counter_get_cntvct(void)
+extern struct static_key_false arch_timer_cntvct_ool_enabled;
+extern u64 arch_counter_get_cntvct_ool(void);
+
+/* Do not call this from outside of the arch_timer driver */
+static inline u64 __arch_counter_get_cntvct(void)
 {
 	u64 cval;
-
-	isb();
 	asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
-
 	return cval;
 }
 
+static inline u64 arch_counter_get_cntvct(void)
+{
+	if (static_branch_unlikely(&arch_timer_cntvct_ool_enabled)) {
+		return arch_counter_get_cntvct_ool();
+	} else {
+		isb();
+		return __arch_counter_get_cntvct();
+	}
+}
+
 static inline int arch_timer_arch_init(void)
 {
 	return 0;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5152b38..c8a386c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -79,10 +79,30 @@ static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 
+DEFINE_STATIC_KEY_FALSE(arch_timer_cntvct_ool_enabled);
+EXPORT_SYMBOL_GPL(arch_timer_cntvct_ool_enabled);
+
 /*
  * Architected system timer support.
  */
 
+u64 arch_counter_get_cntvct_ool(void)
+{
+	u64 cval_old, cval_new;
+	int timeout = 200;
+
+	do {
+		isb();
+		cval_old = __arch_counter_get_cntvct();
+		cval_new = __arch_counter_get_cntvct();
+		timeout--;
+	} while (cval_old != cval_new && timeout);
+
+	WARN_ON_ONCE(!timeout);
+	return cval_new;
+}
+EXPORT_SYMBOL_GPL(arch_counter_get_cntvct_ool);
+
 static __always_inline
 void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
 			  struct clock_event_device *clk)
</untested>

32bit and physical counter handling should be pretty obvious.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
