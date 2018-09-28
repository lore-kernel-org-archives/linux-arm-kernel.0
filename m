From: leoyang.li@nxp.com (Li Yang)
Date: Fri, 28 Sep 2018 16:00:52 -0500
Subject: drivers binding to device node with multiple compatible strings
In-Reply-To: <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
 <CAL_JsqKRH8uEzSx6H6ZSRJF9Ecp4am1cNsxgQqf2OO5_aGR1zw@mail.gmail.com>
Message-ID: <CADRPPNQam-QUfqDMvu42KS+50VaHfGPhCZj-1jRHQ-Od0fbxuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 3:07 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 27, 2018 at 5:25 PM Li Yang <leoyang.li@nxp.com> wrote:
> >
> > Hi Rob and Grant,
> >
> > Various device tree specs are recommending to include all the
> > potential compatible strings in the device node, with the order from
> > most specific to most general.  But it looks like Linux kernel doesn't
> > provide a way to bind the device to the most specific driver, however,
> > the first registered compatible driver will be bound.
> >
> > As more and more generic drivers are added to the Linux kernel, they
> > are competing with the more specific vendor drivers and causes problem
> > when both are built into the kernel.  I'm wondering if there is a
> > generic solution (or in plan) to make the most specific driver bound
> > to the device.   Or we have to disable the more general driver or
> > remove the more general compatible string from the device tree?
>
> It's been a known limitation for a long time. However, in practice it
> doesn't seem to be a common problem. Perhaps folks just remove the
> less specific compatible from their DT (though that's not ideal). For
> most modern bindings, there's so many other resources beyond
> compatible (clocks, resets, pinctrl, etc.) that there are few generic
> drivers that can work.
>
> I guess if we want to fix this, we'd need to have weighted matching in
> the driver core and unbind drivers when we get a better match. Though
> it could get messy if the better driver probe fails. Then we've got to
> rebind to the original driver.

Probably we can populate the platform devices from device tree after
the device_init phase?  So that all built-in drivers are already
registered when the devices are created and we can try find the best
match in one go?  For more specific loadable modules we probably need
to unbind from the old driver and bind to the new one.  But I agree
with you that it could be messy.

>
> Do you have a specific case where you hit this?

Maybe not a new issue but "snps,dw-pcie" is competing with various
"fsl,<chip>-pcie" compatibles.  Also a specific PHY
"ethernet-phy-idAAAA.BBBB" with generic "ethernet-phy-ieee802.3-c45".

Regards,
Leo
