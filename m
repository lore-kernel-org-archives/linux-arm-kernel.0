From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Sep 2015 15:49:34 +0530
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <20150911101341.GN21084@n2100.arm.linux.org.uk>
References: <1768766.yu1lxjsjLL@wuerfel> <2329563.MhTbBXHVz1@wuerfel>
 <20150911082536.GL9650@linux> <3071823.f1VzTWVMmV@wuerfel>
 <20150911083806.GM9650@linux>
 <20150911093454.GK21084@n2100.arm.linux.org.uk>
 <20150911094003.GN9650@linux>
 <20150911095820.GM21084@n2100.arm.linux.org.uk>
 <20150911100916.GO9650@linux>
 <20150911101341.GN21084@n2100.arm.linux.org.uk>
Message-ID: <20150911101934.GP9650@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-09-15, 11:13, Russell King - ARM Linux wrote:
> Yes, but it's not that simple.
> 
> A module with no module_init() and no module_exit() is what's called a
> library module, which can be inserted, and later removed provided no
> other module depends on anything the library module exports.
> 
> A module with a module_init() but no module_exit() is one which can be
> inserted, but never removed.
> 
> A module with a module_init() and a module_exit() can be inserted, and
> later removed in much the same way as the library module mentioned above.
> 
> See kernel/module.c:
> 
>         /* If it has an init func, it must have an exit func to unload */
>         if (mod->init && !mod->exit) {
>                 forced = try_force_unload(flags);
>                 if (!forced) {
>                         /* This module can't be removed */
>                         ret = -EBUSY;
>                         goto out;
>                 }
>         }
> 
> and
> 
>         if (mod->init != NULL && mod->exit == NULL) {
>                 printed_something = 1;
>                 seq_puts(m, "[permanent],");
>         }

Thanks for that, really appreciate it.

And now I realize that Arnd was correct to start with :)

-- 
viresh
