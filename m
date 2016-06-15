From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 15 Jun 2016 23:10:08 +0200
Subject: [PATCH v2 4/6] PM / Hibernate: Allow architectures to specify the
 hibernate/resume CPU
In-Reply-To: <1466012148-7674-5-git-send-email-james.morse@arm.com>
References: <1466012148-7674-1-git-send-email-james.morse@arm.com>
 <1466012148-7674-5-git-send-email-james.morse@arm.com>
Message-ID: <CAJZ5v0ipRONyMe15k=-FhcKEGM6kMh5Vu35XQexBr0SMYQoktQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 7:35 PM, James Morse <james.morse@arm.com> wrote:
> On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
> user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
> kernel will assign logical id 0 to a different physical CPU.
> This breaks hibernate as hibernate and resume will be attempted on different
> CPUs.
>
> Define a weak symbol arch_hibernation_disable_cpus(), which defaults to
> calling disable_nonboot_cpus). Architectures that allow CPU 0 to be
> hotplugged can use this to control which CPU is used for hibernate/resume.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> ---
> If this approach is acceptable, this patch should go with 4&5 via the arm64
> tree.

I'm not entirely happy with this, but if you absolutely need it and if
you can't think about any cleaner way to achieve the goal, feel free
to add my ACK to this patch if necessary.

>  kernel/power/hibernate.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index fca9254280ee..0e668a3207ec 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -70,6 +70,16 @@ bool hibernation_available(void)
>  }
>
>  /**
> + * arch_hibernation_disable_cpus - Allow architectures to direct which CPU
> + * is used for suspend or resume.
> + * @suspend: True during hibernate, false for resume.
> + */
> +int __weak arch_hibernation_disable_cpus(__maybe_unused bool suspend)
> +{
> +       return disable_nonboot_cpus();
> +}
> +
> +/**
>   * hibernation_set_ops - Set the global hibernate operations.
>   * @ops: Hibernation operations to use in subsequent hibernation transitions.
>   */
> @@ -279,7 +289,7 @@ static int create_image(int platform_mode)
>         if (error || hibernation_test(TEST_PLATFORM))
>                 goto Platform_finish;
>
> -       error = disable_nonboot_cpus();
> +       error = arch_hibernation_disable_cpus(true);
>         if (error || hibernation_test(TEST_CPUS))
>                 goto Enable_cpus;
>
> @@ -433,7 +443,7 @@ static int resume_target_kernel(bool platform_mode)
>         if (error)
>                 goto Cleanup;
>
> -       error = disable_nonboot_cpus();
> +       error = arch_hibernation_disable_cpus(false);
>         if (error)
>                 goto Enable_cpus;
>
> @@ -551,7 +561,7 @@ int hibernation_platform_enter(void)
>         if (error)
>                 goto Platform_finish;
>
> -       error = disable_nonboot_cpus();
> +       error = arch_hibernation_disable_cpus(true);
>         if (error)
>                 goto Enable_cpus;
>
> --
