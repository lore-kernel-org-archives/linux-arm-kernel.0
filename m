From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 May 2012 16:50:22 +0100
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
In-Reply-To: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
References: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
Message-ID: <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 14, 2012 at 08:03:04AM +0100, Murali N wrote:
> Hi All,
> I have a query on cache flush sequence being followed for L1 & L2
> while target going into deep low power state on CortexA5 MPCore.
> Here are the H/W details & the cache flush sequence i am following in
> my power driver:
> 
> H/W details:
> 1.        APPS processor: CortexA5 MPCore
> 2.        L2 controller: External PL310 r3p2
> 
> Sequences:
> a) While target is going into deep low power mode (where APPS
> processor + L2 loose their power) currently I am following the below
> cache flush sequence.
> 
> 1. L2 cache clean & invalidate

This is wrong. If L1 evictions happen here you will kiss those cache lines
goodbye when the cluster is powered off. See below.

> 2. L2 disable
> 3. L1 clean & invalidate

This is wrong again since while cleaning and invalidating the cache (L1 here)
can still allocate and this must not happen.

> 4. L1 disable
> 5. WFI
> 
> b) But when I look the PL310 r3p2 TRM (page no 91) explains the
> sequence to be followed is bit difference than what I am following.
> 
> 1. L1 clean & invalidate
> 2. L1 disable
> 3. L2 cache clean & invalidate
> 4. L2 disable
> 5. WFI

You are *extrapolating* the procedure above from the TRM, but that's not
100% correct.

For a single CPU shutdown the procedure is the following:

1) clear C bit in SCTLR. CPU won't allocate cache lines in integrated
   (L1 for A5) caches anymore. Memory access might still hit in the cache,
   but that's not a problem, you just want to writeback the content of caches
   to DDR on power down.
   This is subtle but important. If a dirty cache line is moved from one
   processor to the one going down while cleaning the cache, the cache line is
   lost (dirty lines can be moved between processors).
   Clearing the C bit BEFORE starting the cache clean prevents that.
2) clean and invalidate the cache levels (L1 in A5)
3) exit coherency (clear SMP bit in ACTLR)

If the cluster has to be shut down as well and L2 is not retained through power
down:

4) clean and invalidate L2
5) disable PL310

Please note that 5 might not be strictly required, it depends on your specific
HW configuration and how AXI transactions interact with the power
controller. If you want to be on the safe side, (5) has to be executed.

Please note that PL310 can be disabled before cleaning and invalidating
L2. If you carry out the operations in the order above, code must NOT
write any static data that has to be preserved throughout shutdown
between (4) and (5).
The C bit in SCTLR does not affect PL310 since it is external to the core so
you could end up allocating cache lines after the entire content of L2
has been cleaned. If those lines are just eg stack lines that can be
discarded then fine, but if that data is to be preserved and consistent
through shut down then you have been warned.

I suggest you have a look at OMAP4 CPU idle implementation where the
above is implemented in detail, inclusive of cpu_{suspend}/cpu_{resume}
API that provides the infrastructure on top of which cache management
code must be built.

> Is it mandatory that I would follow only the sequence that is
> mentioned in the TRM (i.e. b)? (OR) though TRM says above sequence
> (i.e. b) can i still follow the steps (i.e. a)?
> What are problems that I see, if I don't follow what TRM says & follow
> the sequence which I have mentioned above (i.e. a)?

Yes, it is mandatory. I hope I explained why thoroughly.
And (b), as it stands in your description is wrong and I explained why it is
so.

> Also I have worked on another target with CortexA5 (Single core with
> same L2 pl310 controller) where i have followed the sequence 'a' for
> quite a long time and don't see any data corruption issues.

This does not mean the procedure is correct.

> Here my question is, is the above sequence 'b' something special for
> only CortexA5MPCore targets to follow?

(b) is wrong, and the "patched" procedure I provided you with works for all
ARM MP systems (and consequently UP as well).

Hope that helps, feel free to come back to us for any questions.

Lorenzo
