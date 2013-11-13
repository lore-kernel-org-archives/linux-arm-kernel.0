From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 13 Nov 2013 10:50:49 +0000
Subject: Physical memory start contraints in the Linux kernel (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <201311122108.01331.arnd@arndb.de>
References: <osstest-21486-mainreport@xen.org>
 <201311121939.08971.arnd@arndb.de>
 <alpine.DEB.2.02.1311121843230.26077@kaball.uk.xensource.com>
 <201311122108.01331.arnd@arndb.de>
Message-ID: <1384339849.5406.52.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-11-12 at 21:08 +0100, Arnd Bergmann wrote:
> On Tuesday 12 November 2013, Stefano Stabellini wrote:
> > On Tue, 12 Nov 2013, Arnd Bergmann wrote:
> > > On Tuesday 12 November 2013, Ian Campbell wrote:
> > > > On Tue, 2013-11-12 at 14:35 +0000, Julien Grall wrote:
> > > > > On 11/12/2013 01:37 PM, Arnd Bergmann wrote:
> > > > > > BTW, does Dom0 require an LPAE-enabled kernel or can it be a regular
> > > > > > non-LPAE ARMv6/v7 multiplatform build?
> > > > > 
> > > > > It can be both.
> > > > 
> > > > NB: v7 only, we don't do v6 at all. But yes either LPAE or regular is
> > > > fine with us.
> > > 
> > > Why not combined v6/v7 kernels for non-LPAE? I can't see a technical reason
> > > preventing you from running a Dom0 or DomU kernel that can also run on
> > > some ARMv6 platform as long as both platforms and CPUs are enabled in
> > > Kconfig.
> > 
> > Unfortunately today we can't support ARMv6.
> > From f880b67dcbdedb49453f88d2ccb1a0937b046d82:
> >    
> >     * ARMv6 does not support cmpxchg on 16-bit words that are used in the
> >       Xen grant table code, so we must ensure that Xen support is only
> >       built on ARMv7-only kernels not combined ARMv6/v7 kernels.
> 
> Ah, I must have made a mistake there. It's not strictly a bug, but I think
> it would be better to undo the dependency I added in that patch and instead
> change the Makefile to build the grant table code with -march=armv7-a:
> This is safe because we know that this code will only /run/ on v7 even
> in a combined v6/v7 kernel, but it lets us get better build coverage because
> then we will enable Xen support in an allmodconfig or allyesconfig kernel
> that today enables both v6 and v7.
> 

This seems reasonable to me if it can be made to work. e.g. the uses of
such constructs would need to be in .c files not static inlines in .h
for it not to get ugly fast. Hopefully that is the case.

Another thing to watch out for is the atomics in xchg_xen_ulong which is
used by drivers/xen/events.c and uses atomic64_xchg expecting to get
exclusive load/store instructions. it looks to me like atomic64_xchg is
the same for v6 and v7 so that is ok.

The last thing to watch out for is sync_test_bit/_test_and_set etc.
Again those look the same to me on v6 and v7.

Ian.
