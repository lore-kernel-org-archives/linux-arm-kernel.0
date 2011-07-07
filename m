From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jul 2011 18:48:37 +0300
Subject: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
In-Reply-To: <E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE34@staex7mb2.telecom.sna.samsung.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
	<4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com>
	<E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE32@staex7mb2.telecom.sna.samsung.com>
	<20110707121040.GF15815@atomide.com>
	<E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE34@staex7mb2.telecom.sna.samsung.com>
Message-ID: <20110707154834.GP15815@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Martin Fouts <mfouts@sta.samsung.com> [110707 17:26]:
> From: Tony Lindgren [tony at atomide.com]
> 
> >> * Martin Fouts <mfouts@sta.samsung.com> [110707 10:20]:
> 
> >>>From: Tony Lindgren [tony at atomide.com]
> 
> >> > If we're just doing a bunch of renames all over the place to add support
> >> > for a new processor variant, something is wrong. This is exactly the kind
> >> > of "crazy churn" Linus was complaining about. In this case the crazy churn
> >> > is "let's rename 4430 to 44XX all over the place".
> >
> >> To me, this is not 'crazy churn', but rather, correcting an earlier oversight. I did not understand Linus to say 
> >> "never fix a naming oversight", but "don't change names without a good reason."
> 
> > I think this is crazy churn. It does not fix the problem we have, which
> > is "how can we support lots of SoCs in a sane way". It just postpones
> > fixing the problem until the next SoC variant comes around. And now
> > we already have the exact same problem with both the am3505 support
> > and 4460 support.
> 
> We are looking at different aspects of the problem. "How can we support lots of SoCs in a sane way" is obviously the key problem.  I was referring to the smaller, ongoing problem that every device dependent piece of code has: "how do we best communicate what variants are supported by this code."

Heh I see :) Yes that's a problem too, we still have mach-omap2 as
the subach name..
 
> > The second problem we have here is "why does adding 4460 support depend
> > on a cosmetic clean-up patch". That dependency should not exist at all
> > as it seems the 4460 patches should work even without this patch.
> 
> I agree. Had the original submitter had the foresight to realize that the code should work for all 44xx family processors, we would have no issue at all.  Do we promulgate that oversight and introduce ambiguity about what is really supported in those files, or do we correct it?

Well sounds like we might be able to get rid of CHIP_IS in the *_data.c
files if we use SoC variant specific lists. Of course Paul might have
some other ideas here.
 
> >> It seems to me that there is also a bullet to bite here. To achieve the sort of rationalization across the arm architecture that is
> >> envisioned, inconsistencies in naming styles between platforms will have to be reconciled and resolved, lest the habit continue.
> 
> > Sure things should be fixed, but things should be fixed properly. Here
> > we are repeating the CHIP_IS flag in hundreds of places where it really
> > should be only checked once after SoC is detected. And then based on
> > that a SoC specifc list of devices can then be initialized.
> 
> Yes.  I was unclear.  I didn't mean we should duplicate the 4430 code and make small changes to it, to create nearly identical 4460 code. I only meant that the unified code that works for 4430 and 4460 should not rely on names that make it appear that one SoC is supported but not the other. I do not feel that the later is cosmetic, although I agree it can be postponed.--

I think if this clean-up is not absolutely necessary we should queue the
clean-up separately just to avoid the dependency between various patches.

Regards,

Tony
