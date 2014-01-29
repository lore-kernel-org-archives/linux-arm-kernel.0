From: olof@lixom.net (Olof Johansson)
Date: Wed, 29 Jan 2014 11:02:28 -0800
Subject: [PATCH v2 5/6] X86: remove redundant cpuidle_idle_call()
In-Reply-To: <1391017513-12995-6-git-send-email-nicolas.pitre@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-6-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAOesGMjvOkuxCopog91SAV1-gB9GaEYXpuXwhV1EJQor_pKjBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 29, 2014 at 9:45 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/x86/kernel/process.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 3fb8d95ab8..4505e2a950 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -298,10 +298,7 @@ void arch_cpu_idle_dead(void)
>   */
>  void arch_cpu_idle(void)
>  {
> -       if (cpuidle_idle_call())
> -               x86_idle();
> -       else
> -               local_irq_enable();
> +       x86_idle();

You're taking out the local_irq_enable() here but I don't see the
equivalent of adding it back in the 1/6 patch that moves the
cpuidle_idle_call() up to common code. It seems that one of the call
paths through cpuidle_idle_call() don't re-enable it on its own.

Even if this is the right thing to do, why it's OK to do so should
probably be documented in the patch description.


-Olof
