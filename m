From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 27 Nov 2014 23:10:14 +0000
Subject: [PATCH 5/5] arm/arm64: KVM: Turn off vcpus and flush stage-2
 pgtables on sytem exit events
In-Reply-To: <1417113660-23610-6-git-send-email-christoffer.dall@linaro.org>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
 <1417113660-23610-6-git-send-email-christoffer.dall@linaro.org>
Message-ID: <CAFEAcA9hRvaWZiXOjTQP3+4B+r7h7W7oqRm6y=cxw+EJKNk-0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 November 2014 at 18:41, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> When a vcpu calls SYSTEM_OFF or SYSTEM_RESET with PSCI v0.2, the vcpus
> should really be turned off for the VM adhering to the suggestions in
> the PSCI spec, and it's the sane thing to do.
>
> Also, to ensure a coherent icache/dcache/ram situation when restarting
> with the guest MMU off, flush all stage-2 page table entries so we start
> taking aborts when the guest reboots, and flush/invalidate the necessary
> cache lines.
>
> Clarify the behavior and expectations for arm/arm64 in the
> KVM_EXIT_SYSTEM_EVENT case.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  Documentation/virtual/kvm/api.txt |  4 ++++
>  arch/arm/kvm/psci.c               | 18 ++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h |  1 +
>  3 files changed, 23 insertions(+)
>
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index fc12b4f..c67e4956 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2955,6 +2955,10 @@ HVC instruction based PSCI call from the vcpu. The 'type' field describes
>  the system-level event type. The 'flags' field describes architecture
>  specific flags for the system-level event.
>
> +In the case of ARM/ARM64, all vcpus will be powered off when requesting shutdown
> +or reset, and it is the responsibility of userspace to reinitialize the vcpus
> +using KVM_ARM_VCPU_INIT.

Heh, we're not even consistent within this patchseries about the capitalisation
of "vcpu" :-)

What happens if you try to KVM_RUN a CPU the kernel thinks is powered down?
Does the kernel just say "ok, doing nothing"?

Also, the clarification we want here should not I think be architecture
specific -- the handling of the exit system event in QEMU is in common
code. What you want to say is something like:

"Valid values for 'type' are:
  KVM_SYSTEM_EVENT_SHUTDOWN -- the guest has requested a shutdown of the
   VM. Userspace is not obliged to honour this, and if it does honour
   this does not need to destroy the VM synchronously (ie it may call
   KVM_RUN again before shutdown finally occurs).
  KVM_SYSTEM_EVENT_RESET -- the guest has requested a reset of the VM.
   As with SHUTDOWN, userspace is permitted to ignore the request, or
   to schedule the reset to occur in the future and may call KVM_RUN again."

The corollary is that it's the kernel's job to deal with any impedance
mismatch between this and whatever ABI like PSCI it's implementing, but
that's fairly obvious so doesn't really need mentioning in the docs.

(I'd like to claim that "the vcpus are powered off when requesting shutdown"
is an implementation detail of this, not part of the API. I think we can
get away with that...)

> +
>                 /* Fix the size of the union. */
>                 char padding[256];
>         };
> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> index 09cf377..b4ab613 100644
> --- a/arch/arm/kvm/psci.c
> +++ b/arch/arm/kvm/psci.c
> @@ -15,11 +15,13 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#include <linux/preempt.h>
>  #include <linux/kvm_host.h>
>  #include <linux/wait.h>
>
>  #include <asm/cputype.h>
>  #include <asm/kvm_emulate.h>
> +#include <asm/kvm_mmu.h>
>  #include <asm/kvm_psci.h>
>
>  /*
> @@ -166,6 +168,22 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
>
>  static void kvm_prepare_system_event(struct kvm_vcpu *vcpu, u32 type)
>  {
> +       int i;
> +       struct kvm_vcpu *tmp;
> +
> +       /* Stop all vcpus */
> +       kvm_for_each_vcpu(i, tmp, vcpu->kvm)
> +               tmp->arch.pause = true;
> +       preempt_disable();
> +       force_vm_exit(cpu_all_mask);
> +       preempt_enable();
> +
> +       /*
> +        * Ensure a rebooted VM will fault in RAM pages and detect if the
> +        * guest MMU is turned off and flush the caches as needed.
> +        */
> +       stage2_unmap_vm(vcpu->kvm);

It seems odd to have this unmap happen on attempted system reset/powerdown,
not on cpu init/start. (I seem to remember having this conversation on
IRC, so maybe I've just forgotten why it has to be this way...)

thanks
-- PMM
