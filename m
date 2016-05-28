From: hzpeterchen@gmail.com (Peter Chen)
Date: Sat, 28 May 2016 11:36:13 +0800
Subject: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
In-Reply-To: <CAPDyKFq2=mqujFjvJSYxg2nVmK=OrBKLtFfb-ErNJO3Zr_LMVw@mail.gmail.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <20160505224240.GA31429@rob-hp-laptop>
 <CAPDyKFqpoi03Egfuvd8qJXnn_+FBgPXAb7S4UvkxVs8BA+zwnA@mail.gmail.com>
 <20160509181829.GA19687@rob-hp-laptop>
 <CAPDyKFq2=mqujFjvJSYxg2nVmK=OrBKLtFfb-ErNJO3Zr_LMVw@mail.gmail.com>
Message-ID: <20160528033613.GA3291@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 01:02:08PM +0200, Ulf Hansson wrote:
> + Arnd
> 
> [...]
> 
> >> >> Solution
> >> >> ========
> >> >> This is very similar to the MMC pwrseq behavior so the idea is to:
> >> >> 1. Move MMC pwrseq drivers to generic place,
> >> >
> >> > You can do that, but I'm going to NAK any use of pwrseq bindings outside
> >> > of MMC. I think it is the wrong way to do things. The DT should describe
> >>
> >> Huh, I didn't know that was your view of the mmc pwrseq bindings. Why
> >> didn't you NAK them before?
> >
> > Unfortunately, either I missed it or it was a time I couldn't spend much
> > time on reviews.
> 
> Okay, I guess it's common issue among maintainers. The problem with DT
> is that it gets really hard to be fixed up later. :-)
> 
> >
> >> > the devices. If they happen to be "simple" then the core can walk the
> >> > tree and do any setup. For example, look for "reset-gpios" and toggle
> >> > that GPIO. There is no need for a special node.
> >> >
> >> >> 2. Extend the pwrseq-simple with regulator toggling,
> >> >> 3. Add support to USB hub and port core for pwrseq,
> >> >
> >> > We discussed this for USB already[1] and is why we defined how to add
> >> > USB child devices. The idea is not to add pwrseq to that.
> >>
> >> I am not familiar with the USB discussion.
> >>
> >> Still, let me give you some more background to the mmc pwrseq. The
> >> idea from the mmc pwrseq bindings comes from the power-domain DT
> >> bindings, as I thought these things were a bit related.
> >> In both cases they are not directly a property of the device, but more
> >> describing a HW dependency to allow the device to work.
> >
> > I could see this as a board level power domain. However the difference
> > is we are not generally exposing internal SOC details the same way as
> > board level components. Perhaps we could extend power domains to board
> > level, but that is not what was done here.
> >
> >> One could probably use a child node instead of a phandle, but that
> >> wasn't chosen back then. Of course you are the DT expert, but could
> >> you perhaps tell me why a child node is better for cases like this?
> >
> > If there is a control path hierarchy, then we try to model that in DT
> > with child nodes. In cases of SDIO and USB, there is a clear hierarchy.
> > Ignoring the discovery ordering problem, we already have defined ways to
> > describe GPIO connections, regulators, etc. to devices. Describing those
> > things separately from the device to solve a particular issue that is
> > really a kernel limitation is what I don't like.
> 
> Okay, I see.
> 
> To move forward in trying to make mmc pwrseq a generic pwrseq, could
> we perhaps allow both cases?
> 
> In the mmc case, there are already deployed bindings so we need to
> cope with these by using the phandle option, but for USB etc we could
> force the child node option.
> As long as we agree that we keep using a compatible string for the
> child node as well, both options should be able to co-exist and we
> should probably be able to managed them both from a common pwrseq
> driver framework.
> 
> Although, I do remember from an older conversations around some of
> mine submission for the mmc pwrseq code, that some people (maybe
> Arnd?) wasn't keen on adding a new framework for this. Perhaps that
> has changed?
> 

All, how we move on for this?

1. Using a generic driver to manage both mmc and USB (and further
subsystem), USB and further subsystem do not use pwrseq node in dts.
2. USB creates the similar driver under drivers/usb for its own use. 

Which one do you prefer, thanks.

-- 

Best Regards,
Peter Chen
