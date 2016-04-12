From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Apr 2016 09:22:35 +0100
Subject: [RFC PATCH 2/2] ARM64: arch_timer: Work around QorIQ Erratum
 A-009971
In-Reply-To: <1460440458.32510.110.camel@buserror.net>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
 <1460341353-15619-3-git-send-email-oss@buserror.net>
 <570B7486.3080204@arm.com> <1460440458.32510.110.camel@buserror.net>
Message-ID: <570CB04B.3090406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 06:54, Scott Wood wrote:
> On Mon, 2016-04-11 at 10:55 +0100, Marc Zyngier wrote:
>> On 11/04/16 03:22, Scott Wood wrote:
>>> @@ -52,6 +53,20 @@ extern bool arm_arch_timer_reread;
>>>  	_val; \
>>>  })
>>>  
>>> +#define ARCH_TIMER_TVAL_REWRITE(pv, val) do { \
>>> +	u64 _cnt_old, _cnt_new; \
>>> +	int _timeout = 200; \
>>> +	do { \
>>> +		asm volatile("mrs %0, cntvct_el0;" \
>>> +			     "msr cnt" pv "_tval_el0, %2;" \
>>> +			     "mrs %1, cntvct_el0" \
>>> +			     : "=&r" (_cnt_old), "=r" (_cnt_new) \
>>> +			     : "r" (val)); \
>>> +		_timeout--; \
>>> +	} while (_cnt_old != _cnt_new && _timeout); \
>>> +	WARN_ON_ONCE(!_timeout); \
>>> +} while (0)
>>> +
>>
>> Given how many times you've written that loop, I'm sure you can have a
>> preprocessor macro that will do the right thing.
> 
> I did use a preprocessor macro.  Are you asking me to consolidate the read and
> write macros?  That seems like it would create a mess that's worse than an
> extra instance of a simple loop.

>From patch 1:

+static __always_inline
+u32 arch_timer_reg_tval_reread(int access, enum arch_timer_reg reg)
+{
+	u32 val, val_new;
+	int timeout = 200;
+
+	do {
+		if (access == ARCH_TIMER_PHYS_ACCESS) {
+			asm volatile("mrc p15, 0, %0, c14, c2, 0;"
+				     "mrc p15, 0, %1, c14, c2, 0"
+				     : "=r" (val), "=r" (val_new));
+		} else if (access == ARCH_TIMER_VIRT_ACCESS) {
+			asm volatile("mrc p15, 0, %0, c14, c3, 0;"
+				     "mrc p15, 0, %1, c14, c3, 0"
+				     : "=r" (val), "=r" (val_new));
+		}
+		timeout--;
+	} while (val != val_new && timeout);
+
+	WARN_ON_ONCE(!timeout);
+	return val;
+}

[...]

+static __always_inline u64 arch_counter_get_cnt(int opcode, bool reread)
 {
-	u64 cval;
+	u64 val, val_new;
+	int timeout = 200;

 	isb();
-	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (cval));
-	return cval;
+
+	if (reread) {
+		do {
+			asm volatile("mrrc p15, %2, %Q0, %R0, c14;"
+				     "mrrc p15, %2, %Q1, %R1, c14"
+				     : "=r" (val), "=r" (val_new)
+				     : "i" (opcode));
+			timeout--;
+		} while (val != val_new && timeout);
+
+		BUG_ON(!timeout);
+	} else {
+		asm volatile("mrrc p15, %1, %Q0, %R0, c14" : "=r" (val)
+			     : "i" (opcode));
+	}
+
+	return val;
 }

[...]

+/* QorIQ errata workarounds */
+#define ARCH_TIMER_REREAD(reg) ({ \
+	u64 _val_old, _val_new; \
+	int _timeout = 200; \
+	do { \
+		asm volatile("mrs %0, " reg ";" \
+			     "mrs %1, " reg \
+			     : "=r" (_val_old), "=r" (_val_new)); \
+		_timeout--; \
+	} while (_val_old != _val_new && _timeout); \
+	WARN_ON_ONCE(!_timeout); \
+	_val_old; \
+})

Do you notice a pattern? You are expressing the same loop in various
ways (sometimes in a function, sometimes in a macro). I'm looking for a
loop template that encapsulates the read access. You can have a similar
macro for writes if you have more than a single instance.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
