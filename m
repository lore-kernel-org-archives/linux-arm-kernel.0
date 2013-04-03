From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 3 Apr 2013 16:39:27 -0700
Subject: [PATCH 2/5] ARM: KVM: arch_timers: zero CNTVOFF upon return to
 host
In-Reply-To: <1364404312-4427-3-git-send-email-mark.rutland@arm.com>
References: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
 <1364404312-4427-3-git-send-email-mark.rutland@arm.com>
Message-ID: <CAEDV+gKmi16juPvQUO46eMVwtNMR+q4ce8ND_yVM4_O8iOYUXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 10:11 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> To use the virtual counters from the host, we need to ensure that
> CNTVOFF doesn't change unexpectedly. When we change to a guest, we
> replace the host's CNTVOFF, but we don't restore it when returning to
> the host.
>
> As the host sets CNTVOFF to zero, and never changes it, we can simply
> zero CNTVOFF when returning to the host. This patch adds said zeroing to
> the return to host path.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@cs.columbia.edu>
> ---
>  arch/arm/kvm/interrupts_head.S | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
> index 3c8f2f0..d43cfb5 100644
> --- a/arch/arm/kvm/interrupts_head.S
> +++ b/arch/arm/kvm/interrupts_head.S
> @@ -497,6 +497,10 @@ vcpu       .req    r0              @ vcpu pointer always in r0
>         add     r5, vcpu, r4
>         strd    r2, r3, [r5]
>
> +       @ Ensure host CNTVCT == CNTPCT
> +       mov     r2, #0
> +       mcrr    p15, 4, r2, r2, c14     @ CNTVOFF
> +
>  1:
>  #endif
>         @ Allow physical timer/counter access for the host
> --
> 1.8.1.1
>
>

looks good to me.

Merged into kvm-arm-fixes.

-Christoffer
