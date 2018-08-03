From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 03 Aug 2018 07:06:53 +0100
Subject: panic kexec broken on ARM64?
In-Reply-To: <1533224994.16128.81.camel@infradead.org>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
 <2865150f-ebca-4c6b-fc4b-93bfab5f0e91@arm.com>
 <86lgbm96dq.wl-marc.zyngier@arm.com>
 <20180703070106.GV23681@linaro.org>
 <86601wzn3h.wl-marc.zyngier@arm.com>
 <20180704084123.GC28220@linaro.org>
 <23306e9e-fec6-298d-af2d-018f63b06ab1@arm.com>
 <20180705101326.GM28220@linaro.org>
 <a95ec854-ff32-c808-befe-b2db112f6c1e@arm.com>
 <1533224994.16128.81.camel@infradead.org>
Message-ID: <86600sq8zm.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 02 Aug 2018 16:49:54 +0100,
David Woodhouse <dwmw2@infradead.org> wrote:
> 
> On Thu, 2018-07-05 at 11:19 +0100, Marc Zyngier wrote:
> > >> The criteria is "this irqchip requires a reset to be safely used in the
> > >> secondary kernel". This is a judgement call from the person writing the
> > >> driver.
> > >?
> > > This doesn't tell me anything more than "do it if you need it."
> > > So let me ask you in other words.
> > > Does gic driver need to provide a reset function?
> > > Whether yes or no, why do you think so?
> > 
> > Because I know the architecture and I can assess that it needs it. Case
> > in point: The RDs have memory tables. kexec without disabling LPIs, and
> > you end-up with memory corruption.
> > 
> > Sorry, but there is no magic bullet. You have to understand what you're
> > doing.
> 
> Remember, kexec and kdump are subtly different things.
> 
> In the case of an orderly kexec, sure you can go walking chains of
> interrupt controllers (and other devices) and nicely quiescing them.
> 
> In the kdump case it's different. You really want as few instructions
> as possible between realising you're going to panic, and entering the
> kdump kernel. You NMI? all the other cores to dump their state, and
> just GTFO.
> 
> In the kdump case you also aren't *reusing* the memory, which means
> that existing memory tables which are being accessed by hardware
> shouldn't be an issue. You can let the second kernel reset it all from
> a controlled and not-already-panicking environment.

Yes, in the kdump case, you can safely continue without experiencing
memory corruption. No, you cannot reset them, which is the whole
point. What you can do is use the LPI configuration as it is, and cope
with it (at the expense of changing memory that was under control of
the primary kernel -- let's hope you're not trying to debug
interrupt-related issues...).

See [1] which implements that and a bit more to actually support kexec
in such a configuration.

> ? Oops no NMI. Doh.

Care to help reviewing this[2]?

	M.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump

[2] https://lwn.net/Articles/755906/

-- 
Jazz is not dead, it just smell funny.
