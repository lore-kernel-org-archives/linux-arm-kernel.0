From: smuckle@codeaurora.org (Steve Muckle)
Date: Thu, 24 Mar 2011 11:22:11 -0700
Subject: IO access and *_relaxed macros
Message-ID: <4D8B8BD3.5070403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On ARMv7 the readl and writel macros (and readb, etc) include memory
barriers (dmb or dsb, unless defined otherwise by the machine) due to
CONFIG_ARM_DMA_MEM_BUFFERABLE being defined by default. Likewise the
ioread* and iowrite* macros also include memory barriers.

The barriers in the io accessor macros are only on one side, and the
reads and writes have them on different sides, so it's easy to slip up
if you're relying on these macros to perform memory barriers in certain
locations. They also have a noticeable effect on performance.

To obtain best performance in drivers it would seem appropriate to use
the *_relaxed io accessor macros which lack memory barriers and manage
the memory barriers directly, inserting them only when strictly
required. Usage of the *_relaxed macros doesn't seem to be especially
prevalent however so I thought I'd see if others had thoughts or
concerns on this.

thanks,
Steve

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
