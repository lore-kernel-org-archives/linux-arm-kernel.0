From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 23:47:49 +0100
Subject: [PATCH] ARM: Re-enable TRACE_IRQFLAGS_SUPPORT on ARMv7-M
In-Reply-To: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <20150608224749.GB7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 12:24:48AM +0200, Maxime Coquelin wrote:
> Commit cb1293e2f594 ("ARM: 8375/1: disable some options on ARMv7-M") causes
> build failure on ARMv7-M machines:
> 
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/sem.h:5:0,
>                  from include/linux/sched.h:35,
>                  from arch/arm/kernel/asm-offsets.c:14:
> include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
> include/linux/rcupdate.h:539:2: error: implicit declaration of function 'arch_irqs_disabled' [-Werror=implicit-function-declaration]
>   return preempt_count() != 0 || irqs_disabled();
>   ^

The real solution is to provide a definition _in asm-generic_ for
arch_irqs_disabled(), rather than having almost every arch doing:

static inline bool arch_irqs_disabled(void)
{
        return arch_irqs_disabled_flags(arch_local_save_flags());
}

I'm personally refusing to take a patch for ARM which adds yet another
copy of the above.  This is, after all, exactly the kind of stuff that
should be in asm-generic, or if not, in include/linux but overridable
by arch stuff.

We keep going between the two extremes of "lets push lots of stuff into
arch stuff" and "lets try to extract the common bits out of arch code".

Let's try and settle on one approach, and apply it universally.

In the mean time, I think the right answer is to drop Arnd's patch -
subsituting a randconfig build error for a useful-config build error
is not something we want to do - and even partially reverting the
patch results in randconfig build errors returning, so...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
