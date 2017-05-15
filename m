From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 15 May 2017 14:31:06 +0530
Subject: [PATCH v3] arm64: perf: Ignore exclude_hv when kernel is running
 in HYP
In-Reply-To: <1493742574-25955-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1493742574-25955-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <CAFpQJXUy44-i-UbrXBS3qB2Gmk9nN3r79HHx00e13r6Bk1Q=Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

if this patch looks good, can it go in 4.12-rc2 as bug fix?
or can it be queued for 4.13?

On Tue, May 2, 2017 at 9:59 PM, Ganapatrao Kulkarni
<ganapatrao.kulkarni@cavium.com> wrote:
> commit d98ecdaca296 ("arm64: perf: Count EL2 events if the kernel is
> running in HYP") returns -EINVAL when perf system call perf_event_open is
> called with exclude_hv != exclude_kernel. This change breaks applications
> on VHE enabled ARMv8.1 platforms. The issue was observed with HHVM
> application, which calls perf_event_open with exclude_hv = 1 and
> exclude_kernel = 0.
>
> There is no separate hypervisor privilege level when VHE is enabled, the
> host kernel runs at EL2. So when VHE is enabled, we should ignore
> exclude_hv from the application. This behaviour is consistent with PowerPC
> where the exclude_hv is ignored when the hypervisor is not present and with
> x86 where this flag is ignored.
>
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>
> Changelog:
>
> V2/V3:
>  - Changes as per Will Deacon's suggestions.
>
> V1: Initial patch
>
>  arch/arm64/kernel/perf_event.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 57ae9d9..f6748c0 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -871,15 +871,17 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>
>         if (attr->exclude_idle)
>                 return -EPERM;
> -       if (is_kernel_in_hyp_mode() &&
> -           attr->exclude_kernel != attr->exclude_hv)
> -               return -EINVAL;
> +       if (is_kernel_in_hyp_mode()) {
> +               if (!attr->exclude_kernel)
> +                       config_base |= ARMV8_PMU_INCLUDE_EL2;
> +       } else {
> +               if (attr->exclude_kernel)
> +                       config_base |= ARMV8_PMU_EXCLUDE_EL1;
> +               if (!attr->exclude_hv)
> +                       config_base |= ARMV8_PMU_INCLUDE_EL2;
> +       }
>         if (attr->exclude_user)
>                 config_base |= ARMV8_PMU_EXCLUDE_EL0;
> -       if (!is_kernel_in_hyp_mode() && attr->exclude_kernel)
> -               config_base |= ARMV8_PMU_EXCLUDE_EL1;
> -       if (!attr->exclude_hv)
> -               config_base |= ARMV8_PMU_INCLUDE_EL2;
>
>         /*
>          * Install the filter into config_base as this is used to
> --
> 1.8.1.4
>

thanks
Ganapat
