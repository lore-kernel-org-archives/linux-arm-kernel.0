From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 12 Dec 2015 17:20:57 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <2592093.cGKEcKVqLU@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2592093.cGKEcKVqLU@wuerfel>
Message-ID: <20151212162057.GA1530@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

thanks for looking into this, but I don't get your point yet.

> The slave_cb callback function is supposed to set the 'value'
> here,

Only if a master wants to READ from us.

> but it might return an error not assign the pointer,

An error is only returned if a WRITE from a master was not accepted by
the slave backend.

> It might be best to change the callback to return 'void' and not
> allow it to fail.

We need that because in case of an errno, the slave should send NACK to
the master instead of ACK.

> At least the eeprom slave cannot fail anyway, and it is the only
> implementation we have at the moment.

True. But giving a slave the possibility to NACK a write should be
present IMO.

> Alternatively, the  inline could return an error, and both bus
> drivers check for the error before using 'value'.

Hum, it does return an error?

	return client->slave_cb(client, event, val);

You probably mean something else?

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151212/232493e2/attachment.sig>
