From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 18 Jan 2014 21:49:22 -0500 (EST)
Subject: [PATCH v7 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <52DAA9F4.2090601@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1401182131290.28218-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 Jan 2014, Hans de Goede wrote:

> > A simple copy from the PPC driver isn't quite enough, because the
> > platform data settings would override the DT values.
> > ehci_platform_reset has to be changed so that it sets
> > ehci->big_endian_desc and _mmio if the pdata flags are set, but
> > otherwise leaves them alone.
> >
> > Hans, would you like to write another patch to take care of this?
> 
> I already took a quick look at this, setting the ehci->big_endian* flags is easy,
> the problem is that they won't work unless we also define
> CONFIG_USB_EHCI_BIG_ENDIAN_DESC and CONFIG_USB_EHCI_BIG_ENDIAN_MMIO

That's right.  The platforms have to define those symbols if they use 
big-endian values (or even worse, mixed endian).

> I would like to avoid doing something like the ugliness we've with
> USB_OHCI_HCD_PPC_OF_BE and USB_OHCI_HCD_PPC_OF_LE, which means just selecting these
> 2 config options whenever USB_EHCI_HCD_PLATFORM is enabled, but I'm not sure if that
> is acceptable.

At the moment, I don't think it's so terrible.  That ohci_ppc ugliness
probably could have been avoided originally.  It looks like an attempt
to make sure you don't end up matching the hardware to a driver built
with the wrong endianness.  I imagine it would be less messy to detect 
that sort of problem at runtime.

> The same goes for the ohci code btw.

Certainly.

Alan Stern
