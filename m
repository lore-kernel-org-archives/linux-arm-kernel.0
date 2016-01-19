From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2016 16:23:28 +0000
Subject: CONFIG_CPU_SW_DOMAIN_PAN breakage on ARM11 MPCore
In-Reply-To: <12866783.yJ1maoGsrz@wuerfel>
References: <569D71F3.7000408@openwrt.org>
 <20160119093845.GJ19062@n2100.arm.linux.org.uk>
 <569E0796.9000302@openwrt.org> <12866783.yJ1maoGsrz@wuerfel>
Message-ID: <20160119162328.GM19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 04:27:49PM +0100, Arnd Bergmann wrote:
> I guess this means you run with the SMP patches from OpenWRT,
> while upstream only supports uniprocessor mode and presumably doesn't
> have this problem, right?

It's not got much to do with SMP vs UP mode - it seems to be a CPU
core bug, though really we have no real idea what's going on here
as Will was unable to easily get hold of the information within
ARM Ltd to properly diagnose this (it's been "archived", and which
is why it remains unfixed - we've a deficit of information.)

However, the SMP vs UP mode thing does have an effect on the fix
too - if we have MPcore systems operating in UP mode, we're going
to need a much more complex and hideous fix - we're likely going
to need to out-of-line _all_ the TLB flushing which is going to
be nasty for the vast majority not affected by this. :(

> I see that Oxnas (supported in OpenWRT but not upstream) has the
> slightly newer ARM11mpcore variant 0 / revision 5 ID. Is it easy for
> you to test if this has the same problem?

LinusW's failing case is a MPcore with a MIDR of 0x410fb020 (r0p0).
Felix's case is 0x410fb024.  Even if we had implemented a work-around
for Linus' case, without any further information, we'd have assumed
that only r0p0 is affected, which would not have caught Felix's case.

> Interestingly, the documentation at
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0360f/I65012.html
> lists variant:0/revision:4 as the reported values for both r2p0 and r1p0
> and it does not list any core having variant:0/revision:5. 

I wouldn't read too much into that - I suspect the r2p0 document
wasn't updated properly.  That's why I prefer to go by a definitive
list of variant/revisions to rNpN when listed, or by discovering
what's actually out in the field compared to what it should contain.

It is equally possible that r2p0 and r1p0 do indeed share the same
variant/revision and someone forgot to change the hardware.

Does it make much difference though - we now know that variant 0/
revision 0 and variant 0/revision 4 are both affected, but we still
don't know whether variant 0/revision 5 is, or whether all 11MPcores
are affected.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
