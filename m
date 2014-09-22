From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 22 Sep 2014 13:04:55 +0200
Subject: [PATCH] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <CAE0=X_1v_1eNr=dPTgofamFuy6zP9ff=LS7dyexj4CeutDqaPA@mail.gmail.com>
References: <1408967482-17723-1-git-send-email-anders.berg@avagotech.com>
 <20140920121242.GA3833@katana>
 <CAE0=X_0VQ8rWrUgbsgKm1MwCP8bwWm3UJPq9p=xNDfjP4CC7Bg@mail.gmail.com>
 <20140922095939.GB1406@katana>
 <CAE0=X_1v_1eNr=dPTgofamFuy6zP9ff=LS7dyexj4CeutDqaPA@mail.gmail.com>
Message-ID: <20140922110455.GA1463@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> >> +     if (msg->len == 0 || msg->len > 255)
> >> >> +             return -EINVAL;
> >> >
> >> > Ouch, really? Maybe we should warn the user here.
> >>
> >> Yeah, the transfer length register limits the length to 255. I'll add
> >> a warning here.
> >
> > Please also add this information to the Kconfig description and
> > somewhere at the top of the source file. This is an important flaw which
> > people should easily find out about.
> >
> 
> You are referring to the "len <= 255" restriction being the flaw here,
> right? I'll add a note to Kconfig and the driver about that.

Yes, I meant that. I just remembered we should do something else:

Remove I2C_FUNC_I2C (because it cannot do endless transfers) from
functionality and simply use I2C_FUNC_SMBUS_I2C_BLOCK which does I2C
like transfers with the SMBus Limit of 32 bytes. It seems PMBus allows
for 255 byte which this HW could support, yet I don't recall we have
support for that size currently.

> The other part of the condition (msg->len == 0) should actually go
> away. The controller can do zero-length-data transfers. I'll fix that
> for next round.

Great!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/1e878942/attachment.sig>
