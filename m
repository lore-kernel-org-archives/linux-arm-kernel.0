From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 27 Jul 2010 15:05:58 +0800
Subject: Issue with file transfers to a mass storage device on SMP system
In-Reply-To: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
Message-ID: <AANLkTinmwh3ZetA78xk9B27tq4fgnxN8Qu5pt0TBpuLX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/27 Maulik <x0082077@ti.com>:
> Hello,
>
> I am working on OMAP4 which has two ARM Cortex A9 microprocessors (SMP
> system) with 2.6.35-rc5 kernel.
>
> I have an issue whereby transferring a large file (>20MB) over USB (OMAP
> Mentor USB controller acts as USB host) to an attached USB thumb drive
> fails.
>
> The USB analyzer trace shows that the 31 bytes CBW packet is corrupted and
> device responds with a STALL when this issue occurs.
>
> Further it was found that the CBWCB field (the last 16 bytes which contains
> the command to be executed by the device) of the CBW packet was Zero in the
> failure case. Also the first 15 bytes of the CBW packet contained valid
> data.
>
> The code snippet below from usb_stor_Bulk_transport () in
> drivers/usb/storage/transport.c looks to be a problem area.
>
> /* copy the command payload */
>
> ?memset(bcb->CDB, 0, sizeof(bcb->CDB));
> ?memcpy(bcb->CDB, srb->cmnd, bcb->Length);
>
> Looks like when the issue occurs the memory (bcb->CDB) is not yet updated
> due to likely out of order execution due to SMP.
>
> I have tried below workarounds that fixes the issue.
>
> (1)Enabling debug prints / adding delays fixes the issue.
> (2)Using nosmp in bootargs i.e. disabling SMP fixes the issue.
> (3)Using wmb() (Write memory barrier) before starting DMA transfer in MUSB
> driver fixes the issue.

Seems it is one solution.

It should be caused by dma_alloc_coherent, which allocated uncached but
buffered coherent buffer, see discussions below:

          http://marc.info/?t=127918539100004&r=1&w=2

> (4)Using wmb() for only 31 bytes CBW packets after the memcpy(in storage
> stack (transport.c)) fixes the issue.
> (5)Checking if last 16 bytes (of the 31 bytes CBW packet) are Zero or not
> after the memcpy() also fixes the issue. i.e if you read back the memory,
> the memory seems to be updated.
>
> Has anyone seen such issue on a SMP system?
>
> Please comment on the need and the usage of a memory barrier in this case.
>
> Thanks,
> Maulik
>



-- 
Lei Ming
