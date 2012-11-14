From: etienne.carriere@st.com (Etienne CARRIERE ST)
Date: Wed, 14 Nov 2012 11:15:46 +0100
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <BLU002-W44C55773365E0FDAC8B3C5E36C0@phx.gbl>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>,
 <20121113171745.GA6370@linaro.org>
 <BLU002-W44C55773365E0FDAC8B3C5E36C0@phx.gbl>
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32DB61E4CC7@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Tue 11-13-2012 8:23 PM
> From: Abhimanyu Kapur <abhimanyu.kapur@outlook.com>
>
> > Secure code in TrustZone space may need to perform L2 cache
> > maintenance operations. A shared mutex is required to synchronize
> > linux l2cc maintenance and TZ l2cc maintenance.
> 
> If you are using PL310 with thrustzone support then the L2 cache lines 
> are secure bit tagged ; your design should be such that the secure (TZ) 
> side only does operations on secure cache lines and non-secure side 
> does operations only on non-secure cache lines. So each entity (TZ 
> and nonTZ) if maintains their own cache and ensures integrity before 
> switching over via monitor, this might not be needed.

I don't think 2 cores can safely write the LX20_CLEAN/INV_LINE_PA registers of the PL310 at the same time, even if targeting different lines.
Each core TZ code must protect against other core (being UnSecure or TZ mode). The core IRQ disabling is required to protect from deadlock nonTZ and TZ worlds.

Regards,
etienne
