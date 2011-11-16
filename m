From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 09:48:54 +0000
Subject: [PATCH 1/2] ARM: use cache type functions for
 arch_get_unmapped_area
In-Reply-To: <4EC2F7A6.60602@gmail.com>
References: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1111141236200.3307@xanadu.home>
 <20111114202759.GA20123@mudshark.cambridge.arm.com>
 <4EC17BEA.2050104@gmail.com> <4EC2F7A6.60602@gmail.com>
Message-ID: <20111116094853.GA4942@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 11:37:10PM +0000, Rob Herring wrote:
> On 11/14/2011 02:36 PM, Rob Herring wrote:
> > On 11/14/2011 02:27 PM, Will Deacon wrote:
> >> In the case that there is a MAP_SHARED, PROT_WRITE|PROT_EXEC mapping then
> >> explicit cache maintenance will still be required by the task writing to the
> >> page and also the task executing the written data (not to mention the
> >> synchronisation requirements). Russell confirmed this recently:
> >>
> 
> What if you have 2 tasks that are executing code from the same page?
> Perhaps it doesn't matter as the I caches are separate?

Indeed, in that case there's no problem. The only case where you might try
to use this is when you have one task writing code and another one executing
it. But in this case, the task doing the executing will need to take care of
the I-cache invalidation anyway because it could be VIVT ASID-tagged.

> >> http://lists.arm.linux.org.uk/lurker/message/20110923.193941.47decb13.en.html
> >>
> >> no amount of colouring can avoid that, so why not only bother with it when
> >> we alias on the D-side? On a coherent system it's reasonable to expect that
> >> to work across tasks, so we definitely need the colouring correction there.
> > 
> > I wasn't too sure about that, so I'll drop the i-cache part.
> > 
> 
> However, the original code and comments did check for aliasing I cache.
> So dropping I-cache check could change v6 behavior if there are any
> systems with only aliasing I cache.

It shouldn't affect correct code but I can always post this as a separate
patch if you're not happy with it.

Will
