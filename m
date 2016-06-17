From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2016 16:16:59 +0200
Subject: [PATCH] arm64: Kconfig: select PM for ARCH_VEXPRESS
In-Reply-To: <5763FD58.3090300@arm.com>
References: <1466090128-24425-1-git-send-email-sudeep.holla@arm.com>
 <4148732.Pd5phtR9Qh@wuerfel> <5763FD58.3090300@arm.com>
Message-ID: <3892833.90HLNUPjM3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 17, 2016 2:38:32 PM CEST Sudeep Holla wrote:
> On 17/06/16 12:53, Arnd Bergmann wrote:
> >> The discussion on this happened on linux-pm list[1]. This is need on
> >> Juno once we introduce coresight components in the DT. With !CONFIG_PM,
> >> the board stalls on boot and hence this patch is needed. This shouldn't
> >> change any thing in the defconfig as couple of other platforms already
> >> do the same. It's needed in case all other ARCH_* configs are disabled.
> >>
> >> Without this, we need a dirty trick in the DT[2] to handle !CONFIG_PM.
> >>
> >> Can you please pick this for v4.8 ?
> >
> > Question: if AMBA cannot deal with CONFIG_PM disabled, should
> > the 'select' be done from CONFIG_ARM_AMBA instead?
> >
> 
> But few platforms using AMBA may not want PM at all.

Ok, then I just misunderstood what you meant with "the AMBA framework can't
deal with !CONFIG_PM case".

> > I also feel a little uncomfortable with just adding 'select PM', given
> > that this option is normally just implied by CONFIG_SUSPEND ||
> > CONFIG_HIBERNATE_CALLBACKS,
> 
> On that analogy, for the current requirement I would say 
> PM_GENERIC_DOMAINS should select but it just depends on PM.

Possibly, it's not entirely clear what the dependency is used for
here, or what CONFIG_PM actually means. I'm also still unsure what
aspect of CONFIG_PM you actually rely on here. Is this about the
amba_pm_runtime_suspend/amba_pm_runtime_resume operations or something
else?

> > so we might run into regressionswhen we get configurations that
> > were invalid before.
> 
> Sorry my build/config knowledge is limited, I don't understand what you
> mean by the above. I am asking just to improve my knowledge.

If today, CONFIG_PM is only set when CONFIG_PM_SLEEP is set and
we introduce a case where we have PM without PM_SLEEP, a lot of
drivers that incorrectly make the assumption that PM_SLEEP is mean
with CONFIG_PM may behave in new unexpected ways.

> > Then again  ARCH_RENESAS seems to already do this.
> 
> Yes, it was hard to find get !CONFIG_PM as many platforms select it
> directly or indirectly.

Starting from an allmodconfig build, I just needed to disable
ARCH_RENESAS, ARCH_OMAP2PLUS_TYPICAL, SUSPEND and HIBERNATE.

	Arnd
