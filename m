From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 Jan 2012 14:35:43 -0500 (EST)
Subject: [PATCH 1/2] ARM: vmlinux.lds.S: do not hardcode cacheline size as
 32 bytes
In-Reply-To: <20120116191118.GF11088@mudshark.cambridge.arm.com>
References: <20120116191118.GF11088@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1201161425040.2722@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jan 2012, Will Deacon wrote:

> On Mon, Jan 16, 2012 at 06:30:23PM +0000, Stephen Boyd wrote:
> > On 01/16/12 10:26, Will Deacon wrote:
> > > On Mon, Jan 16, 2012 at 06:22:34PM +0000, Stephen Boyd wrote:
> > >>
> > >> What do you think about aligning the exception fixup table to the same
> > >> value?
> > > Hmm, I'm not sure I see what that gains us over the current 32-byte
> > > alignment. Are you seeing any measurable performance difference with it being
> > > cacheline-aligned?
> > >
> > 
> > I haven't measured anything yet. I just see that it's another value
> > hard-coded to 32 in the linker script and that tile has decided to use
> > L1_CACHE_BYTES for it.
> 
> Hmm, that's intriguing. The exception table entries are 8 bytes on ARM and
> are aligned as such by things like the USER macro, so I'm not sure why we
> align the section to 32 bytes. I guess it must be for performance reasons,
> but whether that's due to cacheline size, I don't know.
> 
> Nico, can you enlighten us please (it was introduced in 13b1f64c ("[ARM]
> 3008/1: the exception table is not read-only"))?

It probably was due to the fact that the surrounding data was also cache 
line aligned.  I don't think there is any particular reason why it 
should be aligned to a cache line boundary given that the list is 
accessed with a binary search.  The minimum required alignment would be 
__alignof__(struct exception_table_entry).


Nicolas
