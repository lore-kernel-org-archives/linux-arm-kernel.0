From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Tue, 5 May 2015 15:28:30 +0530
Subject: [PATCH 02/12] net: axienet: Handle 0 packet receive gracefully
In-Reply-To: <55b3c89b3549c61d62b8440636516fd572870842.1430817941.git.michal.simek@xilinx.com>
References: <7fb84f65a61bbe0fdb4b61a871cf4d4f7910955d.1430817941.git.michal.simek@xilinx.com>
 <55b3c89b3549c61d62b8440636516fd572870842.1430817941.git.michal.simek@xilinx.com>
Message-ID: <CAM=Q2csJVHDqRC0rGxbTbBJjmotknKK7znLhbPUH4TCwktWJpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 5, 2015 at 2:55 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
>
> The AXI-DMA rx-delay interrupt can sometimes be triggered
> when there are 0 outstanding packets received. This is due
> to the fact that the receive function will greedily consume
> as many packets as possible on interrupt. So if two packets
> (with a very particular timing) arrive in succession they
> will each cause the rx-delay interrupt, but the first interrupt
> will consume both packets.
> This means the second interrupt is a 0 packet receive.
>
> This is mostly OK, except that the tail pointer register is
> updated unconditionally on receive. Currently the tail pointer
> is always set to the current bd-ring descriptor under
> the assumption that the hardware has moved onto the next
> descriptor. What this means for length 0 recv is the current
> descriptor that the hardware is potentially yet to use will
> be marked as the tail. This causes the hardware to think
> its run out of descriptors deadlocking the whole rx path.
>
Should it marked to stable ?

> Fixed by updating the tail pointer to the most recent
> successfully consumed descriptor.
>
> Reported-by: Wendy Liang <wendy.liang@xilinx.com>
> Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Tested-by: Jason Wu <huanyu@xilinx.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
