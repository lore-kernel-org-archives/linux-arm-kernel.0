From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Feb 2018 13:12:04 +0000
Subject: [PATCH v2] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
In-Reply-To: <23d70753-a628-f2e4-84df-39e4021337f5@codeaurora.org>
References: <1519095546-24420-1-git-send-email-shankerd@codeaurora.org>
 <20180221111233.gylb6v4yxqnn6gyj@localhost>
 <23d70753-a628-f2e4-84df-39e4021337f5@codeaurora.org>
Message-ID: <20180221131203.GB7614@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 07:10:34AM -0600, Shanker Donthineni wrote:
> On 02/21/2018 05:12 AM, Catalin Marinas wrote:
> > However, my worry is that in an implementation with DIC set, we also
> > skip the DSB/ISB sequence in the invalidate_icache_by_line macro. For
> > example, in an implementation with transparent PoU, we could have:
> > 
> > 	str	<some instr>, [addr]
> > 	// no cache maintenance or barrier
> > 	br	<addr>
> > 
> 
> Thanks for pointing out the missing barriers. I think it make sense to follow
> the existing barrier semantics in order to avoid the unknown things.
>  
> > Is an ISB required between the instruction store and execution? I would
> > say yes but maybe Will has a better opinion here.
> > 
> Agree, an ISB is required especially for self-modifying code. I'll include in v3 patch. 

I'd have thought you'd need a DSB too, before the ISB.

Will
