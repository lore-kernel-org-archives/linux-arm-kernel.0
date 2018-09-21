From: leoyang.li@nxp.com (Li Yang)
Date: Fri, 21 Sep 2018 17:15:13 -0500
Subject: [PATCH 1/4] soc/fsl/qbman: Check if CPU is offline when
 initializing portals
In-Reply-To: <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
 <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
Message-ID: <CADRPPNQMK8sNYU23nvAdF3T_gx=VruM1ZKAcwNg6HuW6hz+Ezw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 10:09 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> From: Roy Pledge <roy.pledge@nxp.com>
>
> If the affine portal for a specific CPU is offline at boot time
> affine its interrupt to CPU 0. If the CPU is later brought online
> the hotplug handler will correctly adjust the affinity.

Although this does provide better compatibility with cpu hotplug, we
still have a problem.  You are assuming the CPU0 is always online
which is not the case for arm64.  How about not setting the affinity
and let the system decide if the dedicated CPU is offline?

>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman.c | 17 +++++++++++++----
>  drivers/soc/fsl/qbman/qman.c | 18 +++++++++++++-----
>  2 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
> index f9485cedc648..2e6e682bf16b 100644
> --- a/drivers/soc/fsl/qbman/bman.c
> +++ b/drivers/soc/fsl/qbman/bman.c
> @@ -562,10 +562,19 @@ static int bman_create_portal(struct bman_portal *portal,
>                 dev_err(c->dev, "request_irq() failed\n");
>                 goto fail_irq;
>         }
> -       if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
> -           irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> -               dev_err(c->dev, "irq_set_affinity() failed\n");
> -               goto fail_affinity;
> +       if (cpu_online(c->cpu) && c->cpu != -1 &&
> +           irq_can_set_affinity(c->irq)) {
> +               if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> +                       dev_err(c->dev, "irq_set_affinity() failed %d\n",
> +                               c->cpu);
> +                       goto fail_affinity;
> +               }
> +       } else {
> +               /* CPU is offline, direct IRQ to CPU 0 */
> +               if (irq_set_affinity(c->irq, cpumask_of(0))) {
> +                       dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
> +                       goto fail_affinity;
> +               }
>         }
>
>         /* Need RCR to be empty before continuing */
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index ecb22749df0b..7dbcb475a59c 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -935,7 +935,6 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
>                         break;
>                 udelay(1);
>         } while (--timeout);
> -
>         return timeout;
>  }
>
> @@ -1210,10 +1209,19 @@ static int qman_create_portal(struct qman_portal *portal,
>                 dev_err(c->dev, "request_irq() failed\n");
>                 goto fail_irq;
>         }
> -       if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
> -           irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> -               dev_err(c->dev, "irq_set_affinity() failed\n");
> -               goto fail_affinity;
> +       if (cpu_online(c->cpu) && c->cpu != -1 &&
> +           irq_can_set_affinity(c->irq)) {
> +               if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> +                       dev_err(c->dev, "irq_set_affinity() failed %d\n",
> +                               c->cpu);
> +                       goto fail_affinity;
> +               }
> +       } else {
> +               /* CPU is offline, direct IRQ to CPU 0 */
> +               if (irq_set_affinity(c->irq, cpumask_of(0))) {
> +                       dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
> +                       goto fail_affinity;
> +               }
>         }
>
>         /* Need EQCR to be empty before continuing */
> --
> 2.1.0
>
