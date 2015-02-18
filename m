From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 16:15:01 +0100
Subject: [PATCH 1/2] phy: usbphy: Add dt documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <54E3AD2E.8050902@broadcom.com>
References: <1424200821-16368-1-git-send-email-arun.ramamurthy@broadcom.com>
 <2797126.uqvyZJisPk@wuerfel> <54E3AD2E.8050902@broadcom.com>
Message-ID: <11865413.8NsXkQ6AUR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 February 2015 13:05:50 Arun Ramamurthy wrote:
> On 15-02-17 12:53 PM, Arnd Bergmann wrote:
> > On Tuesday 17 February 2015 12:00:49 Arun Ramamurthy wrote:
> >> Arnd, I patched the ehci and ohci driver to accept multiple phys so they
> >> require different names and cannot both be "usb". That patch was
> >> accepted by Alen Stern but I did not update the bindings documentation.
> >> I will send out another patch for that. Could we go with the naming
> >> scheme of "usb" + "p" + port number or do you have other suggestions?
> >
> > I don't have a good idea, but I think it would be best if the first
> > phy could remain named "usb" for compatibility with the existing binding.
> >
> The patch was written in a way that all the existing and new drivers can
> continue to use "usb" if they are using only one phy so that we remain 
> compatible. The names need to be different only if more than one phy is 
> specified. In such cases i don't think the first phy should be "usb" as 
> it would be confusing to have
>         phy-names = "usb","usbp1"

I see your patch now, as 7e7a0e67f2c ("usb: ehci-platform: add support for
multiple phys per controller"), and I'm not too happy about the way you
did this.

We already concluded that there should have been a binding change
to go along with this, and that would have caught the fact that you
circumvent the API here by reading the phy names manually. That
part should never have made it into the kernel.

I think we can do this either by defining specific names for the
phy, or by changing the generic PHY binding to allow anonymous
phy references (leaving out "phy-names" entirely), and adding a
proper API for that.

> Should I run this by Alan Stern?

I've added him to Cc here. He clearly didn't know the background about
the DT binding change, and should not need to, but he may have an opinion
on what names we should use.

> > What is the reason for having two phys in your case? Are these
> > identical phy devices connected to a single controller or do they
> > server different purposes?
> >
> Yes, we have three identical phys connected to a single host controller 
> and one of the phys is also connected to the device controller

Ok, no problem with that, let's just make sure we come up with a
good binding for it.

	Arnd
