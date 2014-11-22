From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 22 Nov 2014 19:12:29 +0100
Subject: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
In-Reply-To: <CAOY=C6FSXWn2AKn9gp0oU69U8VkkyJAE7MMUTZsToy0P_Tf6AA@mail.gmail.com>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <CAOY=C6FSXWn2AKn9gp0oU69U8VkkyJAE7MMUTZsToy0P_Tf6AA@mail.gmail.com>
Message-ID: <20141122181229.GB9698@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please quote only relevant parts of the message (like I did). This
improves readability a lot.

> > +static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
> > +                                    enum i2c_slave_event event, u8 *val)
> > +{
> > +       struct eeprom_data *eeprom = i2c_get_clientdata(client);
> > +
> > +       switch (event) {
> > +       case I2C_SLAVE_REQ_WRITE_END:
> > +               if (eeprom->first_write) {
> > +                       eeprom->buffer_idx = *val;
> > +                       eeprom->first_write = false;
> > +               } else {
> > +                       spin_lock(&eeprom->buffer_lock);
> > +                       eeprom->buffer[eeprom->buffer_idx++] = *val;
> > +                       spin_unlock(&eeprom->buffer_lock);
> > +               }
> > +               break;
> > +
> > +       case I2C_SLAVE_REQ_READ_START:
> > +               spin_lock(&eeprom->buffer_lock);
> > +               *val = eeprom->buffer[eeprom->buffer_idx];
> > +               spin_unlock(&eeprom->buffer_lock);
> > +               break;
> > +
> > +       case I2C_SLAVE_REQ_READ_END:
> > +               eeprom->buffer_idx++;
> > +               break;
> > +
> > +       case I2C_SLAVE_STOP:
> > +               eeprom->first_write = true;
> > +               break;
> > +
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> 
> Would it make sense to have:
> WRITE_START
> WRITE_NEXT
> WRITE_STOP
> WRITE_REPEAT_START
> READ_START
> READ_NEXT
> READ_STOP
> READ_REPEAT_START
> 
> Some devices may want different behavior for subsequent
> reads when they are separate transactions, compared to
> a single larger transaction.

This can all be handled with I2C_SLAVE_STOP.

> e.g. a single transaction may wraparound inside a >8bit
> register (e.g. for 16bit: msb, lsb, msb, lsb, ...), but step
> to the next register when a separate read/write is issued.
> Alternatively, a WRITE/READ_NEXT may be implemented
> more efficiently. This may not matter for current systems
> compared to the low-frequency bus, but who knows what
> IoT devices may bring to the table.

Let's start simple until we have more use cases. WRITE_NEXT may be
useful when you have an internal u8 pointer to be set before actually
sending data, but already less useful if this is u16. Also, slaves may
decide to handle stops at unexpected places differently. Furthermore, my
feeling is that slave drivers will be more robust if they handle those
simple primitives properly.

What I could imagine, though, is that somewhen the eeprom simulator will
be able to get data via other means than the shared memory, maybe via
some callback. Then, the callback really only has to deal with "read
this byte" or "write that byte" while for the outer world we have a
proper well-known EEPROM like I2C interface.

That being said, the list of I2C_SLAVE_* events is extensible, of
course. Though, I rather see low-level stuff there like "General Call
Adress received".

> 
> Also, behavior may be different for repeat start versus
> stop/start, although a repeat start could be a start
> without a previous stop as well...

IMO a repeated start is to ensure that two messages arrive at the slave
without interruption from another master. I can't think why a slave
should know which type of start that was. In fact, if it does that would
raise an eyebrow for me. Do you have an example?

> Of course, if an I2C adapter cannot distinguish these
> events, this is probably a futile attempt at adding
> semantics that will silently break depending on the
> actual hardware/driver used.

That as well. I have not seen an I2C adapter which could provide this
information so far.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141122/81e94b8d/attachment.sig>
