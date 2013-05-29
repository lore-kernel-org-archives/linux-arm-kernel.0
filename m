From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 May 2013 10:08:50 +0100
Subject: VDSO for arm 32bit
In-Reply-To: <alpine.LFD.2.03.1305281415040.1918@syhkavp.arg>
References: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
 <20899.25935.838288.45383@pilspetsen.it.uu.se>
 <634BB1CFA60ED14386C17849392C3EB202E52C9E87@HICGWSEX01.ad.harman.com>
 <20130528092313.GA10474@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1305281415040.1918@syhkavp.arg>
Message-ID: <20130529090850.GB13095@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 07:19:00PM +0100, Nicolas Pitre wrote:
> On Tue, 28 May 2013, Will Deacon wrote:
> > Be careful here. I had a crack at a gtod implementation for the vectors page
> > in the past, but decided to drop it because it quickly became a maintenance
> > nightmare. Since the layout of the vectors page must be fixed (as userspace
> > jumps to the absolute addresses for the helpers), having large, complicated
> > functions (which gtod does become as you quickly start using the stack to
> > store all of the shared state with the kernel) means that you can quickly
> > back yourself into a corner where the layout of the code cannot change
> > without breaking the ABI.
> 
> Note that only the entry point is fixed.  The layout of the code is not.  
> So you may well branch anywhere else within the vector page if the code 
> is more complex than a few instructions.

Sure, it may be possible simply to have branches in the kuser slots and then
reserve a chunk at the other end of the vectors page where the actual
implementation can go.

> > On top of that, new clock types are added more often than you might think
> > (not to mention bug fixes in the implementation itself), and you end up in
> > a horrible situation where you'd end up deprecating one implementation and
> > adding gettimeofday2 or something equally nasty at a different offset.
> 
> That is equally valid for a vdso.

Sorry, I wasn't clear. My point was that you can change the layout of a vdso
without breaking anything, since the dynamic loader resolves the entry
points. It relates back to what I said above -- you need to be careful about
how you lay the stuff out in memory.

Perhaps the gtod code won't end up being that big. It's around ~500 bytes on
arm64, but that's without any stack usage. Come to think of it, is there any
reason why we can't just map an additional vectors page after the one we
currently have?

Will
