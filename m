From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 12 Mar 2015 15:43:40 +0000
Subject: [PATCH v2 1/6] target-arm: kvm: save/restore mp state
In-Reply-To: <1425479753-18349-2-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
 <1425479753-18349-2-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA-286NkXcSAtRpB-_UEAszSg_Fawc-7pa+OXDY8NupYhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 14:35, Alex Benn?e <alex.bennee@linaro.org> wrote:
> This adds the saving and restore of the current Multi-Processing state
> of the machine. While the KVM_GET/SET_MP_STATE API exposes a number of
> potential states for x86 we only use two for ARM. Either the process is
> running or not. We then save this state into the cpu_powered TCG state
> to avoid changing the serialisation format.
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>
> ---
> v2
>   - make mpstate field runtime dependant (kvm_enabled())
>   - drop initial KVM_CAP_MP_STATE requirement
>   - re-use cpu_powered instead of new field
>
> diff --git a/target-arm/machine.c b/target-arm/machine.c
> index 9446e5a..185f9a2 100644
> --- a/target-arm/machine.c
> +++ b/target-arm/machine.c
> @@ -161,6 +161,7 @@ static const VMStateInfo vmstate_cpsr = {
>      .put = put_cpsr,
>  };
>
> +
>  static void cpu_pre_save(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
> @@ -170,6 +171,20 @@ static void cpu_pre_save(void *opaque)
>              /* This should never fail */
>              abort();
>          }
> +#if defined CONFIG_KVM
> +        if (kvm_check_extension(CPU(cpu)->kvm_state, KVM_CAP_MP_STATE)) {
> +            struct kvm_mp_state mp_state;
> +            int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
> +            if (ret) {
> +                fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
> +                        __func__, ret, strerror(ret));
> +                abort();
> +            }
> +            cpu->powered_off =
> +                (mp_state.mp_state == KVM_MP_STATE_RUNNABLE)
> +                ? false : true;

Ternary operator to produce a true-or-false result is a bit
redundant...

> +        }
> +#endif

Why is this in pre-save/post-load rather than in the
kvm_arch_get/put_registers functions like all the other
syncing code?

-- PMM
