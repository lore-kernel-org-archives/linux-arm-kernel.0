From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Dec 2014 21:04:01 +0000
Subject: [PATCH v2 5/6] arm/arm64: KVM: Turn off vcpus on PSCI
 shutdown/reboot
In-Reply-To: <20141212194938.GA16855@cbox>
References: <1417641522-29056-1-git-send-email-christoffer.dall@linaro.org>
 <1417641522-29056-6-git-send-email-christoffer.dall@linaro.org>
 <548593E5.7070101@arm.com> <20141208125836.GE8936@cbox>
 <5485A553.4070607@arm.com> <20141212194938.GA16855@cbox>
Message-ID: <739325d6b59aafbfe38bf277393c39af@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-12 19:49, Christoffer Dall wrote:
> On Mon, Dec 08, 2014 at 01:19:15PM +0000, Marc Zyngier wrote:
>> On 08/12/14 12:58, Christoffer Dall wrote:
>> > On Mon, Dec 08, 2014 at 12:04:53PM +0000, Marc Zyngier wrote:
>> >> On 03/12/14 21:18, Christoffer Dall wrote:
>> >>> When a vcpu calls SYSTEM_OFF or SYSTEM_RESET with PSCI v0.2, the 
>> vcpus
>> >>> should really be turned off for the VM adhering to the 
>> suggestions in
>> >>> the PSCI spec, and it's the sane thing to do.
>> >>>
>> >>> Also, clarify the behavior and expectations for exits to user 
>> space with
>> >>> the KVM_EXIT_SYSTEM_EVENT case.
>> >>>
>> >>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> >>> ---
>> >>>  Documentation/virtual/kvm/api.txt |  9 +++++++++
>> >>>  arch/arm/kvm/psci.c               | 19 +++++++++++++++++++
>> >>>  arch/arm64/include/asm/kvm_host.h |  1 +
>> >>>  3 files changed, 29 insertions(+)
>> >>>
>> >>> diff --git a/Documentation/virtual/kvm/api.txt 
>> b/Documentation/virtual/kvm/api.txt
>> >>> index 81f1b97..228f9cf 100644
>> >>> --- a/Documentation/virtual/kvm/api.txt
>> >>> +++ b/Documentation/virtual/kvm/api.txt
>> >>> @@ -2957,6 +2957,15 @@ HVC instruction based PSCI call from the 
>> vcpu. The 'type' field describes
>> >>>  the system-level event type. The 'flags' field describes 
>> architecture
>> >>>  specific flags for the system-level event.
>> >>>
>> >>> +Valid values for 'type' are:
>> >>> +  KVM_SYSTEM_EVENT_SHUTDOWN -- the guest has requested a 
>> shutdown of the
>> >>> +   VM. Userspace is not obliged to honour this, and if it does 
>> honour
>> >>> +   this does not need to destroy the VM synchronously (ie it 
>> may call
>> >>> +   KVM_RUN again before shutdown finally occurs).
>> >>> +  KVM_SYSTEM_EVENT_RESET -- the guest has requested a reset of 
>> the VM.
>> >>> +   As with SHUTDOWN, userspace can choose to ignore the 
>> request, or
>> >>> +   to schedule the reset to occur in the future and may call 
>> KVM_RUN again.
>> >>> +
>> >>>  		/* Fix the size of the union. */
>> >>>  		char padding[256];
>> >>>  	};
>> >>> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
>> >>> index 09cf377..ae0bb91 100644
>> >>> --- a/arch/arm/kvm/psci.c
>> >>> +++ b/arch/arm/kvm/psci.c
>> >>> @@ -15,6 +15,7 @@
>> >>>   * along with this program.  If not, see 
>> <http://www.gnu.org/licenses/>.
>> >>>   */
>> >>>
>> >>> +#include <linux/preempt.h>
>> >>>  #include <linux/kvm_host.h>
>> >>>  #include <linux/wait.h>
>> >>>
>> >>> @@ -166,6 +167,24 @@ static unsigned long 
>> kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
>> >>>
>> >>>  static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 
>> type)
>> >>>  {
>> >>> +	int i;
>> >>> +	struct kvm_vcpu *tmp;
>> >>> +
>> >>> +	/*
>> >>> +	 * The KVM ABI specifies that a system event exit may call 
>> KVM_RUN
>> >>> +	 * again and may perform shutdown/reboot at a later time that 
>> when the
>> >>> +	 * actual request is made.  Since we are implementing PSCI and 
>> a
>> >>> +	 * caller of PSCI reboot and shutdown expects that the system 
>> shuts
>> >>> +	 * down or reboots immediately, let's make sure that VCPUs are 
>> not run
>> >>> +	 * after this call is handled and before the VCPUs have been
>> >>> +	 * re-initialized.
>> >>> +	 */
>> >>> +	kvm_for_each_vcpu(i, tmp, vcpu->kvm)
>> >>> +		tmp->arch.pause = true;
>> >>> +	preempt_disable();
>> >>> +	force_vm_exit(cpu_all_mask);
>> >>> +	preempt_enable();
>> >>> +
>> >>
>> >> I'm slightly uneasy about this force_vm_exit, as this is 
>> something that
>> >> is directly triggered by the guest. I suppose it is almost 
>> impossible to
>> >> find out which CPUs we're actually using...
>> >>
>> > Ah, you mean we should only IPI the CPUs that are actually running 
>> a
>> > VCPU belonging to this VM?
>> >
>> > I guess I could replace it with:
>> >
>> > 	kvm_for_each_vcpu(i, tmp, vcpu->kvm) {
>> > 		tmp->arch.pause = true;
>> > 		kvm_vcpu_kick(tmp);
>> > 	}
>>
>> Ah, that's even simpler than I thought. Yeah, looks good to me.
>>
> Can I take this as an ack and apply this series?

Yes, please go ahead.

         M.
-- 
Fast, cheap, reliable. Pick two.
