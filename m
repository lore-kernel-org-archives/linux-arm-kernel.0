From: nm@ti.com (Menon, Nishanth)
Date: Thu, 19 Jul 2012 22:08:34 -0500
Subject: [PATCH 01/10] ARM: OMAP2+: PM QoS: control the power domains next
 state from the constraints
In-Reply-To: <1339686361-11526-2-git-send-email-j-pihet@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
 <1339686361-11526-2-git-send-email-j-pihet@ti.com>
Message-ID: <CAOMWX4d76EiS9tqwaWvHiCFLubaJ39EGSwwJdrpfFzmvp=iEVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 10:05 AM, Jean Pihet <jean.pihet@newoldbits.com>
wrote:
>
>
> +static int _pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm,
> +                                        long min_latency)
> +{
> +       int ret = 0, state, new_state = PWRDM_FUNC_PWRST_ON;
> +
> +       if (!pwrdm) {
> +               WARN(1, "powerdomain: %s: invalid parameter(s)",
> __func__);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Find the next supported power state with
> +        *  wakeup latency <= min_latency.
> +        * Pick the lower state if no constraint on the pwrdm
> +        *  (min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE).
> +        * Skip the states marked as unsupported (UNSUP_STATE).
> +        * If no power state found, fall back to PWRDM_FUNC_PWRST_ON.
> +        */
> +       for (state = 0x0; state < PWRDM_MAX_FUNC_PWRSTS; state++) {
> +               if ((min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE) ||
Since we search for default_value, we will endup matching OFF always,
even if it is supported
state(marked UNSUP_STATE) or not. That is not correct, even though
omap_setpwrdm_state
will check for achievable state before setting it.
> +                   ((pwrdm->wakeup_lat[state] != UNSUP_STATE) &&
> +                    (pwrdm->wakeup_lat[state] <= min_latency))) {
further instead of the ()s, can we make it simple as:
if (pwrdm->wakeup_lat[state] == UNSUP_STATE)
        continue;
if (min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE ||
     pwrdm->wakeup_lat[state] <= min_latency) {
        new_state = state;
        break;
}

> +                       new_state = state;
> +                       break;
> +               }
> +       }


Regards,
Nishanth Menon
