From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 12 Aug 2014 11:32:22 +0200
Subject: [PATCH v9 2/4] arm: ARMv7  dirty page logging inital mem region
 write protect (w/no huge PUD support)
In-Reply-To: <53E95CD5.9070809@samsung.com>
References: <1406249768-25315-1-git-send-email-m.smarduch@samsung.com>
 <1406249768-25315-3-git-send-email-m.smarduch@samsung.com>
 <20140811191257.GG10550@cbox> <53E95CD5.9070809@samsung.com>
Message-ID: <20140812093222.GL10550@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 05:16:21PM -0700, Mario Smarduch wrote:
> On 08/11/2014 12:12 PM, Christoffer Dall wrote:
> > Remove the parenthesis from the subject line.
> 

I just prefer not having the "(w/no huge PUD support)" part in the patch
title.

> Hmmm have to check this don't see it my patch file.
> > 
> > On Thu, Jul 24, 2014 at 05:56:06PM -0700, Mario Smarduch wrote:
> >> Patch adds  support for initial write protection VM memlsot. This patch series
> >             ^^                                    ^
> > stray whitespace                                 of
> > 
> Need to watch out for these adds delays to review cycle.

yes, I care quite a lot about proper English, syntax, grammar and
spelling.  Reading critically through your own patch files before
mailing them out is a good exercise.  You can even consider putting them
through a spell-checker and/or configure your editor to mark double
white space, trailing white space etc.

[...]

> >> +	do {
> >> +		next = kvm_pmd_addr_end(addr, end);
> >> +		if (!pmd_none(*pmd)) {
> >> +			if (kvm_pmd_huge(*pmd)) {
> >> +				if (!kvm_s2pmd_readonly(pmd))
> >> +					kvm_set_s2pmd_readonly(pmd);
> >> +			} else
> >> +				stage2_wp_pte_range(pmd, addr, next);
> > please use a closing brace when the first part of the if-statement is a
> > multi-line block with braces, as per the CodingStyle.
> Will fix.
> >> +
> > 
> > stray blank line
> 
> Not sure how it got by checkpatch, will fix.

Not sure checkpatch will complain, but I do ;)  No big deal anyway.

> > 
> >> +		}
> >> +	} while (pmd++, addr = next, addr != end);
> >> +}
> >> +
> >> +/**
> >> +  * stage2_wp_pud_range - write protect PUD range
> >> +  * @kvm:	pointer to kvm structure
> >> +  * @pud:	pointer to pgd entry
> >         pgd
> >> +  * @addr:	range start address
> >> +  * @end:	range end address
> >> +  *
> >> +  * While walking the PUD range huge PUD pages are ignored, in the future this
> >                              range, huge PUDs are ignored.  In the future...
> >> +  * may need to be revisited. Determine how to handle huge PUDs when logging
> >> +  * of dirty pages is enabled.
> > 
> > I don't understand the last sentence?
> 
> Probably last two sentences should be combined.
> ".... to determine how to handle huge PUT...". Would that be
> clear enough?
> 
> The overall theme is what to do about PUDs - mark all pages dirty
> in the region, attempt to breakup such huge regions?
> 

I think you should just state that this is not supported and worry
about how to deal with it when it's properly supported.  The TODO below
is sufficient, so just drop all mentionings about the future in the
function description above - it's likely to be forgotten when PUDs are
in fact support anyhow.

Thanks,
-Christoffer
