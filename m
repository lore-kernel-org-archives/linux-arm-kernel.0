From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 11 Oct 2016 11:51:14 -0700
Subject: [PATCH 3/5] Input: add driver for Ilitek ili2139 touch IC
In-Reply-To: <220181476210841@web5j.yandex.ru>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
 <20161011003359.26079-3-icenowy@aosc.xyz>
 <20161011174046.GA27925@dtor-ws> <220181476210841@web5j.yandex.ru>
Message-ID: <20161011185114.GB8841@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 02:34:01AM +0800, Icenowy Zheng wrote:
> 
> 
> 12.10.2016, 01:40, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>:
> > Hi Icenowy,
> >
> > On Tue, Oct 11, 2016 at 08:33:57AM +0800, Icenowy Zheng wrote:
> >> ?This driver adds support for Ilitek ili2139 touch IC, which is used in
> >> ?several Colorfly tablets (for example, Colorfly E708 Q1, which is an
> >> ?Allwinner A31s tablet with mainline kernel support).
> >>
> >> ?Theortically it may support more Ilitek touch ICs, however, only ili2139
> >> ?is used in any mainlined device.
> >>
> >> ?It supports device tree enumeration, with screen resolution and axis
> >> ?quirks configurable.
> >>
> >> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >
> > Please extend ili210x.c instead of adding brand new driver, they look
> > very similar.
> >
> > Thanks.
> 
> The driver is too old, lack of maintaince and needs some platform data hacks.
> (At least makes it not capable to be used on current ARM devices, as they're
> described with device tree)

There are many drivers that can do both platform and dt-setup.

> 
> Maybe I will rename the new driver modified by me to ili210x, add support for
> the old protocol (but I have no chips to test it), and drop the old ili210x.
> (This driver is capable of dt probing, and uses devm_ functions)

You can add "racy on removal" to the list (you need to take care your
work is canceled at right times, and canceling it before interrupt is
freed is not the right time as interrupt might fire and the work get
scheduled again). Also I think your driver is essentially working in
polling mode because you always reschedule the delayed work.

No, like I said, please work with existing driver, adding DT support and
support for the newer version of the protocol.

Thanks.

-- 
Dmitry
