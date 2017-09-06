From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 6 Sep 2017 20:32:25 +0800
Subject: [PATCH] arm64: KVM: VHE: save and restore some PSTATE bits
In-Reply-To: <31b18967-c32a-1761-7e60-15c0de28203c@arm.com>
References: <0184EA26B2509940AA629AE1405DD7F2015DF717@DGGEMA503-MBX.china.huawei.com>
 <2a5d4299-2523-aef5-7db1-f351ca66b562@arm.com>
 <e47a9304-b429-b2bd-f151-d65f1c32044c@huawei.com>
 <981d7334-8841-d3e3-0833-1aa061bf97a2@arm.com>
 <62860a85-c29c-87bb-24b7-c6e5ac6065f9@huawei.com>
 <31b18967-c32a-1761-7e60-15c0de28203c@arm.com>
Message-ID: <4456ef4e-753d-e475-db9d-e9070926a262@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/9/6 20:00, Vladimir Murzin wrote:
> On 06/09/17 11:35, gengdongjiu wrote:
>> Vladimir,
>>
>> On 2017/9/6 17:41, Vladimir Murzin wrote:
>>> Can you please elaborate on cases where PAN is not enabled?
>>
>> I mean the informal private usage, For example, he disabled the PAN dynamically to let kernel space to access the user space.
>> After he dynamic disabled the PAN, then switched to guest OS. after return to host. he found the PAN stage is modified.
>> Of cause this is not a formal usage, in our host kernel, it is always enabled, no dynamic change, but I means it may exist such cases.
>>
>>
> 
> So, in short, there is no real issue with PAN, right? What about UAO?
For the pstate.UAO, current code has issue from my test. Because after switching from guest os, it does not set pstate.UAO again.
PAN is set again in your previous patch when switch to host, but UAO is not.
If you have concern about the save/restore PSTATE bits, may be we can use below modification to fix UAO issue.

diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 9341376..c3dd761 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -21,6 +21,8 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>

+#include <asm/exec.h>

 /* Yes, this does nothing, on purpose */
 static void __hyp_text __sysreg_do_nothing(struct kvm_cpu_context *ctxt) { }

@@ -121,8 +123,13 @@ static void __hyp_text __sysreg_restore_state(struct kvm_cpu_context *ctxt)
 	write_sysreg_el1(ctxt->gp_regs.spsr[KVM_SPSR_EL1],spsr);
 }

+static void __hyp_text __sysreg_restore_state_vhe(struct kvm_cpu_context *ctxt)
+{
+    uao_thread_switch(current);
+}
+
 static hyp_alternate_select(__sysreg_call_restore_host_state,
-			    __sysreg_restore_state, __sysreg_do_nothing,
+			    __sysreg_restore_state, __sysreg_restore_state_vhe,
 			    ARM64_HAS_VIRT_HOST_EXTN);

 void __hyp_text __sysreg_restore_host_state(struct kvm_cpu_context *ctxt)


> 
> Cheers
> Vladimir
> 
> .
> 
