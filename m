From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 23 Aug 2016 14:32:50 -0400
Subject: [PATCH -next] ARM: pxa: remove duplicated include from spitz.c
In-Reply-To: <87poozpfl0.fsf@belgarion.home>
References: <1471965498-7824-1-git-send-email-weiyj.lk@gmail.com>
 <87y43npi5l.fsf@belgarion.home>
 <5b9111f3-1c9d-f551-af06-566adceaef38@gmail.com>
 <87poozpfl0.fsf@belgarion.home>
Message-ID: <20160823183249.GE6006@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH -next] ARM: pxa: remove duplicated include from spitz.c] On 23/08/2016 (Tue 19:20) Robert Jarzmik wrote:

> Wei Yongjun <weiyj.lk@gmail.com> writes:
> 
> > Hi Robert,
> > On 08/24/2016 12:24 AM, Robert Jarzmik wrote:
> >> Wei Yongjun <weiyj.lk@gmail.com> writes:
> >>
> >>> Remove duplicated include.
> >> How so duplicated ? Can you elaborate please ?
> >>
> >> Moreover, how do you do think symbol_get() can stay in spitz.c without having
> >> this include ?
> >
> > file linux/module.h included twice as following:
> >
> > #include <linux/kernel.h>
> > #include <linux/module.h>       /* symbol_get ; symbol_put */
> > ...
> > #include <linux/module.h>
> >
> > So I think we can remove the dup include.
> 
> Ah I see it now.
> 
> What you really mean is that you want to revert 12beb346710b ("Merge tag
> 'pxa-fixes-v4.8' of https://github.com/rjarzmik/linux into randconfig-4.8"),
> because :
>  - I wasn't carefull enough at review time of
>    https://github.com/rjarzmik/linux/commit/5351ca4e70f30e0175265fbf98691528b9a4e990
>    https://github.com/rjarzmik/linux/commit/a3c747b96df66a7eb810fef45f3b9e65614712d9
>  
>  - and because Paul wasn't very carefull when we look at :
>    73017a542fd2 ("arm: fix implicit module.h users by adding it to arch/arm as
>    required.")
> 
> So all in all, I'd prefer a revert with Paul's ack please.

So if possible, please drop the duplicate module.h w/o the comment
vs. a revert.  Since it appeared as a pseudo merge and was not my
original commit anyway, this shouldn't be a problem I hope...

You can call it careless if you want, I won't be offended -- FWIW I was
juggling several different streams; one to audit and remove apparently
non-required inclusions of module.h and one to unwind the implicit gpio
inclusion presence before trying to pave the way to fixing _that_ last
minute for 4.8; it was mixing and testing the two simulatenously that
led to the removal and re-addition; which when separating out the latter
caused it to become a duplicate additon as reported above.

Not an excuse; just one of those happenstance corner cases.  I'd since
fixed the dup locally and added this to my automated testing:

   make includecheck |sort > /tmp/pre-include.txt
      <...apply all WIP patches>
   make includecheck |sort > /tmp/post-include.txt
   diff -u /tmp/pre-include.txt /tmp/post-include.txt > /tmp/inc-delta.txt
   if [ -s /tmp/inc-delta.txt ]; then
           echo redundant includes changed.
           cat /tmp/inc-delta.txt
   fi

> And this time I'll go through my pxa/for-next tree, I was a fool to
> put that in pxa/fixes.

Well, you were not a fool - the fault is mine if it belongs to anyone.
You made a sensible call based on what I wrote in the commit log.

Fortunately it is 100% harmless and if you want to clean it up locally
and do so ASAP, then no problem -- do it and consider it Ack'd.

Thanks,
Paul.
--

> 
> Cheers.
> 
> -- Robert
