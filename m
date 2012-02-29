From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 29 Feb 2012 09:36:56 +0100
Subject: [PATCH v6 5/9] ARM: davinci: Consolidate time keeping and irq
 enable
In-Reply-To: <1330485109-7327-6-git-send-email-rob.lee@linaro.org>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
 <1330485109-7327-6-git-send-email-rob.lee@linaro.org>
Message-ID: <CAORVsuUyOz3ZDr7iR50Qi-TiT+Ng_fUBJGJU19JpQsfe6ZpwHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Wed, Feb 29, 2012 at 4:11 AM, Robert Lee <rob.lee@linaro.org> wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> ?arch/arm/mach-davinci/cpuidle.c | ? 78 +++++++++++++++-----------------------
> ?1 files changed, 31 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
> index a30c7c5..6f457f1 100644
> --- a/arch/arm/mach-davinci/cpuidle.c
> +++ b/arch/arm/mach-davinci/cpuidle.c
...

> @@ -30,12 +31,42 @@ struct davinci_ops {
> ? ? ? ?u32 flags;
> ?};
>
> +/* Actual code that puts the SoC in different idle states */
> +static int davinci_enter_idle(struct cpuidle_device *dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct cpuidle_driver *drv,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index)
> +{
> + ? ? ? struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
> + ? ? ? struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
> +
> + ? ? ? if (ops && ops->enter)
> + ? ? ? ? ? ? ? ops->enter(ops->flags);
> +
> + ? ? ? return cpuidle_wrap_enter(dev, ?drv, index,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? cpuidle_simple_enter);
This does not look right since ops->exit will never be called.

> +
> + ? ? ? if (ops && ops->exit)
> + ? ? ? ? ? ? ? ops->exit(ops->flags);
> +
> + ? ? ? return index;
> +}
> +
...

Regards,
Jean
