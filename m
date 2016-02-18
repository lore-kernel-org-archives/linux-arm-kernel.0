From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 18 Feb 2016 18:18:02 +0000
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <alpine.LFD.2.20.1602181244490.13632@knanqh.ubzr>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1602181244490.13632@knanqh.ubzr>
Message-ID: <HK2PR06MB0561377EABB3B4B8E94F22328AAF0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> And realistically it makes no sense to use XIP (surely because you need
> to save space) and have multi-platform support in your kernel.


The problem is that you don't have a choice: Multi-platform is your only choice for many devices (MMU devices that is).

So for XIP, it comes down to either:

A) Go back to making individual configs for each MPU

B) Let everything keep getting grouped together into multi-platform, and then just de-selecting the MPU you don't want.

I can tell you when I build my upstream XIP kernel for testing for the RZ/A1, it's ARCH_MULTIPLATFORM (all Renesas parts are multiplatform) and then remove everything I don't want/need, my kernel size is 3.4MB.


> IMHO it should be clear that with XIP there is only one platform that can
> be supported.

I would be fine if there was some way you could only select XIP_KERNEL if only 1 of the MPUs in the multiplatform group were selected...but I can't figure out how to do that in the kbuild system (without adding lots of chunky configs all over the place...which is not what I want)

Is there some way you can do a PLATFORM_COUNTER++ for each device that is selected, and then XIP_KERNEL would depend on PLATFORM_COUNTER == 1 ?


Chris
