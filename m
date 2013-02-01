From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 1 Feb 2013 12:56:26 -0500 (EST)
Subject: [PATCH v4 00/13] ARM LPAE Fixes - Part 1
In-Reply-To: <510BE9BC.9090701@ti.com>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1301312252230.6300@xanadu.home> <510BDAED.8060805@ti.com>
 <20130201151410.GR23505@n2100.arm.linux.org.uk> <510BE9BC.9090701@ti.com>
Message-ID: <alpine.LFD.2.02.1302011246080.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Feb 2013, Cyril Chemparathy wrote:

> On 02/01/2013 10:14 AM, Russell King - ARM Linux wrote:
> > On Fri, Feb 01, 2013 at 10:10:37AM -0500, Cyril Chemparathy wrote:
> > > With this, I ran simple network and filesystem performance tests to
> > > compare the code-patching vs. non-code-patching variants.  These tests
> > > didn't yield any significant performance difference between the two on
> > > an ARMv7 (Cortex-A8) platform.
> > 
> > It's not network and fs activity that this kind of stuff is likely to
> > show up in, but more to do with walking pages tables and the like -
> > remember that page tables are stored using physical addresses, and any
> > walks of them have to convert those physical addresses to virtual
> > addresses and back again.
> > 
> > So, things like page scanning for eviction (eg, page aging, page
> > faults even those which just re-use a page from the page cache) have
> > to use the v:p / p:v translation macros.
> > 
> 
> Thanks, Russell.  Any recommendations on how to best benchmark this?

Well, the benchmark issue can be side-stepped altogether.  We know that 
the assembly patching is the best thing that can be done, and we do have 
most of it already.

As previously stated, the p2v patching may remain essentially identical 
to what we have right now.  Since the result is a 32-bit value, the 
current code should just work.

On the v2p side, it's just a matter of adding two instructions around 
the existing one (which should be turned into an adds).  The first is a 
mov to load the high bits of PHYS_OFFSET which are likely to be 
representable with a simple immediate operand, and the third one would 
be a simple adc with #0 which doesn't need any patching.


Nicolas
