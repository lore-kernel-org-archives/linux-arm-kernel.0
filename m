From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 3 Feb 2015 15:03:40 +0800
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <20150202223851.f30768d0.akpm@linux-foundation.org>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
 <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
 <20150203011730.GA15653@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
 <20150202223851.f30768d0.akpm@linux-foundation.org>
Message-ID: <35FD53F367049845BC99AC72306C23D1044A02027E0D@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andrew Morton [mailto:akpm at linux-foundation.org]
> Sent: Tuesday, February 03, 2015 2:39 PM
> To: Wang, Yalin
> Cc: 'Kirill A. Shutemov'; 'arnd at arndb.de'; 'linux-arch at vger.kernel.org';
> 'linux-kernel at vger.kernel.org'; 'linux at arm.linux.org.uk'; 'linux-arm-
> kernel at lists.infradead.org'
> Subject: Re: [RFC] change non-atomic bitops method
> 
> On Tue, 3 Feb 2015 13:42:45 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com>
> wrote:
> >
> > ...
> >
> > #ifdef CHECK_BEFORE_SET
> > 			if (p[i] != times)
> > #endif
> >
> > ...
> >
> > ----
> > One run on CPU0, reader thread run on CPU1,
> > Test result:
> > sudo ./cache_test
> > reader:8.426228173
> > 8.672198335
> >
> > With -DCHECK_BEFORE_SET
> > sudo ./cache_test_check
> > reader:7.537036819
> > 10.799746531
> >
> 
> You aren't measuring the right thing.  You should compare
> 
> 	if (p[i] != x)
> 		p[i] = x;
> 
> versus
> 
> 	p[i] = x;
> 
> and you should do this for two cases:
> 
> a) p[i] == x
> 
> b) p[i] != x
> 
> 
> The first code sequence will be slower when (p[i] != x) and faster when
> (p[i] == x).
> 
> 
> Next, we should instrument the kernel to work out the frequency of
> set_bit on an already-set bit.
> 
> It is only with both these ratios that we can work out whether the
> patch is a net gain.  My suspicion is that set_bit on an already-set
> bit is so rare that the patch will be a loss.
I see, let's change the test a little:
1)
	memset(p, 0, SIZE);
	if (p[i] != 0)
		p[i] = 0;  // never called

	#sudo ./cache_test_check
	6.698153838
	reader:7.529402625


2)
	memset(p, 0, SIZE);
	if (p[i] == 0)
		p[i] = 0; // always called
	#sudo ./cache_test_check
	reader:7.895421311
	9.000889973

Thanks
