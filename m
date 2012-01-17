From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 10:11:29 +0000
Subject: [PATCH 1/2] ARM: vmlinux.lds.S: do not hardcode cacheline size
 as 32 bytes
In-Reply-To: <alpine.LFD.2.02.1201161425040.2722@xanadu.home>
References: <20120116191118.GF11088@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1201161425040.2722@xanadu.home>
Message-ID: <20120117101129.GA9230@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 07:35:43PM +0000, Nicolas Pitre wrote:
> On Mon, 16 Jan 2012, Will Deacon wrote:
> > On Mon, Jan 16, 2012 at 06:30:23PM +0000, Stephen Boyd wrote:
> > > I haven't measured anything yet. I just see that it's another value
> > > hard-coded to 32 in the linker script and that tile has decided to use
> > > L1_CACHE_BYTES for it.
> > 
> > Hmm, that's intriguing. The exception table entries are 8 bytes on ARM and
> > are aligned as such by things like the USER macro, so I'm not sure why we
> > align the section to 32 bytes. I guess it must be for performance reasons,
> > but whether that's due to cacheline size, I don't know.
> > 
> > Nico, can you enlighten us please (it was introduced in 13b1f64c ("[ARM]
> > 3008/1: the exception table is not read-only"))?
> 
> It probably was due to the fact that the surrounding data was also cache 
> line aligned.  I don't think there is any particular reason why it 
> should be aligned to a cache line boundary given that the list is 
> accessed with a binary search.  The minimum required alignment would be 
> __alignof__(struct exception_table_entry).

Given that the struct just contains two unsigned longs, we should be alright
with 4 byte alignment here. I can add a follow-on patch to change that.

Thanks,

Will
