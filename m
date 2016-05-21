From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 May 2016 22:19:09 -0300
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <2148724.oQlEHos3jS@vostro.rjw.lan>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
Message-ID: <CAOMZO5BBXmXAJayo8YpX4eV-_rTtAoDvjf91CUhWnLV8A0mx0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Fri, May 20, 2016 at 9:56 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> If I'm not mistaken, the patch below should allow irq_work to make forward
> progress for you, so please check if it makes any difference.
....

> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -362,6 +362,7 @@ static struct policy_dbs_info *alloc_pol
>         mutex_init(&policy_dbs->timer_mutex);
>         atomic_set(&policy_dbs->work_count, 0);
>         init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
> +       policy_dbs->irq_work.flags = IRQ_WORK_LAZY;
>         INIT_WORK(&policy_dbs->work, dbs_work_handler);
>
>         /* Set policy_dbs for all CPUs, online+offline */

Running a 4.6 kernel with this patch applied allows me to reboot the
system, thanks.

'echo performance >
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor' works fine now.
