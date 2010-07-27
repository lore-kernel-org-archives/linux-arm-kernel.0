From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jul 2010 11:01:21 +0100
Subject: Issue with file transfers to a mass storage device on SMP system
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
References: <00e601cb2d55$cb6253c0$808918ac@apr.dhcp.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C62EF707@dbde02.ent.ti.com>
Message-ID: <20100727100121.GB7846@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 27, 2010 at 03:08:54PM +0530, Shilimkar, Santosh wrote:
> As discussed, the main reason is the cache maintenance isn't done on
>  "bcb->CDB"  buffers and hence the data remains in CPU write buffer
> instead of the physical memory on which DMA operates. 

struct bulk_cb_wrap {
        __le32  Signature;              /* contains 'USBC' */
        __u32   Tag;                    /* unique per command id */
        __le32  DataTransferLength;     /* size of data */
        __u8    Flags;                  /* direction in bit 0 */
        __u8    Lun;                    /* LUN normally 0 */
        __u8    Length;                 /* of of the CDB */
        __u8    CDB[16];                /* max command */
};

So, CDB is contained within bcb...bcb+sizeof(*bcb).

The bcb is passed to usb_stor_bulk_transfer_buf:

        result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
                                bcb, cbwlen, NULL);

which fills it into a URB:

        usb_fill_bulk_urb(us->current_urb, us->pusb_dev, pipe, buf, length,
                      usb_stor_blocking_completion, NULL);

This sets the URB buffer pointers:

        urb->transfer_buffer = transfer_buffer;
        urb->transfer_buffer_length = buffer_length;

And this buffer should be dma-mapped and dma-unmapped as appropriate.

Wasn't there an issue with the DMA mapping being used with a PIO USB
host recently?  Is that the problem here?
