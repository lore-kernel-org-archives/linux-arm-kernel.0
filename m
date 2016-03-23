From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Mar 2016 14:26:37 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F295E1.4030505@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de> <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de>
Message-ID: <20160323132637.GC19953@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 02:10:57PM +0100, Stefan Roese wrote:
> Hi Mark,
> 
> On 23.03.2016 13:54, Mark Brown wrote:
> > On Wed, Mar 23, 2016 at 12:59:40PM +0100, Stefan Roese wrote:
> >> On 23.03.2016 12:33, Mark Brown wrote:
> > 
> >>> No, there's two separate things here.  The big problem with what you
> >>> originally sent was that you were defining a window per SPI device but
> >>> this is a part of the SPI controller so having to change windows per
> >>> device is just going to make the code more complex.
> > 
> >> I'm sorry, but this sentence is not totally clear to me: Do you mean
> >> that the "more complex" code in v2 with the MBus window reconfiguration
> >> is not good? Or do you mean that in the RFC version, the switching
> >> between the SPI devices was too complex?
> > 
> > I haven't looked at your new code at all.  What I'm saying is that
> > specifying a per-device MBus window seems like pointless complexity.
> 
> I don't necessarily share this opinions. Code-wise, its less complex
> that re-configuring (removing the old and creating the new) the MBus
> window. But I have no strong feeling here. Whatever is decided that
> should be used, I can go with.
> 
> Thomas, Arnd (or anyone else?), do you have any comments or preferences
> which way to go here?

Hi Stefan

The number of windows is limited. On i think the Armada XP, if you put
a PCIe device on every available PCIe bus, you can run out of
windows. This is why Thomas implemented dynamic allocation of the
Windows, so that only those that are needed are used.

So i would not statically and globally allocate as many windows as
possible SPI devices.

The fact that SPI can fall back to another mechanism if there are no
available windows, were as PCIe cannot, suggests that SPI should
dynamically allocate a window, and be prepared for it to fail.

Since only one SPI device can be active at once on a SPI bus, one
window per bus makes sense, and keeps the required number of windows
to a minimum.

   Andrew
