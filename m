From: rob.lee@linaro.org (Rob Lee)
Date: Mon, 27 Feb 2012 09:13:59 -0600
Subject: [PATCH v5 2/9] SH: shmobile: cpuidle consolidation
In-Reply-To: <1330318063-25460-3-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-3-git-send-email-rob.lee@linaro.org>
Message-ID: <CAMXH7KHZH5wMHLOvhQe22K8+7s+yvCVtOvrNw0-ogjFArt-ZNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding sh mailing list and sh contributors I missed on the original
submission.  SH folks, full patchset submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg161596.html

Best Regards,
Rob

On Sun, Feb 26, 2012 at 10:47 PM, Robert Lee <rob.lee@linaro.org> wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> ?arch/sh/kernel/cpu/shmobile/cpuidle.c | ? 10 +++-------
> ?1 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> index 6d62eb4..1ddc876 100644
> --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
> +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> @@ -29,7 +29,6 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int index)
> ?{
> ? ? ? ?unsigned long allowed_mode = SUSP_SH_SLEEP;
> - ? ? ? ktime_t before, after;
> ? ? ? ?int requested_state = index;
> ? ? ? ?int allowed_state;
> ? ? ? ?int k;
> @@ -47,19 +46,16 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
> ? ? ? ? */
> ? ? ? ?k = min_t(int, allowed_state, requested_state);
>
> - ? ? ? before = ktime_get();
> ? ? ? ?sh_mobile_call_standby(cpuidle_mode[k]);
> - ? ? ? after = ktime_get();
> -
> - ? ? ? dev->last_residency = (int)ktime_to_ns(ktime_sub(after, before)) >> 10;
>
> ? ? ? ?return k;
> ?}
>
> ?static struct cpuidle_device cpuidle_dev;
> ?static struct cpuidle_driver cpuidle_driver = {
> - ? ? ? .name = ? ? ? ? "sh_idle",
> - ? ? ? .owner = ? ? ? ?THIS_MODULE,
> + ? ? ? .name ? ? ? ? ? ? ? ? ? = "sh_idle",
> + ? ? ? .owner ? ? ? ? ? ? ? ? ?= THIS_MODULE,
> + ? ? ? .en_core_tk_irqen ? ? ? = 1,
> ?};
>
> ?void sh_mobile_setup_cpuidle(void)
> --
> 1.7.1
>
