From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 13:18:29 -0500
Subject: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
In-Reply-To: <CAPDyKFqpoi03Egfuvd8qJXnn_+FBgPXAb7S4UvkxVs8BA+zwnA@mail.gmail.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <20160505224240.GA31429@rob-hp-laptop>
 <CAPDyKFqpoi03Egfuvd8qJXnn_+FBgPXAb7S4UvkxVs8BA+zwnA@mail.gmail.com>
Message-ID: <20160509181829.GA19687@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 09:46:40AM +0200, Ulf Hansson wrote:
> On 6 May 2016 at 00:42, Rob Herring <robh@kernel.org> wrote:
> > On Thu, May 05, 2016 at 02:34:13PM +0200, Krzysztof Kozlowski wrote:
> >> Hi,
> >>
> >> This is a different, second try to fix usb3503+lan on Odroid U3 board
> >> if it was initialized by bootloader (e.g. for TFTP boot).
> >>
> >> First version:
> >> http://www.spinics.net/lists/linux-usb/msg140042.html
> >>
> >>
> >> Problem
> >> =======
> >> When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
> >> the usb3503 and LAN smsc95xx do not show up in "lsusb". Hard-reset
> >> is required, e.g. by suspend to RAM. The actual TFTP boot does
> >> not have to happen. Just "usb start" from U-Boot is sufficient.
> >>
> >> From the schematics, the regulator is a supply only to LAN, however
> >> without toggling it off/on, the usb3503 hub won appear neither.
> >>
> >>
> >> Solution
> >> ========
> >> This is very similar to the MMC pwrseq behavior so the idea is to:
> >> 1. Move MMC pwrseq drivers to generic place,
> >
> > You can do that, but I'm going to NAK any use of pwrseq bindings outside
> > of MMC. I think it is the wrong way to do things. The DT should describe
> 
> Huh, I didn't know that was your view of the mmc pwrseq bindings. Why
> didn't you NAK them before?

Unfortunately, either I missed it or it was a time I couldn't spend much 
time on reviews.

> > the devices. If they happen to be "simple" then the core can walk the
> > tree and do any setup. For example, look for "reset-gpios" and toggle
> > that GPIO. There is no need for a special node.
> >
> >> 2. Extend the pwrseq-simple with regulator toggling,
> >> 3. Add support to USB hub and port core for pwrseq,
> >
> > We discussed this for USB already[1] and is why we defined how to add
> > USB child devices. The idea is not to add pwrseq to that.
> 
> I am not familiar with the USB discussion.
> 
> Still, let me give you some more background to the mmc pwrseq. The
> idea from the mmc pwrseq bindings comes from the power-domain DT
> bindings, as I thought these things were a bit related.
> In both cases they are not directly a property of the device, but more
> describing a HW dependency to allow the device to work.

I could see this as a board level power domain. However the difference 
is we are not generally exposing internal SOC details the same way as 
board level components. Perhaps we could extend power domains to board 
level, but that is not what was done here.

> One could probably use a child node instead of a phandle, but that
> wasn't chosen back then. Of course you are the DT expert, but could
> you perhaps tell me why a child node is better for cases like this?

If there is a control path hierarchy, then we try to model that in DT 
with child nodes. In cases of SDIO and USB, there is a clear hierarchy. 
Ignoring the discovery ordering problem, we already have defined ways to 
describe GPIO connections, regulators, etc. to devices. Describing those 
things separately from the device to solve a particular issue that is 
really a kernel limitation is what I don't like.

Rob
