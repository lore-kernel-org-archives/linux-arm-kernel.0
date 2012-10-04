From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Oct 2012 11:40:15 +0200
Subject: [RFC PATCH 1/2] ARM: use generic strnlen_user and
 strncpy_from_user functions
In-Reply-To: <20121003091636.GC22445@mudshark.cambridge.arm.com>
References: <1339169935-31775-1-git-send-email-will.deacon@arm.com>
 <1339169935-31775-2-git-send-email-will.deacon@arm.com>
 <20121002175316.GA598@pengutronix.de>
 <20121002191851.GB20411@mudshark.cambridge.arm.com>
 <20121003060042.GB598@pengutronix.de>
 <20121003091636.GC22445@mudshark.cambridge.arm.com>
Message-ID: <20121004094015.GI598@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2012 at 10:16:36AM +0100, Will Deacon wrote:
> On Wed, Oct 03, 2012 at 07:00:42AM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Oct 02, 2012 at 08:18:51PM +0100, Will Deacon wrote:
> > > Ok, thanks for the heads-up. I didn't test it with an M-class CPU, but
> > > hopefully that's understandable :)
> >
> > I think so, yes. But I intend to change that, and I heard your coworker
> > gets an efm32 :-)
> 
> Yep, he'll be in charge of testing for us (!)
:-)

> > > > > +#define user_addr_max() \
> > > > > +	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
> > > > > +
> > > > I think this is the problem as for no-mmu USER_DS == KERNEL_DS. I will
> > > > take a look tomorrow.
> > > 
> > > I can't immediately see why that would cause a problem, so please let me
> > > know if you get more information.
> > BTW, I once saw the call to sys_mount fail:
> > 
> > 	sys_mount ->
> > 	copy_mount_string ->
> > 	strndup_user ->
> > 	strnlen_user returns 0 which makes sys_mount fail with -EFAULT.
> > 
> > but that was not the problem I hit when I bisected (using merges instead
> > of rebasing).
> 
> Was this also on your M3?
Yeah. I found a change that fixes it for me:

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 77bd79f..7775e03 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -216,7 +216,7 @@ static inline void set_fs(mm_segment_t fs)
 #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)
 
 #define user_addr_max() \
-	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
+	(segment_eq(get_fs(), KERNEL_DL) ? ~0UL : TASK_SIZE)
 
 /*
  * The "__xxx" versions of the user access functions do not verify the

I'm not sure if this has some security implications for the !MMU case!?
(But if so according to my understanding (which might well be wrong)
using TASK_SIZE isn't correct also. So this only widens the window, but
doesn't create it.)

On !MMU TASK_SIZE is CONFIG_DRAM_SIZE, but I'm using XIP and the flash
is at an higher address than RAM. So maybe XIP is broken on MMU
machines, too?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
