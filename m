From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Aug 2015 11:22:25 +0100
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
References: <20150731181745.GM20873@sirena.org.uk> <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk> <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
Message-ID: <20150806102225.GI7576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 12:01:37PM +0200, Michal Suchanek wrote:
> Disclaimer: I am not familiar with the hardware for which this patch
> adds support.
> 
> However, I am familiar m25p80.c and as I understand it the controller
> is basically supposed to implement m25p80.c in hardware when this flag
> is set.

That, to me, sounds like what you have is:

---m25p80 specific interface--->SPI bus--->m25p80 device

Where the m25p80 specific interface does not expose direct access to the
SPI bus?

If that's the case, then maybe you should consider whether using the SPI
bus infrastructure is really the best way forward.  Would it make more
sense instead to adopt a different software structure, something more
high-level like:

     +-------------------------------------------+
     |          m25p80 high-level driver         |
     +----------------------+--------------------+
     |   SPI m25p80 driver  |                    |
     +----------------------+                    |
     |      SPI layer       |  Special driver    |
     +----------------------+                    |
     |    SPI bus driver    |                    |
     +----------------------+--------------------+
     |     SPI hardware     |  Special hardware  |
     +----------------------+--------------------+

Rather than what you seem to be trying to do, which seems to be:

     +----------------------+
     |   SPI m25p80 driver  |
     +----------------------+
     |      SPI layer       |
     +----------------------+
     |  Translation driver  |
     +----------------------+
     |   Special hardware   |
     +----------------------+

where this requires M25P80 specific hacks to be introduced into the SPI
layer so that you can communicate additional information between the SPI
M25P80 driver and the translation driver.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
