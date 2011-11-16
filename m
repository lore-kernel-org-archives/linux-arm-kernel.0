From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 18:45:30 -0500 (EST)
Subject: [PATCH 2/2] ARM: topdown mmap support
In-Reply-To: <4EC2EF95.4050205@gmail.com>
References: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
 <1320709421-14469-2-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1111141237080.3307@xanadu.home> <4EC15882.7070909@gmail.com>
 <alpine.LFD.2.02.1111141316440.3307@xanadu.home> <4EC2EF95.4050205@gmail.com>
Message-ID: <alpine.LFD.2.02.1111161837500.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Nov 2011, Rob Herring wrote:

> Nicolas,
> 
> On 11/14/2011 12:22 PM, Nicolas Pitre wrote:
> > On Mon, 14 Nov 2011, Rob Herring wrote:
> > 
> >> On 11/14/2011 11:41 AM, Nicolas Pitre wrote:
> >>> On Mon, 7 Nov 2011, Rob Herring wrote:
> >>>
> >>>> From: Rob Herring <rob.herring@calxeda.com>
> >>>>
> >>>> Similar to other architectures, this adds topdown mmap support in user
> >>>> process address space allocation policy. This allows mmap sizes greater
> >>>> than 2GB. This support is largely copied from MIPS and the generic
> >>>> implementations.
> >>>>
> >>>> The address space randomization is moved into arch_pick_mmap_layout.
> >>>
> >>> This is a problem by effectively weakening the randomization greatly.  
> >>> Now you get a random starting point but all mmaps are otherwise fixed 
> >>> relative to each other, whereas you had random distances between each 
> >>> mmaps before.
> >>>
> >>
> >> You mean within a single process the mmap's are not randomized? 
> > 
> > With regard to each other: not anymore with your patch.
> > 
> >> Couldn't that end up wasting a lot of virtual space if you have a lot 
> >> of mmaps?
> > 
> > That is what we have now without this patch.  The Potential for wasted 
> > space is 8 bits on a page level, i.e. 1MB max or 512 KB on average, per 
> > mmap.  I don't think this is that bad.
> > 
> 
> No one cared about or noticed this issue until recently. That is
> changing as we start to see ARM systems with more memory and I'm sure
> we'll see more issues like this. Someone may care that they get less
> memory than other 32-bit arches. Can you really trust that apps don't do
> a large number of mmaps.
> 
> >> It is aligned with other arch's and the generic implementation. The
> >> generic implementation doesn't even do randomization for legacy layouts.
> > 
> > Only x86 does complete ASLR besides ARM.
> 
> x86 does not do per mmap randomization. Here's the output of a test
> program which does 1 to 23 MB size mmaps in 1MB steps. The gap is the
> last address - current address. I'm not sure what's going on with the
> 2nd mmap gap though, but otherwise the gap matches the mmap size.

OK, after verification I agree.

> My patch exceeds 32-bit x86 functionality which does no randomization
> for legacy layouts. It matches 32-bit and 64-bit x86 for topdown layout.

I don't think we should skip randomization for the legacy layout.  
Without your patch we have only one layout and it is already randomized 
by default. There are other knobs for inhibiting randomization already.

> I'm happy to revert the legacy part of my patch, but it's a bit mute
> point as legacy is not used by default.

I'm actually wondering if we should carry a legacy layout at all on 
ARM...

Otherwise for the patch:

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
