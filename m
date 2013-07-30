From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 30 Jul 2013 12:35:02 +0530
Subject: [PATCH 4/9] dma: edma: Find missed events and issue them
In-Reply-To: <1375104595-16018-5-git-send-email-joelf@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
 <1375104595-16018-5-git-send-email-joelf@ti.com>
Message-ID: <51F7659E.3040302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
> In an effort to move to using Scatter gather lists of any size with
> EDMA as discussed at [1] instead of placing limitations on the driver,
> we work through the limitations of the EDMAC hardware to find missed
> events and issue them.
> 
> The sequence of events that require this are:
> 
> For the scenario where MAX slots for an EDMA channel is 3:
> 
> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> Null
> 
> The above SG list will have to be DMA'd in 2 sets:
> 
> (1) SG1 -> SG2 -> SG3 -> Null
> (2) SG4 -> SG5 -> SG6 -> Null
> 
> After (1) is succesfully transferred, the events from the MMC controller
> donot stop coming and are missed by the time we have setup the transfer
> for (2). So here, we catch the events missed as an error condition and
> issue them manually.

Are you sure there wont be any effect of these missed events on the
peripheral side. For example, wont McASP get into an underrun condition
when it encounters a null PaRAM set? Even UART has to transmit to a
particular baud so I guess it cannot wait like the way MMC/SD can.

Also, wont this lead to under-utilization of the peripheral bandwith?
Meaning, MMC/SD is ready with data but cannot transfer because the DMA
is waiting to be set-up.

Did you consider a ping-pong scheme with say three PaRAM sets per
channel? That way you can keep a continuous transfer going on from the
peripheral over the complete SG list.

Thanks,
Sekhar
