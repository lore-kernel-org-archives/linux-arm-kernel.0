From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 18 May 2016 12:15:44 -0400 (EDT)
Subject: [PATCH] usb: echi-hcd: Add register access check in shutdown
In-Reply-To: <573C8B40.1040503@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1605181211120.1981-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 May 2016, Srinivas Kandagatla wrote:

> On 18/05/16 15:56, Alan Stern wrote:
> > On Wed, 18 May 2016, Srinivas Kandagatla wrote:
> >
> >> This patch adds a check in ehci_shutdown(), to make sure
> >> that the register access is available before accessing registers.
> >>
> >> The use case is simple, for boards like DB410c where the usb host
> >> or device functionality is decided based on the micro-usb cable
> >> presence. If the board boots up with micro-usb connected and the
> >> host driver is probed, but the ehci_setup() has not been done yet,
> >> then a system shutdown would trigger below NULL pointer exception
> >> without this patch.
> >
> > How can that happen?  While the host driver is probed, the probing
> > thread holds the device lock.  But the system shutdown routine acquires
> > the device lock before invoking the ->shutdown callback.  Therefore the
> > two things cannot happen concurrently.
> 
> No, I did not mean them happening concurrently, I mean that the host 
> driver is up, however ehci_setup() is not done yet.

I don't understand.  ehci_setup() is called as part of the probe 
procedure.  How can the host driver be up if ehci_setup() is not done 
yet?

Are you saying that when the system is plugged into the "B" end of an 
OTG cable, ehci_setup() doesn't get called at all?

And would the same thing happen if the system started out as the host
but then used HNP to change into the peripheral?

Alan Stern
