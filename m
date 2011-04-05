From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Apr 2011 08:56:22 +0100
Subject: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
	cyc_to_fixed_sched_clock
In-Reply-To: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
Message-ID: <20110405075622.GB4699@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 09:43:21AM +0200, Jan Weitzel wrote:
> parameter "u32 mask" type cast befor inversion

Nak.  I want a 32-bit all ones quantity.

unsigned long long vali = (unsigned short)~0;
unsigned long long vall = ~(unsigned short)0;

compiles to:

vali:
        .word   65535
        .word   0

vall:
        .word   -1
        .word   -1

So moving the ~ to be evaluated after the cast has the effect of making
the cast pointless, and produces wrong values.  (u32)~0 does the 32-bit
cast _after_ the inversion which ensures that its always truncated to
a 32-bit value.

As the function is declared as taking a u32, the cast isn't needed.  If
the function gets changed to take a u64, the casts will need to be
re-added.  So, (u32)~0 makes the fact that we want a 32-bit all-ones
mask explicit.
