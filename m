From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 29 May 2013 18:47:46 +0100
Subject: VDSO for arm 32bit
In-Reply-To: <alpine.LFD.2.03.1305290955390.1918@syhkavp.arg>
References: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
 <20899.25935.838288.45383@pilspetsen.it.uu.se>
 <634BB1CFA60ED14386C17849392C3EB202E52C9E87@HICGWSEX01.ad.harman.com>
 <20130528092313.GA10474@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1305281415040.1918@syhkavp.arg>
 <20130529090850.GB13095@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1305290955390.1918@syhkavp.arg>
Message-ID: <20130529174746.GA2224@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 10:01:40AM -0400, Nicolas Pitre wrote:
> On Wed, 29 May 2013, Will Deacon wrote:
> 
> > On Tue, May 28, 2013 at 07:19:00PM +0100, Nicolas Pitre wrote:
> > > On Tue, 28 May 2013, Will Deacon wrote:
> > > > Be careful here. I had a crack at a gtod implementation for the vectors page
> > > > in the past, but decided to drop it because it quickly became a maintenance
> > > > nightmare. Since the layout of the vectors page must be fixed (as userspace
> > > > jumps to the absolute addresses for the helpers), having large, complicated
> > > > functions (which gtod does become as you quickly start using the stack to
> > > > store all of the shared state with the kernel) means that you can quickly
> > > > back yourself into a corner where the layout of the code cannot change
> > > > without breaking the ABI.
> > > 
> > > Note that only the entry point is fixed.  The layout of the code is not.  
> > > So you may well branch anywhere else within the vector page if the code 
> > > is more complex than a few instructions.
> > 
> > Sure, it may be possible simply to have branches in the kuser slots and then
> > reserve a chunk at the other end of the vectors page where the actual
> > implementation can go.
> > 
> > > > On top of that, new clock types are added more often than you might think
> > > > (not to mention bug fixes in the implementation itself), and you end up in
> > > > a horrible situation where you'd end up deprecating one implementation and
> > > > adding gettimeofday2 or something equally nasty at a different offset.
> > > 
> > > That is equally valid for a vdso.
> > 
> > Sorry, I wasn't clear. My point was that you can change the layout of a vdso
> > without breaking anything, since the dynamic loader resolves the entry
> > points. It relates back to what I said above -- you need to be careful about
> > how you lay the stuff out in memory.
> > 
> > Perhaps the gtod code won't end up being that big. It's around ~500 bytes on
> > arm64, but that's without any stack usage.
> 
> That's still fairly large.
> 
> > Come to think of it, is there any
> > reason why we can't just map an additional vectors page after the one we
> > currently have?
> 
> That certainly can be done if necessary.  Some copy_page implementations 
> do use some of the address space above the vector page for temporary 
> page mapping so some care not to create conflicts would be required.

In theory, we could have a VDSO wrapping the vectors page.  This could allow
the existing kuser helpers to be looked up by ELF symbol as well as the well-
known address.  New functions don't necessarily need to have a well-known
address at all -- they might only be visible as ELF symbols, since there is
no need to offer a backwards-compatible ABI for new functions.

Alternatively, we could have a VDSO which is separate from the vectors
page, exporting only the new functionality, with the vectors page remaining
as before.

Whether or not adding a VDSO brings enough benefit to make it worthwhile
is a separate discussion, though.

Cheers
---Dave
