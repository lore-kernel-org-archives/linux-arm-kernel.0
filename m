From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 24 Jul 2015 12:52:51 +0200
Subject: [PATCH v3 1/4] i2c: tegra: implement slave mode
In-Reply-To: <55B210F4.6030700@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <1437424546-30405-2-git-send-email-danindrey@mail.ru>
 <20150724092720.GA1597@katana> <55B210F4.6030700@mail.ru>
Message-ID: <20150724105251.GA22787@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> At the begin of my work on this patchset I even denied clock disable call if
> slave is registered (to minimize code that can affect transfer).

I hacked something like this, but it seems it was not enough.

> If only slave mode is used, then this logic is not needed.

This is not sufficent. We shouldn't break being a master only because we
also listen to a slave address (as long as the HW supports that of
course).

> tegra_i2c_init is called on probe and resume. Also it is called in case of
> xfer fail. If xfer is ok, then I think slave addr must be kept unchanged.

This is fragile. Try scanning the bus with i2cdetect and slave setup
will be gone.

> As far as I understand it is a loopback mode. Probably it will not work
> (Stephen Warren already mentioned this).

Just to make clear: I am not saying we should support talking to our own
slave address. But it should still be possible to communicate with other
remote devices on the bus.

Thanks,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/cf826f2c/attachment.sig>
