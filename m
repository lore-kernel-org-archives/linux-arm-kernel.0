From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 30 Nov 2015 11:02:06 +0530
Subject: [PATCH 4/4] cpufreq: mt8173: move resources allocation into
 ->probe()
In-Reply-To: <CAAJzSMeYKGLkVoh0_zPLpVekQpc2rR5ud9YNCPJxRaJRCNX2nQ@mail.gmail.com>
References: <CAAJzSMeYKGLkVoh0_zPLpVekQpc2rR5ud9YNCPJxRaJRCNX2nQ@mail.gmail.com>
Message-ID: <20151130053206.GL3373@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-11-15, 11:02, Ricky Liang wrote:
> On Sun, Nov 29, 2015 at 4:31 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> >         ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
> >         if (ret)
> >                 pr_err("failed to register mtk cpufreq driver\n");
> 
> I think you want "return ret;" inside the if block.

Not just that, he needs to jump to release_dvfs_info_list.

> >
> > +       return 0;
> > +
> > +release_dvfs_info_list:
> > +       list_for_each_safe(list, tmp, &dvfs_info_list) {
> > +               info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
> > +
> > +               mtk_cpu_dvfs_info_release(info);
> > +               list_del(list);
> > +               kfree(info);
> > +       }
> > +
> >         return ret;
> >  }

-- 
viresh
