From: zhanzhenbo@gmail.com (steve.zhan)
Date: Fri, 28 Dec 2012 15:13:46 +0800
Subject: [PATCH 1/1] ARM: ux500:mach-ux500/cpuidle.c spinlock dis-matching
In-Reply-To: <CAKvkGKdoWxmnRbNvn_SikRhzsyyzqEC99XtSM9ZeaVGjEA_Ydw@mail.gmail.com>
References: <CAKvkGKdoWxmnRbNvn_SikRhzsyyzqEC99XtSM9ZeaVGjEA_Ydw@mail.gmail.com>
Message-ID: <CAKvkGKdyk6sDTYXPf02ihfKNbxcbU-G02+Ty2N1HYuhdThCr7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update modify.

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index b54884bd..bbe64b7 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -29,6 +29,7 @@ static inline int ux500_enter_idle(struct cpuidle_device *dev,
 {
        int this_cpu = smp_processor_id();
        bool recouple = false;
+       bool locked = false;

        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &this_cpu);

@@ -39,6 +40,8 @@ static inline int ux500_enter_idle(struct cpuidle_device *dev,
                if (!spin_trylock(&master_lock))
                        goto wfi;

+               locked = true;
+
                /* decouple the gic from the A9 cores */
                if (prcmu_gic_decouple())
                        goto out;
@@ -76,7 +79,7 @@ static inline int ux500_enter_idle(struct cpuidle_device *dev,
                /* When we switch to retention, the prcmu is in charge
                 * of recoupling the gic automatically */
                recouple = false;
-
+               locked = false;
                spin_unlock(&master_lock);
        }
 wfi:
@@ -84,10 +87,11 @@ wfi:
 out:
        atomic_dec(&master);

-       if (recouple) {
+       if (recouple)
                prcmu_gic_recouple();
+
+       if (locked)
                spin_unlock(&master_lock);
-       }

        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &this_cpu);






======
steve.




2012/12/28, steve.zhan <zhanzhenbo@gmail.com>:
> Hi Daniel,
>
>        I think we must unlock the master spinlock even
> prcmu_gic_decouple function now always return 0.
>        Could you give some infos about this?
> Thanks.
>
> diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
> index b54884bd..b0759ce 100644
> --- a/arch/arm/mach-ux500/cpuidle.c
> +++ b/arch/arm/mach-ux500/cpuidle.c
> @@ -29,6 +29,7 @@ static inline int ux500_enter_idle(struct cpuidle_device
> *dev,
>  {
>         int this_cpu = smp_processor_id();
>         bool recouple = false;
> +       bool locked = false;
>
>         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &this_cpu);
>
> @@ -39,6 +40,8 @@ static inline int ux500_enter_idle(struct cpuidle_device
> *dev,
>                 if (!spin_trylock(&master_lock))
>                         goto wfi;
>
> +               locked = true;
> +
>                 /* decouple the gic from the A9 cores */
>                 if (prcmu_gic_decouple())
>                         goto out;
> @@ -76,7 +79,7 @@ static inline int ux500_enter_idle(struct cpuidle_device
> *dev,
>                 /* When we switch to retention, the prcmu is in charge
>                  * of recoupling the gic automatically */
>                 recouple = false;
> -
> +               locked = false;
>                 spin_unlock(&master_lock);
>         }
>  wfi:
> @@ -86,7 +89,8 @@ out:
>
>         if (recouple) {
>                 prcmu_gic_recouple();
> -               spin_unlock(&master_lock);
> +               if (locked)
> +                       spin_unlock(&master_lock);
>         }
>
>         clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &this_cpu);
>
>
>
> Steve Zhan
>


-- 
Steve Zhan
