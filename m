From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 9 Apr 2015 15:36:19 +0200
Subject: [regression, armada-xp] bus: mvebu-mbus: make sure SDRAM CS...
 breaks PCI
In-Reply-To: <55267F36.3070908@list.ru>
References: <55267F36.3070908@list.ru>
Message-ID: <20150409153619.7ef251cb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stas Sergeev,

On Thu, 09 Apr 2015 16:31:34 +0300, Stas Sergeev wrote:
> Hello Thomas and arm developers.
> 
> I've bisected the patch that makes the PCI devices
> (mvsas in my case) to cause the entire system hang.

Yes, I also investigated this issue last week, and came to the same
conclusion.

> commit 1737cac6936938a9bc52c03c4a3ff2032c702fa5
> Author: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Date:   Fri Jan 9 10:59:04 2015 -0600
> 
>     bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge wi
> 
> 
> That patch looks into mblock for the hole at the end of 4G
> space and rounds down the DRAM window size.
> The problem is that the window sizes must be the power of 2.
> Here's the quote from Marvel datasheet:
> ---
> The size must be programmed as a set of 1s (starting from the LSB) followed by a set of
> 0s. The set of 1s defines the size. For example, if Size[7:0] is set to 0x0F, it defines a size of 256 MB
> (number of 1s is 4, 2^4 x 16 MB = 256 MB).
> ---
> This basically mean that if the size is the power of 2, you
> can just subtract 1 and apply the AND mask, but if it is not
> the power of 2, you need to round-up. But round-up will again
> create an overlap with MBus bridge, defeating the purpose of the
> patch.
> 
> I think the patch should be reverted.
> After reverting it I've got the stable system with mvsas working fine.
> 
> If you have any other ideas than to revert patch, I can test.

The patch was originally meant to allow the upcoming crypto CESA driver
to do DMA with the SRAM. And the CESA unit doesn't have the power of
two requirement for the DRAM windows, but this is something we only
realized in the last few days.

So most likely, the best course of action will be to revert this patch,
and instead handle the problem of making sure the DRAM windows don't
overlap with the I/O space directly in the CESA driver, which is the
only one actually interested in doing DMA with the SRAM.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
