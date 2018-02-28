From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 28 Feb 2018 17:56:18 +0100
Subject: [RFC 0/4] Add support for the Gateworks System Controller
In-Reply-To: <CAJ+vNU3hG7z1mB0xKFZu-8o1r3hj-pOqkfVnWHvxxaxzrpGuzw@mail.gmail.com>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <20180228144424.GC12303@lunn.ch>
 <CAJ+vNU3hG7z1mB0xKFZu-8o1r3hj-pOqkfVnWHvxxaxzrpGuzw@mail.gmail.com>
Message-ID: <20180228165618.GC29484@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim

Cool. I would say this is done right.

> One issue I'm trying to figure out the best way to deal with is the
> fact that the GSC can 'NAK' transactions occasionally which is why I
> override the regmap read/write functions and provide retries. This
> resolves the issue for the mfd core driver and sub-module drivers but
> doesn't resolve the issue with these 'emulated devices' which have
> their own stand-alone drivers. I'm not sure how to best deal with that
> yet. I tried to add retires to the i2c adapter but that wasn't
> accepted upstream because it was too generic and I was told I need to
> work around it in device-drivers.

How about writing an i2c bus driver which sits directly on top of
another i2c bus? Basically a one port i2c mux.

The current mux code does not seem to directly allow it, since it
calls i2c_transfer() directly on the parent, where as you want it to
call your own i2c_transfer function. But maybe you could expended the
core mux code to allow the i2c_mux_core structure to contain a transfer
function?

      Andrew
