From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Aug 2015 17:01:12 +0100
Subject: [PATCH 7/7] ARM: redo TTBR setup code for LPAE
In-Reply-To: <55C22B21.8000700@free-electrons.com>
References: <20150506103000.GF2067@n2100.arm.linux.org.uk>
 <E1YpwbQ-0000wm-Jx@rmk-PC.arm.linux.org.uk>
 <55C22B21.8000700@free-electrons.com>
Message-ID: <20150805160112.GZ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 05:26:25PM +0200, Gregory CLEMENT wrote:
> It seems that since the merge of this commit the secondary CPUs on
> Armada XP failed to come online in Big Endian (my configuration is
> mvebu_v7_defconfig+CONFIG_CPU_BIG_ENDIAN=y).

That's probably because I don't test big endian at all, never have done,
and I suspect never will as I've never had systems using BE.  So, I regard
BE as something of a troublesome untestable burden on kernel development.
(And I've always regarded BE to be an abomination.)  In short, I loath
big endian, which really doesn't bode well for me not constantly cocking
it up...

My guess is that it all comes down to much of the new code expecting the
value in r4/r5 to be the least significant 32bits in r4 and the most
significant 32bits in r5.  However, in the secondary code, we load this
using ldrd, which on BE probably reverses that.

> Once I found that this commit introduced the regression I also tested
> but with LPAE but I had the same result: only the first CPU boot.

Not surprising.  I guess BE would need the two registers to mcrr reversing
if they were a 64-bit value loaded with ldrd.

The simple answer may just be to swap r4/r5 after the ldrd.  Trying to do
something different is likely to get into very troublesome problems,
ensuring that r5 doesn't get overwritten (eg, the code which loads the
domain access register would have to switch to a different register -
maybe r4? - but then that needs to be dependent on LE or BE...) and we're
really not going to end up with lots of conditional register usage just
because of annoying BE differences scattered throughout the code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
