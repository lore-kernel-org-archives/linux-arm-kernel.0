From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Aug 2011 09:36:18 +0100
Subject: [PATCH 16/18] dmaengine/amba-pl08x: Add support for sg len
	greater than one for slave transfers
In-Reply-To: <5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
Message-ID: <20110814083618.GE4986@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 04:19:26PM +0530, Viresh Kumar wrote:
> Untill now, sg_len greater than one is not supported. This patch adds support to
> do that.

I'm not sure that this is the correct approach.  memcpy()s can only be
used with one single buffer, so the sg stuff for that (and the unmapping
support) doesn't make sense at all.

The only place where this makes sense is the slave sg stuff.  I wonder
whether we can better deal with that by having the LLI setup code deal
with one SG list entry at a time, and chain each together.

Something I've also been pondering which is related to this is linking
together DMA operations using the LLI chaining when interrupts and
callbacks aren't required.  It's a very similar problem.  Other DMA
engine drivers do this.

Finally, note that some of the PL08x code assumes that for any TXD,
the LLI list is a contiguous array.  See the first part of
pl08x_getbytes_chan(). That needs fixing as soon as we start going to
more than one SG list entry.
