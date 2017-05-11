From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 May 2017 18:53:58 +0100
Subject: [PATCHv2] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <c6dfb0da-acec-620a-dba6-71aac6efce0b@arm.com>
References: <1494514878-26878-1-git-send-email-mark.rutland@arm.com>
 <498b2e16-538a-d5ea-7843-2ebbff2007df@arm.com>
 <20170511153719.GB19626@leverpostej>
 <232510f0-115e-b2c6-022f-03efd2606d56@arm.com>
 <c6dfb0da-acec-620a-dba6-71aac6efce0b@arm.com>
Message-ID: <20170511175357.GA29929@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 05:08:19PM +0100, Marc Zyngier wrote:
> On 11/05/17 16:54, Suzuki K Poulose wrote:
> > On 11/05/17 16:37, Mark Rutland wrote:
> >> On Thu, May 11, 2017 at 04:15:38PM +0100, Suzuki K Poulose wrote:
> >>> On 11/05/17 16:01, Mark Rutland wrote:
> >>>> +static inline bool cpus_have_const_cap(int num)
> >>>> +{
> >>>> +	if (static_branch_likely(&arm64_const_caps_ready))
> >>>> +		return __cpus_have_const_cap(num);
> >>>> +	else
> >>>> +		return cpus_have_cap(num);
> >>>
> >>> We use cpus_have_const_cap() from hyp code, via has_vhe() and we could potentially
> >>> try to access unmapped kernel data from hyp if we fallback to cpus_have_cap().
> >>> However, it looks like we have already set arm64_const_caps_ready, so should not
> >>> hit it in practise. May be we could add a stricter version of the helper ?
> >>>
> >>> static inline cpus_have_const_cap_strict(int num)
> >>> {
> >>> 	BUG_ON(!static_branch_likely(&arm64_const_caps_ready);
> >>> 	return __cpus_have_const_cap(num);
> >>> }
> >>
> >> Just to check, is that the only user of cpus_have_const_cap() at hyp?
> > 
> > Uh, no we have one more, via system_supports_fpsimd() in __actvate_traps.
> 
> Indeed, and I'd definitely expect to see more of that trickling in (if
> only to deal with errata).
> 
> I'm OK with the BUG_ON version, TBH. It's not pretty, but it will be
> perfectly visible if it fires.

We can't make system_supports_fpsimd() BUG_ON(), because that will fire
the first time the boot CPU tries to switch thread, due to
fpsimd_thread_switch().

However, thinking about it, there's no risk that this code runs at hyp
before we've intialised the caps.

We initialise hyp from kvm_arch_init(), which is a module initcall. As
it's built-in, that's actually a device initcall, which happens long
after we've finalised the cpucaps.

So the v2 patch should be safe, though we can make that a little clearer
with the below, which I'll fold into v3.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 5e19165..28bf4ea 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -24,6 +24,7 @@
 
 #include <linux/types.h>
 #include <linux/kvm_types.h>
+#include <asm/cpufeature.h>
 #include <asm/kvm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmio.h>
@@ -356,8 +357,10 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 {
        /*
         * Call initialization code, and switch to the full blown
-        * HYP code.
+        * HYP code. If the cpucaps haven't been finialized yet,
+        * something has gone very wrong, and hyp will crash and burn.
         */
+       BUG_ON(!static_branch_likely(&arm64_const_caps_ready));
        __kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr);
 }
