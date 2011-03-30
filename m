From: tixy@yxit.co.uk (Tixy)
Date: Wed, 30 Mar 2011 18:20:29 +0100
Subject: [PATCH] Reject kprobes when Rn==15 and writeback is set
In-Reply-To: <4D935E67.8060203@nokia.com>
References: <alpine.LFD.2.00.1103291441160.11889@xanadu.home>
	<1301492550-16747-1-git-send-email-viktor.rosendahl@nokia.com>
	<1301500340.2488.127.camel@computer2.home> <4D935E67.8060203@nokia.com>
Message-ID: <1301505629.2488.148.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-30 at 19:46 +0300, Viktor Rosendahl wrote:
> On 03/30/2011 06:52 PM, ext Tixy wrote:
> 
> > If we start littering the code with all these extra checks we risk
> > introducing bugs and making the code more difficult to maintain.
> >
> > In my opinion we should not add any extra code to handle instructions
> > combinations that the ARM ARM says are UNPREDICTABLE, or have fields
> > which are SBZ/SBO. The toolchain shouldn't ever generate these bad
> > instructions in which case the extra kprobes code is redundant.
> >
> 
> I see your point. I guess we can decide to not care about those 
> unpredictable cases, unless someone can come up with some decoding & 
> checking code that covers all the cases and is easy to understand and 
> maintain.

I came to my conclusion because I was trying to verify the PC writeback
fix by looking at the ARM ARM and checking that all of the 20 or so
encodings [1] of LDR/STR instructions handled by the routine actually
had the prefix and writeback bits we were testing. I think they did, but
it was very tedious, and I thought I could easily miss something and
then we might end up introducing a new bug.

If ARM were still a RISC processor then things would be a lot easier ;-)

-- 
Tixy

[1] In ARM ARM, See
    Table A5-15 Single data transfer instructions
    Table A5-10 Extra load/store instructions
    Table A5-11 Extra load/store instructions (unprivileged)
