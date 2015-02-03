From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 3 Feb 2015 17:41:13 +0800
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <8761bjjq42.fsf@rasmusvillemoes.dk>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
 <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
 <20150203011730.GA15653@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
 <20150202223851.f30768d0.akpm@linux-foundation.org>
 <8761bjjq42.fsf@rasmusvillemoes.dk>
Message-ID: <35FD53F367049845BC99AC72306C23D1044A02027E0F@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rasmus Villemoes [mailto:linux at rasmusvillemoes.dk]
> Sent: Tuesday, February 03, 2015 5:34 PM
> To: Andrew Morton
> Cc: Wang, Yalin; 'Kirill A. Shutemov'; 'arnd at arndb.de'; 'linux-
> arch at vger.kernel.org'; 'linux-kernel at vger.kernel.org';
> 'linux at arm.linux.org.uk'; 'linux-arm-kernel at lists.infradead.org'
> Subject: Re: [RFC] change non-atomic bitops method
> 
> On Tue, Feb 03 2015, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> >
> > You aren't measuring the right thing.  You should compare
> >
> > 	if (p[i] != x)
> > 		p[i] = x;
> >
> > versus
> >
> > 	p[i] = x;
> >
> > and you should do this for two cases:
> >
> > a) p[i] == x
> >
> > b) p[i] != x
> >
> >
> > The first code sequence will be slower when (p[i] != x) and faster when
> > (p[i] == x).
> >
> >
> > Next, we should instrument the kernel to work out the frequency of
> > set_bit on an already-set bit.
> >
> > It is only with both these ratios that we can work out whether the
> > patch is a net gain.  My suspicion is that set_bit on an already-set
> > bit is so rare that the patch will be a loss.
> 
> There's also the code-bloat issue to consider (instruction cache and all
> that); the conditional versions will usually require three extra
> instructions and an extra register. Also, the cache line might already
> be dirty because of something in the surrounding code. Instruction cache
> misses and larger stack footprint (from larger register pressure) won't
> show up in a microbenchmark, so I think this needs a real-world example
> to justify.
> 
> But even if one finds some hot spot that would benefit from the
> conditional, that should simply be added explicitly there, instead of
> pessimizing every other user. (A good example of that is 358eec18243a
> ("vfs: decrapify dput(), fix cache behavior under normal load")).

Oh, thank you, it is really a very nice example.
