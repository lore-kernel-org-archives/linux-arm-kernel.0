From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Nov 2014 21:40:01 +0100
Subject: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
In-Reply-To: <20141123202008.GE4431@pengutronix.de>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <20141121071941.GK27002@pengutronix.de>
 <20141122182630.GD9698@katana>
 <20141123202008.GE4431@pengutronix.de>
Message-ID: <20141124204001.GB26751@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > When the eeprom driver is probed and the adapter driver notices a read
> > > request for the respective i2c address, this callback is called with
> > > event=I2C_SLAVE_REQ_READ_START. Returning 0 here and provide the first
> > > byte to send make the adapter ack the read request and send the data
> > > provided. If something != 0 is returned a NAK is sent?
> > 
> > We only send NAK on write requests (I use read/write from the master
> I don't understand this. Who is "we" in this case? 

We as the slave serving the request of a remote master.

> > No single call. I had this first, but my experiments showed that it is
> > important for the EEPROM driver to only increase the internal pointer
> > when the byte was ACKed. Otherwise, I was off-by-one.
> Sure, the driver has to know how his read response was received by the
> master. But assuming I understand your abstraction right there is some
> redundancy. There are only three cases on a read request (well plus error
> handling):
> 
>  - master sends ACK, reads next byte
>    in this case the slave must provide another word
>    In your abstraction this implies
>      callback(I2C_SLAVE_REQ_READ_END); <-- this is redundant

Well, in the way that a new start of something means automatically the
end of the previous something, like some closing html tags which can be
left out. However, I think being explicit here isn't much of a drawback.
You lose a little bit of performance and gain flexibility. A sensor-like
device could decide that on READ_END it is safe to discard the old value
and start acquiring the new one, so it will be available on next
READ_START. Be aware that the master decides how much time there will be
between END and START (although it will be very close in most cases).

>      callback(I2C_SLAVE_REQ_READ_START);
> 
>  - master sends ACK, then P or Sr
>      callback(I2C_SLAVE_REQ_READ_END);
>      maybe callback(I2C_SLAVE_STOP)
> 
>  - master sends NACK
>    in this case the message ends and the master has to send Sr or P.
>    In your case this results in:
>      nothing for the NACK?
>      maybe callback(I2C_SLAVE_STOP)
> 
> The situations where the slave has to react are:
> 
>  - slave was addressed with R
>    input: address
>    output: NAK or (ACK + data byte)
>  - slave was addressed with #W:
>    input: address
>    output: NAK or ACK

On most slave IP cores I have seen so far, there is nothing to do for a
slave driver for those two. Address recognition and sending ACK are all
done by the hardware and you are notified of that by an interrupt. For
the read case, you have to deliver the first byte, of course.


>  - data sent by slave-transmitter was acked
>    output: next data byte (maybe unused because master sends Sr or P)

The driver I modified in the next patch cannot know if the master
acked/nacked something. It just knows if the output buffer is empty or
if a stop was signalled (which really should come after NAK from the
master). So, we can't depend on this difference.

>  - data sent by slave-transmitter was nacked
>    output: void (unless we want to support IGNORE_NAK :-)

:)

>  - slave received a data byte (write)
>    input: data
>    output: NAK or ACK
> 
> This looks like a better model in my eyes. In this model the slave
> driver doesn't even need to be informed about P. Not entirely sure about
> "data sent by slave-transmitter was nacked".

I think we definately need a STOP notification. Devices might want to do
something like reducing power etc after stop.

What I like about my version is that it reflects pretty closely what
happens on the bus. I can't currently tell what somebody could do with
WRITE_START (precharging something?). But it feels better to me to
directly reflect what a real slave device would see, too, for
flexibility.

> 
> > For DMA, I haven't seen DMA slave support yet. Makes sense to me, we
> haha, there is only a single slave driver yet and you're the author.

I meant IP cores here which support DMA for slave transmissions.

Regardings buffers: I wouldn't like all bus drivers to have code
handling the buffer when all they have to do is to put one byte on the
bus. So, buffer handling should go into the core then probably. So,
there'd be still one level of indirection?

Also, since we don't know when the master will collect the data, there
is a chance it might get stale?

To me that sounds like too much complexity for too litle gain. At this
moment, at least.

Regards,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/75f2a442/attachment.sig>
