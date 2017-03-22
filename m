From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 22 Mar 2017 17:52:45 +0100
Subject: [PATCH v2 06/18] arm64: arch_timer: Add infrastructure for
 multiple erratum detection methods
In-Reply-To: <a922484a-1bb0-cfd0-1996-fab026a4feae@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-7-marc.zyngier@arm.com>
 <20170322154114.GE30499@mai>
 <a922484a-1bb0-cfd0-1996-fab026a4feae@arm.com>
Message-ID: <20170322165245.GG30499@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 03:59:21PM +0000, Marc Zyngier wrote:
> [Sorry, sent too quickly]
> 

[ ... ]

> >>  struct arch_timer_erratum_workaround {
> >> -	const char *id;		/* Indicate the Erratum ID */
> >> +	enum arch_timer_erratum_match_type match_type;
> > 
> > Putting the match_fn instead will be much more simpler and the code won't
> > have to deal with ate_match_type, no ?
> 
> I'm not sure about the "much simpler" aspect. Each function is not
> necessarily standalone (see patches 8 and 13 for example, dealing with
> CPU-local defects).

Why not write always errata on a per cpu basis ? So there is no need to go
through global/local (at the timer level).

You have been probably looking at this much longer than me and perhaps I'm
missing something. However, I think we can find a way to simplify the approach. 

Give me one day to see if I'm right.

> Also, given that we have two architectures to cater for, as well as two
> firmware interfaces, it makes more sense (at least to me) to have
> something that doesn't require to define a bunch of empty stubs (we
> already have too many of them) depending on arm vs arm64, DT vs ACPI,
> errata handling enabled vs disabled.

That is a fair point.
 
> We're sidestepping this at the moment because it all lives under one
> single config option that cannot be enabled from 32bit, but I hope to
> change that.

Ok, that sounds good.

Thanks for proposing something to deal elegantly with the errata.

  -- Daniel


> > [ ... ]
> > 
> >> +static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type type,
> >> +					    void *arg)
> >> +{
> >> +	const struct arch_timer_erratum_workaround *wa;
> >> +	ate_match_fn_t match_fn = NULL;
> >> +
> >> +	if (static_branch_unlikely(&arch_timer_read_ool_enabled))
> >> +		return;
> >> +
> > 
> > Why is this check necessary ?
> 
> We don't allow cumulative workarounds at this stage. This restriction
> gets lifted (to some extent) later in the series.
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
