From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 29 Aug 2014 18:39:09 +0100
Subject: [PATCH 06/16] KVM: Add KVM_EXIT_SYSTEM_EVENT to user space API
 header
In-Reply-To: <1401041942-23471-7-git-send-email-christoffer.dall@linaro.org>
References: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
 <1401041942-23471-7-git-send-email-christoffer.dall@linaro.org>
Message-ID: <CAFEAcA-yWadPiE4v7f-C1-V71=QHYLB=fzC78xhNMnNkVSJAhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2014 19:18, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> From: Anup Patel <anup.patel@linaro.org>
>
> Currently, we don't have an exit reason to notify user space about
> a system-level event (for e.g. system reset or shutdown) triggered
> by the VCPU. This patch adds exit reason KVM_EXIT_SYSTEM_EVENT for
> this purpose. We can also inform user space about the 'type' and
> architecture specific 'flags' of a system-level event using the
> kvm_run structure.
>
> This newly added KVM_EXIT_SYSTEM_EVENT will be used by KVM ARM/ARM64
> in-kernel PSCI v0.2 support to reset/shutdown VMs.

> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2740,6 +2740,21 @@ It gets triggered whenever both KVM_CAP_PPC_EPR are enabled and an
>  external interrupt has just been delivered into the guest. User space
>  should put the acknowledged interrupt vector into the 'epr' field.
>
> +               /* KVM_EXIT_SYSTEM_EVENT */
> +               struct {
> +#define KVM_SYSTEM_EVENT_SHUTDOWN       1
> +#define KVM_SYSTEM_EVENT_RESET          2
> +                       __u32 type;
> +                       __u64 flags;
> +               } system_event;
> +
> +If exit_reason is KVM_EXIT_SYSTEM_EVENT then the vcpu has triggered
> +a system-level event using some architecture specific mechanism (hypercall
> +or some special instruction). In case of ARM/ARM64, this is triggered using
> +HVC instruction based PSCI call from the vcpu. The 'type' field describes
> +the system-level event type. The 'flags' field describes architecture
> +specific flags for the system-level event.

Talking with Ard I realised that there's actually a hole in the
specification of this new ABI. Did we intend these shutdown
and reset exits to be:
 (1) requests from the guest for the shutdown/reset to be
   scheduled in the near future (and we'll continue to execute
   the guest until the shutdown actually happens)
 (2) requests for shutdown/reset right now, with no further
   guest instructions to be executed

?

As currently implemented in QEMU we get behaviour (1),
but I think the kernel PSCI implementation assumes
behaviour (2). Who's right?

thanks
-- PMM
