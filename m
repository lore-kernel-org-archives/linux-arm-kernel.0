From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 13 Jan 2017 09:37:27 +0100
Subject: [PATCH] i2c: i2c-cadence: Don't register the adapter until it's
 ready
In-Reply-To: <469bf72b-70e6-24d2-99b1-79b6f0a635bb@topic.nl>
References: <1483613240-32501-1-git-send-email-mike.looijmans@topic.nl>
 <428e8fc8-8b23-8e2c-763e-d977aaa98691@mleia.com>
 <469bf72b-70e6-24d2-99b1-79b6f0a635bb@topic.nl>
Message-ID: <20170113083727.GB1446@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I would argue that the "info" message means "the I2C adapter is ready for
> transaction now, and we'll start initializing devices on the bus". That is
> the case before it calls i2c_add_adapter().

I know what you mean, but i2c_add_adapter does more, and it can fail
because the adapter is *not* ready to transfer. Seeing the success
message before is also confusing.

> When i2c_add_adapter() runs, it will start probing devices on the bus. This
> yields very confusing output, as it will output things in a reversed order:
> 
> - device X on I2C bus
> - device Y on I2C bus
> - cdns-i2c ff030000.i2c: 100 kHz mmio ff030000 irq 197

I agree. That being said, somewhen I started working on moving such
messages into the core to save string space and have consistent output.
Then, we can print at the proper time.

So, until then, we should be consistent with the other driver, I'd say.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170113/8487324a/attachment.sig>
