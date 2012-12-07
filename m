From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 07 Dec 2012 17:45:47 +0000
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <1354900436.17101.58.camel@gandalf.local.home>
References: <1354817466.30905.13.camel@linaro1.home>
 <1354821581.17101.17.camel@gandalf.local.home>
 <1354872138.3176.15.camel@computer5.home>
 <1354888985.17101.41.camel@gandalf.local.home>
 <1354892111.13000.50.camel@linaro1.home>
 <1354894134.17101.44.camel@gandalf.local.home>
 <20121207162346.GW14363@n2100.arm.linux.org.uk>
 <1354898200.17101.50.camel@gandalf.local.home>
 <20121207164530.GX14363@n2100.arm.linux.org.uk>
 <1354900436.17101.58.camel@gandalf.local.home>
Message-ID: <1354902347.8263.12.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-07 at 12:13 -0500, Steven Rostedt wrote:
> I'll make my question more general:
> 
> If I have a nop, that is a size of a call (branch and link), which is
> near the beginning of a function and not part of any conditional, and I
> want to convert it into a call (branch and link), would adding a
> breakpoint to it, modifying it to the call, and then removing the
> breakpoint be possible? Of course it would require syncing in between
> steps, but my question is, if the above is possible on a thumb2 ARM
> processor?

I believe so. The details are (repeating your earlier explanation) ...

1. Replace first half of nop with 16bit 'breakpoint' instruction.

2. Sync.(cache flush to PoU + IPIs to make other cores invalidate the
icache for changed part of the nop instruction).

3. Replace second half of nop with second half of the call instruction.

4. Sync.

5. Replace the breakpoint with the first half of the call instruction.

6. Sync

And if any core execute the breakpoint instruction, then the handler
ensures execution continues at the instruction after the nop were trying
to replace.

However, wouldn't we need any of this breakpoint malarkey, why not just
just use a 16-bit branch instruction which branches over the second half
of the nop? :-)

-- 
Tixy
