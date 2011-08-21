From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 21 Aug 2011 18:00:42 -0400 (EDT)
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting DEBUG_LL
	UART
In-Reply-To: <20110821212921.GD19678@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
	<20110821192242.GB19678@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211557440.20358@xanadu.home>
	<20110821205441.GC19678@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211658340.20358@xanadu.home>
	<20110821212921.GD19678@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1108211747110.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:

> On Sun, Aug 21, 2011 at 05:00:46PM -0400, Nicolas Pitre wrote:
> > On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:
> > 
> > > On Sun, Aug 21, 2011 at 04:07:37PM -0400, Nicolas Pitre wrote:
> > > > On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:
> > > > 
> > > > > And further to this, I'll point out that the debugging functions are
> > > > > *explicitly* designed to avoid corrupting any more than just r0-r3
> > > > > and lr.  That's not just the IO functions but also the hex and string
> > > > > printing functions.
> > > > > 
> > > > > And the head*.S code is explicitly written to expect r0-r3 to be
> > > > > corrupted - which basically means that no long-term values are held in
> > > > > those registers.
> > > > 
> > > > Well, not exactly.  I actually have a patch to that effect I made a 
> > > > while ago so all the early code could be unaffected by inserted function 
> > > > call, but held on to it because nothing yet justified its need.  Here it 
> > > > is for reference:
> > > 
> > > And so this buggers up the ability to insert calls to the debugging code
> > > by placing values into r0-r3.  So that patch will get a nak too.
> > 
> > What?  Please look again at the patch and tell me what is wrong with it.
> > Because I can't make sense of your last sentence.
> 
> Have you not been reading what I've been saying.
> 
> Point 1: the code explicitly _avoids_ using r0-r3 except in small short
> code sequences.
> 
> Point 2: the debugging macros explicitly use r0-r3 because they know that
> these registers aren't going to be used in the assembly code except in
> small short code sequences.
> 
I totally agree.

Now, Have you not been reading what my patch does, and what my patch log 
message says?

What you explained above is not in agreement with the current state of 
the code, and my patch was actually making the code conform to what you 
say.

> So, changing all the assembly to use r0-r3 is going to bugger up the
> ability to use the debugging macros.  Therefore this is a change with
> a net reduction in facility.  Therefore I don't want it.

Clearly you didn't read my patch.  So let me resume its purpose here: 
throughout the whole head*.S code, r1 and r2 are live with the machine 
ID and ATAG pointer, right up to before the call to start_kernel.  My 
patch move them away so r0-r3 are really avoided except for short code 
sequences.


Nicolas
