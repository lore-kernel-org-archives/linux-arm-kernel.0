From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 22 Nov 2014 19:26:30 +0100
Subject: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
In-Reply-To: <20141121071941.GK27002@pengutronix.de>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <20141121071941.GK27002@pengutronix.de>
Message-ID: <20141122182630.GD9698@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> this mail is thematically more a reply to patch 1 and maybe just serves
> my understanding of the slave support.

Sure. This shows how badly needed the documentation is :)

...
> > +		break;
> > +
> > +	case I2C_SLAVE_STOP:
> > +		eeprom->first_write = true;
> > +		break;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> This is the most interesting function here because it uses the new
> interface, the functions below are only to update and show the simulated
> eeprom contents and driver boilerplate, right?

Yes.

> When the eeprom driver is probed and the adapter driver notices a read
> request for the respective i2c address, this callback is called with
> event=I2C_SLAVE_REQ_READ_START. Returning 0 here and provide the first
> byte to send make the adapter ack the read request and send the data
> provided. If something != 0 is returned a NAK is sent?

We only send NAK on write requests (I use read/write from the master
perspective). Then, we have to say if the received byte was successfully
processed. When reading, the master has to ack the successful reception
of the byte.

> How is the next byte requested from the slave driver? I assume with two
> additional calls to the callback, first with
> event=I2C_SLAVE_REQ_READ_END, then event=I2C_SLAVE_REQ_READ_START once
> more. Would it make sense to reduce this to a single call? Does the
> driver at READ_END time already know if its write got acked? If so, how?

No single call. I had this first, but my experiments showed that it is
important for the EEPROM driver to only increase the internal pointer
when the byte was ACKed. Otherwise, I was off-by-one.

Ideally, I2C_SLAVE_REQ_READ_END should be used when the master ACKed the
byte, right. However, the rcar hardware doesn't have an interrupt for
this, so I imply that the start of a new read request ends the old one.
I probably should add a comment for that.

> This means that for each byte the callback is called. Would it make
> sense to make the API more flexible and allow the slave driver to return
> a buffer? This would remove some callback overhead and might allow to
> let the adapter driver make use of its DMA mechanism.

For DMA, I haven't seen DMA slave support yet. Makes sense to me, we
wouldn't know the transfer size, since the master can send a stop
anytime. This makes possible gains of using a buffer also speculative.
Also, I2C is still a low-bandwith bus, so usually we have a high number
of small transfers.

For now, I'd skip this idea. As I said in another thread, we need more
use cases. If the need arises, we can come up with something. I don't
think the current design prevents such an addition?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141122/1ce38536/attachment.sig>
