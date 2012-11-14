From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 Nov 2012 17:22:16 +0000
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <0154077FE026E54BB093CA7EB3FD1AE32DB61E4CC7@SAFEX1MAIL3.st.com>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113171745.GA6370@linaro.org>
 <BLU002-W44C55773365E0FDAC8B3C5E36C0@phx.gbl>
 <0154077FE026E54BB093CA7EB3FD1AE32DB61E4CC7@SAFEX1MAIL3.st.com>
Message-ID: <20121114172216.GG16215@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 10:15:46AM +0000, Etienne CARRIERE ST wrote:
> > Tue 11-13-2012 8:23 PM
> > From: Abhimanyu Kapur <abhimanyu.kapur@outlook.com>
> >
> > > Secure code in TrustZone space may need to perform L2 cache
> > > maintenance operations. A shared mutex is required to synchronize
> > > linux l2cc maintenance and TZ l2cc maintenance.
> > 
> > If you are using PL310 with thrustzone support then the L2 cache lines 
> > are secure bit tagged ; your design should be such that the secure (TZ) 
> > side only does operations on secure cache lines and non-secure side 
> > does operations only on non-secure cache lines. So each entity (TZ 
> > and nonTZ) if maintains their own cache and ensures integrity before 
> > switching over via monitor, this might not be needed.
> 
> I don't think 2 cores can safely write the LX20_CLEAN/INV_LINE_PA
> registers of the PL310 at the same time, even if targeting different
> lines.

Actually for the clean/invalidate operations by PA you can safely write
the registers from two different processors as they get serialised by
the hardware. What you don't get is protection around the background
operations (clean/inv by way). I think it depends on how the PL310 is
wired on your hardware but trying to do a PA operation while a
background one is in progress would trigger an external abort.

So the NS world could simply start a background cache operation without
taking the lock while the secure world thinks that it has the lock and
tries to do a PA operation which would abort.

My advise is to simply ignore the shared locking and only do atomic PA
operations on the secure side. The secure side also needs to poll for
the completion of any background operation that was started in
non-secure world. Of course, there is still a race, in which case,
depending on the hardware implementation, you would need to trap any
possible aborts while in secure mode when writing the PL310 registers.

-- 
Catalin
