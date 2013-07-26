From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jul 2013 11:34:05 +0100
Subject: [PATCH 4/6] ARM: locks: prefetch the destination word for write
 prior to strex
In-Reply-To: <alpine.LFD.2.03.1307251622320.15022@syhkavp.arg>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-5-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307231609170.15022@syhkavp.arg>
 <20130724111841.GD11072@mudshark.cambridge.arm.com>
 <51F160EA.6030800@codeaurora.org> <51F1626C.3050008@codeaurora.org>
 <20130725174555.GK12827@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1307251622320.15022@syhkavp.arg>
Message-ID: <20130726103404.GB17886@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, Jul 25, 2013 at 09:24:48PM +0100, Nicolas Pitre wrote:
> On Thu, 25 Jul 2013, Will Deacon wrote:
> > > 
> > > Oh joy. Why is rwlock's lock member marked volatile?
> > 
> > Yeah, that was the problematic guy. However, I had to fix that anyway in
> > this patch because otherwise the definition for prefetchw when
> > !ARCH_HAS_PREFETCHW (which expands to __builtin_prefetch(x,1)) will explode.
> 
> Why not always keep ARCH_HAS_PREFETCHW defined then, and have 
> __builtin_prefetch([const volatile void *)x,1)) when we can't do better?
> 
> Or why not adding this cast to the generic definition?

Yes, I'd prefer to fix the generic definition as a separate patch. However,
I think the only case that this generates warnings is when a volatile * is
passed. If volatile is actually required, I question whether prefetching
from that location even makes sense in the first place since, in the kernel,
the keyword seems to be generally associated with IO rather than CPUs accessing
shared memory via caches.

What do you think?

Will
