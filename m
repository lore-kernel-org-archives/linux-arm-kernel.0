From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Aug 2015 12:00:18 +0100
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <20150806102225.GI7576@n2100.arm.linux.org.uk>
References: <55BEF4AF.5090704@ti.com> <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com> <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk>
Message-ID: <20150806110018.GS20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 11:22:25AM +0100, Russell King - ARM Linux wrote:

> If that's the case, then maybe you should consider whether using the SPI
> bus infrastructure is really the best way forward.  Would it make more
> sense instead to adopt a different software structure, something more
> high-level like:

>      +-------------------------------------------+
>      |          m25p80 high-level driver         |
>      +----------------------+--------------------+
>      |   SPI m25p80 driver  |                    |
>      +----------------------+                    |
>      |      SPI layer       |  Special driver    |
>      +----------------------+                    |
>      |    SPI bus driver    |                    |
>      +----------------------+--------------------+
>      |     SPI hardware     |  Special hardware  |
>      +----------------------+--------------------+

Yes, that's what's been talked about before - for some of these devices
they're sufficiently flash specialist that we just don't bother exposing
a SPI interface at all though AIUI they could be persuaded to do it.  It
isn't entirely clear that we want exactly that split, if the devices are
reasonable SPI controllers we will want to handle the case where they
have flash and non-flash devices on the same bus.  For that there is
going to be some generalisable work possible for managing switching
between memory mapped and SPI modes where those are mutually exclusive,
especially if the switch between them isn't free.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150806/c5de998c/attachment.sig>
