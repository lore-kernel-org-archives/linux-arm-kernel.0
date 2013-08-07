From: mhocko@suse.cz (Michal Hocko)
Date: Wed, 7 Aug 2013 10:47:16 +0200
Subject: [BUG linux-next] watchdog: build breakage for non-SMP builds
In-Reply-To: <20993.64234.352390.254920@ipc1.ka-ro>
References: <20993.64234.352390.254920@ipc1.ka-ro>
Message-ID: <20130807084716.GA8184@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 07-08-13 09:44:42, Lothar Wa?mann wrote:
> Hi,
> 
> commit 0ce6966b "watchdog: update watchdog_tresh properly" breaks
> build on non-SMP systems (more specifically: on systems where
> CONFIG_USE_GENERIC_SMP_HELPERS is not set):
> linux-next/kernel/watchdog.c: In function 'update_timers':
> linux-next/kernel/watchdog.c:522:2: error: implicit declaration of function '__smp_call_function_single' [-Werror=implicit-function-declaration]

The fix is already in the Andrew's tree so it should show up in
linux-next sometimes soon.

Sorry about the hassles.

> I guess the offending code should be guarded by an
> '#ifdef CONFIG_USE_GENERIC_SMP_HELPERS'
> like in kernel/softirq.c:
> #ifdef CONFIG_USE_GENERIC_SMP_HELPERS
> [...]
> static int __try_remote_softirq(struct call_single_data *cp, int cpu, int softirq)
> {
>         if (cpu_online(cpu)) {
>                 cp->func = remote_softirq_receive;
>                 cp->info = &softirq;
>                 cp->flags = 0;
> 
>                 __smp_call_function_single(cpu, cp, 0);
>                 return 0;
>         }
>         return 1;
> }
> #else /* CONFIG_USE_GENERIC_SMP_HELPERS */
> static int __try_remote_softirq(struct call_single_data *cp, int cpu, int softirq)
> {
>         return 1;
> }
> #endif
> 
> 
> Lothar Wa?mann
> -- 
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________

-- 
Michal Hocko
SUSE Labs
