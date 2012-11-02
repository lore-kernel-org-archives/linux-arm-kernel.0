From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Nov 2012 10:54:47 +0200
Subject: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
In-Reply-To: <20121101222316.GC22956@pengutronix.de>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
 <20121101222316.GC22956@pengutronix.de>
Message-ID: <20121102085447.GE17063@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 01, 2012 at 11:23:16PM +0100, Wolfram Sang wrote:
> On Thu, Oct 25, 2012 at 12:00:48PM +0300, Felipe Balbi wrote:
> > if we allow compiler reorder our writes, we could
> > fall into a situation where dev->buf_len is reset
> > for no apparent reason.
> > 
> > This bug was found with a simple script which would
> > transfer data to an i2c client from 1 to 1024 bytes
> > (a simple for loop), when we got to transfer sizes
> > bigger than the fifo size, dev->buf_len was reset
> > to zero before we had an oportunity to handle XDR
> > Interrupt. Because dev->buf_len was zero, we entered
> > omap_i2c_transmit_data() to transfer zero bytes,
> > which would mean we would just silently exit
> > omap_i2c_transmit_data() without actually writing
> > anything to DATA register. That would cause XDR
> > IRQ to trigger forever and we would never transfer
> > the remaining bytes.
> > 
> > After adding the memory barrier, we also drop resetting
> > dev->buf_len to zero in omap_i2c_xfer_msg() because
> > both omap_i2c_transmit_data() and omap_i2c_receive_data()
> > will act until dev->buf_len reaches zero, rendering the
> > other write in omap_i2c_xfer_msg() redundant.
> > 
> > This patch has been tested with pandaboard for a few
> > iterations of the script mentioned above.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > This bug has been there forever, but it's quite annoying.
> > I think it deserves being pushed upstream during this -rc
> > cycle, but if Wolfram decides to wait until v3.8, I don't
> > mind.
> 
> I would add this into 3.7, but what about the comments suggesting to use
> barrier()?

I was waiting for more comments, will respin the patch next week.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/1206e9bb/attachment.sig>
