From: jglauber@cavium.com (Jan Glauber)
Date: Mon, 19 Feb 2018 12:26:45 +0100
Subject: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
In-Reply-To: <20180219110238.GA30394@arm.com>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
 <36bd758c-dd49-edef-cc1a-20f5b43f5011@huawei.com>
 <20180219110238.GA30394@arm.com>
Message-ID: <20180219111747.GA25218@wintermute>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I just hit the same issue with 4.16-rc2. The patch makes it compilable
again.

--Jan

On Mon, Feb 19, 2018 at 11:02:39AM +0000, Will Deacon wrote:
> Hi John,
> 
> On Mon, Feb 19, 2018 at 10:19:35AM +0000, John Garry wrote:
> > On 19/02/2018 06:39, Bhupesh Sharma wrote:
> > >Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
> > >Silence Sparse warnings), compilation of arm64 architecture is broken
> > >with the following error messages:
> > >
> > >  AR      arch/arm64/kernel/built-in.o
> > >  arch/arm64/kernel/head.S: Assembler messages:
> > >  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >  arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > >  arch/arm64/kernel/head.S:677: Error: junk at end of line, first
> > >  unrecognized character is `L'
> > >  arch/arm64/kernel/head.S:677: Error: unexpected characters following
> > >  instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
> > >  arch/arm64/kernel/head.S:677: Error: unexpected characters following
> > >  instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
> > >
> > >This patch fixes the same by using the UL() macro correctly for
> > >assigning the MPIDR_HWID_BITMASK macro value.
> > >
> > >Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > >---
> > > arch/arm64/include/asm/cputype.h | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> > >index eda8c5f629fc..350c76a1d15b 100644
> > >--- a/arch/arm64/include/asm/cputype.h
> > >+++ b/arch/arm64/include/asm/cputype.h
> > >@@ -20,7 +20,7 @@
> > >
> > > #define MPIDR_UP_BITMASK	(0x1 << 30)
> > > #define MPIDR_MT_BITMASK	(0x1 << 24)
> > >-#define MPIDR_HWID_BITMASK	0xff00ffffffUL
> > >+#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
> > 
> > Works for me.
> > 
> > FYI, I am using (old) gcc-linaro-4.8-2015.06-x86_64_aarch64.
> 
> Just to confirm: are you saying that this patch fixes the build for you,
> or that mainline builds for you and the patch is not needed?
> 
> Cheers,
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
