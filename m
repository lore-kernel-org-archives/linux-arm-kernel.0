From: drivshin@awxrd.com (David Rivshin)
Date: Fri, 6 Apr 2018 12:36:50 -0400
Subject: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
In-Reply-To: <eae3e959-60cb-a8cc-be97-f782d0c96f08@linaro.org>
References: <20180405200916.27964-1-drivshin@awxrd.com>
 <20180406132511.uzl6viazwaey4bem@holly.lan>
 <eae3e959-60cb-a8cc-be97-f782d0c96f08@linaro.org>
Message-ID: <20180406123650.7fe32612.drivshin@awxrd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Apr 2018 14:49:22 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> On 06/04/18 14:25, Daniel Thompson wrote:
> > On Thu, Apr 05, 2018 at 04:09:16PM -0400, David Rivshin wrote:  
> >> From: David Rivshin <DRivshin@allworx.com>
> >>
> >> NUMREGBYTES (which is used as the size for gdb_regs[]) is incorrectly based
> >> on DBG_MAX_REG_NUM instead of GDB_MAX_REGS. DBG_MAX_REG_NUM is the number
> >> of total registers, while GDB_MAX_REGS is the number of 'unsigned longs'
> >> it takes to serialize those registers. Since FP registers require 3
> >> 'unsigned longs' each, DBG_MAX_REG_NUM is smaller than GDB_MAX_REGS.
> >>
> >> This causes GDB 8.0 give the following error on connect:
> >> "Truncated register 19 in remote 'g' packet"
> >>
> >> This also causes the register serialization/deserialization logic to
> >> overflow gdb_regs[], overwriting whatever follows.
> >>
> >> Fixes: 834b2964b7ab ("kgdb,arm: fix register dump")
> >> Cc: <stable@vger.kernel.org> # 2.6.37+
> >> Signed-off-by: David Rivshin <drivshin@allworx.com>  
> > 
> > I pointed some trivial autotests at both gdb-7.12 and gdb-8.0. Results
> > look good to me!
> > 
> > Tested-by: Daniel Thompson <daniel.thompson@linaro.org>  
> 
> BTW I noticed that myself and Jason in the only "real people" in
> To: . Most arch specific patches end up making their way upstream via 
> the arch maintainer rather than via the kgdb tree so personally I would 
> choose to the arch maintainers in the To: field as well.
> 
> I certainly think you will have to follow up via Russell King's patch 
> tracker once you think its had enough time on the ML for review.

Thanks for testing and the pointer, I wasn't sure what tree this would 
go through.

Russell, if you have no objections I'll let this soak on the ML for a 
bit longer, and then submit it to your patch tracker with collected tags.


> 
> 
> Daniel.
> 
> 
> >   
> >> ---
> >>   arch/arm/include/asm/kgdb.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
> >> index 3b73fdcf3627a..8de1100d10674 100644
> >> --- a/arch/arm/include/asm/kgdb.h
> >> +++ b/arch/arm/include/asm/kgdb.h
> >> @@ -77,7 +77,7 @@ extern int kgdb_fault_expected;
> >>   
> >>   #define KGDB_MAX_NO_CPUS	1
> >>   #define BUFMAX			400
> >> -#define NUMREGBYTES		(DBG_MAX_REG_NUM << 2)
> >> +#define NUMREGBYTES		(GDB_MAX_REGS << 2)
> >>   #define NUMCRITREGBYTES		(32 << 2)
> >>   
> >>   #define _R0			0
> >>
> >> base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
> >> -- 
> >> 2.14.3
> >>  
> 
