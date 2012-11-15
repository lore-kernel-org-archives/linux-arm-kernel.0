From: etienne.carriere@st.com (Etienne CARRIERE ST)
Date: Thu, 15 Nov 2012 15:10:59 +0100
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <20121115135555.GC25985@arm.com>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113171745.GA6370@linaro.org>
 <BLU002-W44C55773365E0FDAC8B3C5E36C0@phx.gbl>
 <0154077FE026E54BB093CA7EB3FD1AE32DB61E4CC7@SAFEX1MAIL3.st.com>
 <20121114172216.GG16215@arm.com>
 <0154077FE026E54BB093CA7EB3FD1AE32DB6A63266@SAFEX1MAIL3.st.com>
 <20121115135555.GC25985@arm.com>
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32DB6A632CA@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If I understood well, you stated that on-going background operations on L2 can jeopardize PA operations.
So the secure code must insure other CPUs do not perform other L2 operations, including non-PA based operations.

Linux protects both PA and WAY operations using the very same spinlock.
We must hold this lock while performing any PA operations from secure world.

I am right ?

etienne

-----Original Message-----
From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
Sent: Thursday, November 15, 2012 2:56 PM
To: Etienne CARRIERE ST
Cc: Abhimanyu Kapur; Dave Martin; Rabin VINCENT; Russell King; Srinidhi KASAGAR; Marc Zyngier; Linus Walleij (linus.walleij at linaro.org); Will Deacon; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ

On Thu, Nov 15, 2012 at 01:46:29PM +0000, Etienne CARRIERE ST wrote:
> I think we will internally use our hack in l2x0 spin locking to 
> prevent collision, based on old arch_spinlock support.

Or just handle the collision in the secure code and make sure you don't start background operations. If you don't use background operations, you don't need any locking.

--
Catalin
