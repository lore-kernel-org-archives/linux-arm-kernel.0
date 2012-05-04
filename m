From: cxie4@marvell.com (Chao Xie)
Date: Thu, 3 May 2012 19:02:07 -0700
Subject: common clock framework
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The common clock driver in drivers/clk/ has been integrated into mainline. In fact, I still have some questions to the driver.
1. Why need big lock: enable_lock and prepare_lock?
   Using these locks means that the clock enable and prepare operation cannot re-entered.
2. How to handle the depended clocks?
   For example clock1 and clock2 both have multiple inputs, and they both depend on clock3. It means that before enable clock1 or clock2, clock3 should be enabled, and if clock1 and clock2 are both off, clock2 need to be off too to save power. Clock3 is not the parent of clock1 and clock2, because the clock3 is not one of inputs of clock1 and clock2.
   If we do not handle it in clock framework, we have to let device driver to know it. It means that the device driver need to handle clock dependency. It will make the device driver to be complicated especially it is shared by different SOCs.
3. how to handle voltage changes in clock framework?
   When some clock's rate is changed, the voltage for the component that using the clock may need changed too. So where to add the voltage change sequence?
   
