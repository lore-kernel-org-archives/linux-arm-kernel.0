From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 1 Mar 2011 21:57:18 -0500 (EST)
Subject: [PATCH 1/4] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <4D6DA7C3.4040609@secretlab.ca>
References: <20110228233153.24836.24176.stgit@riker>
	<20110228233327.24836.94530.stgit@riker>
	<alpine.LFD.2.00.1103010019160.10356@xanadu.home>
	<4D6DA7C3.4040609@secretlab.ca>
Message-ID: <alpine.LFD.2.00.1103012139070.9350@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Mar 2011, John Bonesio wrote:

> Comment/question below.
> 
> On 02/28/2011 10:39 PM, Nicolas Pitre wrote:
> > On Mon, 28 Feb 2011, John Bonesio wrote:
> > 
> >> @@ -288,12 +330,34 @@ wont_overwrite:
> >>  
> >>  		/*
> >>  		 * Relocate all entries in the GOT table.
> >> +		 * Bump bss entries to past image end (r10)
> >>  		 */
> >> +		sub	r5, r10, r6		@ delta of image end and _edata
> >> +		add	r5, r5, #7		@ ... rounded up to a multiple
> >> +		bic	r5, r5, #7		@ ... of 8 bytes, so misaligned
> >> +		             	 		@ ... GOT entry doesn't
> >> +		             	 		@ ... overwrite end of image
> > 
> > This is wrong. You are going to displace the .bss pointers even if they 
> > don't need that in the case where no dtb was found.  And if a dtb was 
> > found the displacement is going to be the size of the dtb _plus_ the 
> > size of the .bss_stack instead of only the dtb size.
> > 
> > At this point you should only keep track of the .bss displacement in 
> > addition to the delta offset in r0.  And if both are equal to zero then 
> > skip over the fixup loop as before.
> 
> Maybe I'm not understanding correctly. I think that if there is an
> appended dtb, then there are sections like the code and data that needs
> to be adjusted by the old r0 value, while the bss and the stack need to
> be adjusted by the old r0 + dtb size.

Exact.

> If my understanding is right, then we can't just add the dtb size to r0
> and adjust everything.

indeed.

> Am I missing something?

Suppose that no dtb was found.  In that case, r10 is still pointing to 
the top of the stack.  So r5 will contain the size of .bss and the 
stack.  Then you bump .bss pointers in the GOT by that size.  If a dtb 
was found then r5 ends up with the size of the dtb plus .bss plus stack.

What I'm suggesting is that the size of the dtb be kept in a register of 
its own up to this point.  That size can be 0 if none was found.  If
r0 == 0 and dtb_size == 0 then the whole GOT fixup can be skipped as it 
is done at the moment by branching to not_relocated.


Nicolas
