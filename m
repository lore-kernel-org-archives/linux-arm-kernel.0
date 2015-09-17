From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 16:43:04 +0100
Subject: [RFC PATCH v2 3/7] arm64: alternative: Apply alternatives early
 in boot process
In-Reply-To: <55FADC0B.9080200@linaro.org>
References: <1442237181-17064-1-git-send-email-daniel.thompson@linaro.org>
 <1442237181-17064-4-git-send-email-daniel.thompson@linaro.org>
 <20150916130549.GJ28771@arm.com> <55F98FF0.7030605@linaro.org>
 <20150916162452.GN28771@arm.com> <55FABF64.3080404@linaro.org>
 <20150917140126.GE25634@arm.com> <55FADC0B.9080200@linaro.org>
Message-ID: <20150917154304.GM25634@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 04:28:11PM +0100, Daniel Thompson wrote:
> On 17/09/15 15:01, Will Deacon wrote:
> > Sorry, I'm thinking slightly ahead of myself, but the series from Suzuki
> > creates a shadow "safe" view of the ID registers in the system,
> > corresponding to the intersection of CPU features:
> >
> >    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/370386.html
> >
> > In this case, it is necessary to inspect all of the possible CPUs before
> > we can apply the patching, but as I say above, I'm prepared to make an
> > exception for NMI because I don't think we can assume a safe value anyway
> > for a system with mismatched GIC CPU interfaces. I just don't want to
> > drag all of the alternatives patching earlier as well.
> 
> Thanks. I'll take a close look at this patch set and work out how to 
> cooperate with it.

Brill, thanks.

> However I would like, if I can, to persuade you that we are making an 
> exception ARM64_HAS_SYSREG_GIC_CPUIF rather than specifically for things 
> that are NMI related.

Sure, I conflated the two above.

> AFAIK all ARMv8 cores have a GIC_CPUIF and the system either has a GICv3+
> or it doesn't so it shouldn't matter what core you check the feature on;
> it is in the nature of the feature we are detecting that it is safe to
> patch early.

I'm at all convinced that its not possible to build something with
mismatched CPU interfaces, but that's not something we can support in
Linux without significant rework of the GIC code, so we can ignore that
possibility for now.

> To some extent this is quibbling about semantics but:
> 
> 1. Treating this as a general case will put us in a good position if we
>     ever have to deal with an errata that cannot wait until the system
>     has nearly finished booting.
> 
> 2. It makes the resulting code very simple because we can just have a
>     bitmask indicating which cpufeatures we need should apply early and
>     which we apply late. That in turn means we don't have to
>     differentiate NMI alternatives from other alternatives (thus avoiding
>     a bunch of new alternative macros).
> 
> I'm not seeking any kind binding agreement from you before you see the 
> patch but if you *know* right now that you would nack something that 
> follows the above thinking then please let me know so I don't waste time 
> writing it ;-) . If you're on the fence I'll happily write the patch and 
> you can see what I think then

I don't object to the early patching if it's done on an opt-in basis for
features that (a) really need it and (b) are guaranteed to work across
the whole system for anything that Linux supports.

Deal? I think it gives you the rope you need :)

Will
