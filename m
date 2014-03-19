From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Wed, 19 Mar 2014 14:06:54 -0700
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <CADHgK6vLB3h0zrdpve=ZyjNu2pe1VYsGxrYgv=2C-JV37vE9tQ@mail.gmail.com>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
 <20140316070917.GA3094@arch.cereza>
 <CADHgK6s58EJyJxB-47K8w26H8ZCBFQ2zu7PGAQU9O+2g7=fPwA@mail.gmail.com>
 <20140317204410.GA1118@arch.cereza>
 <CADHgK6tHngKVZS=jo=VYt3Nt3dhiEmiWr28iDy7q_uR9goBj=Q@mail.gmail.com>
 <20140319154434.GA3488@arch.cereza>
 <CADHgK6vLB3h0zrdpve=ZyjNu2pe1VYsGxrYgv=2C-JV37vE9tQ@mail.gmail.com>
Message-ID: <CADHgK6vkwjXyJxRcOXjJpJJaR0-YR869NpPZ+CBBS8kEdE0qCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2014 13:47, Sebastian Capella <sebastian.capella@linaro.org> wrote:
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index a5f702a..d96b910 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -594,7 +594,8 @@ static void power_down(void)
>         case HIBERNATION_PLATFORM:
>                 hibernation_platform_enter();
>         case HIBERNATION_SHUTDOWN:
> -               kernel_power_off();
> +               if (pm_power_off)
> +                       kernel_power_off();
>                 break;
>  #ifdef CONFIG_SUSPEND
>         case HIBERNATION_SUSPEND:
>
>
> This follows the behavior in the reboot syscall which does it this way
> also.  I'm testing this now, and it seems work fine.  If this looks
> good, I can add it as an additional patch.

BTW, one thing I would point out is that kernel_power_off and
kernel_halt call the same notifier but with different parameters
(SYS_POWER_OFF and SYS_HALT).

If pm_power_down is null, I dont see why we'd want to notify
SYS_POWER_OFF before SYS_HALT.  With the previous change I'm assuming
there's no benefit, so please chime in if you know a reason.

Thanks,

Sebastian
