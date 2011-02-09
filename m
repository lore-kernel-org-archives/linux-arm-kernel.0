From: ccross@android.com (Colin Cross)
Date: Wed, 9 Feb 2011 10:12:41 -0800
Subject: [PATCH] ARM: vfp: Fix up exception location in Thumb mode
In-Reply-To: <AANLkTinFvzSjT66kj5uU1YkLEaJNCyy2JV1H7Li_cSxi@mail.gmail.com>
References: <1295014231.7901.41.camel@e102109-lin.cambridge.arm.com>
	<20110114154919.GE15996@n2100.arm.linux.org.uk>
	<1295022193.7901.56.camel@e102109-lin.cambridge.arm.com>
	<20110114163520.GH15996@n2100.arm.linux.org.uk>
	<1295024327.7901.70.camel@e102109-lin.cambridge.arm.com>
	<20110114173050.GJ15996@n2100.arm.linux.org.uk>
	<20110114184759.GN15996@n2100.arm.linux.org.uk>
	<AANLkTi=J2A1Qv6NGB1bsMr6d+1VFV26KEBQ=NJ=791s0@mail.gmail.com>
	<AANLkTimd44_FjnJUCNwz412Ned5S_+YcyHjfitus3vLQ@mail.gmail.com>
	<AANLkTimZ9itumf=QZPD55+JA5cUOWKgwuA1_5=XsdPsP@mail.gmail.com>
	<20110126112624.GC2562@n2100.arm.linux.org.uk>
	<AANLkTim2fPySEMFn+ckrVAvJj8ZXEvBoZpgmZAKOWf=9@mail.gmail.com>
	<AANLkTindtGzxnCRK7XZW1jtXRAeBz9cTshqCtTr3qnL7@mail.gmail.com>
	<AANLkTinFvzSjT66kj5uU1YkLEaJNCyy2JV1H7Li_cSxi@mail.gmail.com>
Message-ID: <AANLkTi=H19ZO1pntoUKrWhXt8BVQ=upivsL1TMUhB8Fo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 11:30 PM, Colin Cross <ccross@android.com> wrote:
> This patch is on top of your first patch that cleans up the comments,
> but not the second patch that fixes the PC in the VFP exception case.
> Compiled but not run tested, and I can't test crunch or iwmmxt.
> vfpmodule.c may be able to be simplified (right now its both adding
> and subtracting 4 from regs->ARM_pc).
>
> ?arch/arm/kernel/crunch-bits.S | ? ?3 ---
> ?arch/arm/kernel/entry-armv.S ?| ? 38 ++++++++++++++++++++------------------
> ?arch/arm/kernel/iwmmxt.S ? ? ?| ? ?3 ---
> ?arch/arm/nwfpe/entry.S ? ? ? ?| ? ?1 +
> ?arch/arm/vfp/vfphw.S ? ? ? ? ?| ? ?5 -----
> ?arch/arm/vfp/vfpmodule.c ? ? ?| ? ?6 ++++++
> ?6 files changed, 27 insertions(+), 29 deletions(-)

Finally got a chance to do some quick testing on this, it needs one
more change to drop the correction in do_undefinstr in traps.c, and
fix one register in entry-armv.S.  Russell, do you have any interest
in this solution?  Alternatively, a one line change to store the
corrected PC into the stack in vfphw.S instead of entry-armv.S will
fix the original problem (VFP_bounce from thumb mode returning to the
wrong address) without causing the problem introduced by your second
patch (undefined NEON or VFP-D32 instructions in thumb mode returning
to the wrong address).
