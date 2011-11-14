From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Nov 2011 13:22:11 -0500 (EST)
Subject: [PATCH 2/2] ARM: topdown mmap support
In-Reply-To: <4EC15882.7070909@gmail.com>
References: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
 <1320709421-14469-2-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1111141237080.3307@xanadu.home> <4EC15882.7070909@gmail.com>
Message-ID: <alpine.LFD.2.02.1111141316440.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Nov 2011, Rob Herring wrote:

> On 11/14/2011 11:41 AM, Nicolas Pitre wrote:
> > On Mon, 7 Nov 2011, Rob Herring wrote:
> > 
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> Similar to other architectures, this adds topdown mmap support in user
> >> process address space allocation policy. This allows mmap sizes greater
> >> than 2GB. This support is largely copied from MIPS and the generic
> >> implementations.
> >>
> >> The address space randomization is moved into arch_pick_mmap_layout.
> > 
> > This is a problem by effectively weakening the randomization greatly.  
> > Now you get a random starting point but all mmaps are otherwise fixed 
> > relative to each other, whereas you had random distances between each 
> > mmaps before.
> > 
> 
> You mean within a single process the mmap's are not randomized? 

With regard to each other: not anymore with your patch.

> Couldn't that end up wasting a lot of virtual space if you have a lot 
> of mmaps?

That is what we have now without this patch.  The Potential for wasted 
space is 8 bits on a page level, i.e. 1MB max or 512 KB on average, per 
mmap.  I don't think this is that bad.

> It is aligned with other arch's and the generic implementation. The
> generic implementation doesn't even do randomization for legacy layouts.

Only x86 does complete ASLR besides ARM.


Nicolas
