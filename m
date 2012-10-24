From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 16:56:02 +0200
Subject: [PATCH 2/2] arm: mvebu: Add hardware I/O Coherency support
In-Reply-To: <5087FD91.1050803@free-electrons.com>
References: <1351065841-18654-1-git-send-email-gregory.clement@free-electrons.com>
 <1351065841-18654-3-git-send-email-gregory.clement@free-electrons.com>
 <20121024142722.46c0f456@skate>
 <5087FD91.1050803@free-electrons.com>
Message-ID: <20121024165602.631f070b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 24 Oct 2012 16:39:13 +0200, Gregory CLEMENT wrote:

> > As others said, the prefix is wrong. Since the file is named coherency,
> > maybe just "coherency_" as the prefix? Not sure, though. Shouldn't the
> > file be named coherency-armada-370-xp.c, as we have done for the irq
> > controller file? In that case, the armada_370_xp prefix would make
> > sense
> 
> I would prefer to just use coherency_ everywhere and keep the name of
> the file as is. It made sense to suffix the irq file with
> armada-370-xp because the other mvebu SoCs have their own irq
> controller. Whereas, as far as I know the coherency unit is only
> present in the Armada 370/XP.

Well your argumentation may also be seen as an argument to name it
coherency-armada-370-xp.c :-) I don't have a strong opinion on this
though, and we can always rename it later if needed.

> >>  int armada_xp_get_cpu_count(void)
> >>  {
> >>  	int reg, cnt;
> > 
> > static?
> 
> Which function?
> armada_xp_get_cpu_count and armada_370_xp_set_cpu_coherent are exported
> and moreover are not part of this patch set but the SMP one.

Ok, then maybe this function shouldn't be between the DMA operations
implementation and the bus notifier callback.

> Yes indeed code in headsmp.S and armada_xp_smp_prepare_cpus() are
> redundant we can simplify it. I will change it in the SMP series and
> for this series also.

Great, thanks!

> > Do we have a good reason for having
> > armada_370_xp_coherency_iocache_init() separate from
> > armada_370_xp_coherency_iocache_init() ? I.e, what prevents us from
> 
> No good reason because they are the same! ;)

Oops, indeed. but I see that you fixed the problem.

> But more seriously, armada_370_xp_coherency_init() is called as an
> early_init call whereas armada_370_xp_coherency_iocache_init() is called
> later by armada_370_xp_dt_init(). I have to check if we can use
> bus_register_notifier() from an early_init call or if we still need to
> call armada_370_xp_coherency_init() as an early_init call.

The early_initcall() is mandatory, see the comment on top of it:

+/* Coherency initialization have to be done before the SMP
+ * initialization of the CPUs*/
+early_initcall(armada_370_xp_coherency_init);

(BTW, there is a missing space between CPUs and the comment terminator).

So, my point was more: is it possible to register the bus notifier
as early as inside an early_initcall() callback.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
