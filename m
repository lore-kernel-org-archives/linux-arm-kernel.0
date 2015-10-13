From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 13 Oct 2015 17:39:15 +0200
Subject: [PATCH 13/15] arm64: kvm: Rewrite fake pgd handling
In-Reply-To: <561B838C.5090008@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
 <1442331684-28818-14-git-send-email-suzuki.poulose@arm.com>
 <20151010145227.GB29128@cbox> <561B838C.5090008@arm.com>
Message-ID: <20151013153915.GC21861@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 10:55:24AM +0100, Suzuki K. Poulose wrote:
> On 10/10/15 15:52, Christoffer Dall wrote:
> >Hi Suzuki,
> 
> Hi Christoffer,
> 
> Thanks for being patient enough to review the code :-) without much of
> the comments. I now realise there needs much more documentation than
> what I have put in already. I am taking care of this in the next
> revision already.
> 
> >I had to refresh my mind a fair bit to be able to review this, so I
> >thought it may be useful to just remind us all what the constraints of
> >this whole thing is, and make sure we agree on this:
> >
> >1. We fix the IPA max width to 40 bits
> >2. We don't support systems with a PARange smaller than 40 bits (do we
> >    check this anywhere or document this anywhere?)
> 
> AFAIT, no we don't check it anywhere. May be we should. We could plug this
> into my CPU feature infrastructure[1] and let the is_hype_mode_available()
> use the info to decide if we can support 40bit IPA ?
> 

If we support 40bit IPA or more, yes, I think that would be sane.  Or at
least put a comment somewhere, perhaps in Documenation.

> >3. We always assume we are running on a system with PARange of 40 bits
> >    and we are therefore constrained to use concatination.
> >
> >As an implication of (3) above, this code will attempt to allocate 256K
> >of physically contiguous memory for each VM on the system.  That is
> >probably ok, but I just wanted to point it out in case it raises any
> >eyebrows for other people following this thread.
> 
> Right, I will document this in a comment.
> 
> >>level:  0       1         2         3
> >>bits : [47] [46 - 36] [35 - 25] [24 - 14] [13 - 0]
> >>          ^       ^     ^
> >>          |       |     |
> >>    host entry    |     x---- stage-2 entry
> >>                  |
> >>         IPA -----x
> >
> >Isn't the stage-2 entry using bits [39:25], because you resolve
> >more than 11 bits on the initial level of lookup when you concatenate
> >tables?
> 
> Yes, the stage-2 entry is just supposed to show the entry level (2).
> 

I don't understand, the stage-2 entry level will be at bit 39, not 35?

Thanks,
-Christoffer
