From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 26 Nov 2014 13:22:50 +0100
Subject: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
In-Reply-To: <CAOY=C6F6TMyeDvNneBV6K5hVjoG+qk-1Y_R3oJkEiGxhLOoQ0A@mail.gmail.com>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <CAOY=C6FSXWn2AKn9gp0oU69U8VkkyJAE7MMUTZsToy0P_Tf6AA@mail.gmail.com>
 <20141122181229.GB9698@katana>
 <CAOY=C6F6TMyeDvNneBV6K5hVjoG+qk-1Y_R3oJkEiGxhLOoQ0A@mail.gmail.com>
Message-ID: <20141126122250.GA4397@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> My bad, will minimize the overhead in the future.

Thanks!

> I think usable semantics could be that a slave driver can indicate at any
> point during an I2C read transaction that the next X bytes should be
> returned from a buffer and for a write transaction, that the next X bytes
> should be buffered before passed on to the driver. When the transaction

Yes, if we have something like that it should definately be that the
slave driver offers a buffer and the bus driver may accept the buffer or
not. Buffers should be opt-in and slave drivers will always have to
support byte-based transactions as the ultimate fallback because this is
how the vast majority of HW works (at least those I checked).

That makes me really wonder if there will be a case where performance is
so important that buffer handling is coded on top of the always needed
byte based handling?

More so, I'd think most slaves will have stuff like registers. So,
buffered writes usually won't make sense because setting bits should
cause an action immediately. And reading bits will have the problem of
data getting stale. I'd think this is the biggest use case of I2C.
Except for reading an EEPROM _once_ ;)

> ends or the adapter reaches the end of the buffer, it indicates this to
> the driver which can then either cleanup or otherwise act accordingly.

Or the adapter encounters an unexpected STOP. Cleanups need to handle
interrupted transactions as well. I'd think this is a bit more error
prone, because people would need to check a return value and compare it
to the number of bytes they wanted. Not a show stopper, but also nothing
I want to throw in too easily.

> But as you say, this can be added later on when the need arises.

I'd really say so.

> Just checked components we're using and stop/repeated-start both
> transition into the same state.

Good, thanks for checking! May I ask which components you are using?

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/daf55b27/attachment.sig>
