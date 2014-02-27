From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Feb 2014 15:34:27 -0600
Subject: [PATCH v12 1/4] PHY: Add function set_speed to generic PHY
 framework
In-Reply-To: <CAPw-ZT=7cu1NoxrBL48RUJV04ofrnNkF=p=23VFfu8ZZWmkQWQ@mail.gmail.com>
References: <1393524848-8207-1-git-send-email-lho@apm.com>
 <1393524848-8207-2-git-send-email-lho@apm.com>
 <20140227190102.GB4862@saruman.home>
 <CAPw-ZT=F07=T0=z=iT=hxJ0+609RBDYRL=MXF5dQoEowLjsRjQ@mail.gmail.com>
 <20140227205039.GE5375@saruman.home>
 <CAPw-ZT=7cu1NoxrBL48RUJV04ofrnNkF=p=23VFfu8ZZWmkQWQ@mail.gmail.com>
Message-ID: <20140227213427.GG5375@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 27, 2014 at 01:09:57PM -0800, Loc Ho wrote:
> >> >> This patch adds function set_speed to the generic PHY framework operation
> >> >> structure. This function can be called to instruct the PHY underlying layer
> >> >> at specified lane to configure for specified speed in hertz.
> >> >
> >> > why ? looks like clk_set_rate() is your friend here. Can you be more
> >> > descriptive of the use case ? When will this be used ?
> >> >
> >>
> >> The phy_set_speed is used to configure the operation speed of the PHY
> >> at run-time. The clock interface in general is used to configure the
> >> clock input to the IP. I don't believe they are the same thing. Maybe
> >> it will be clear in my response to your second email
> >
> > The problem with this is that you end up adding SATA-specific details to
> > something which is supposed to be generic.
> 
> Setting the operation speed is pretty generic from an interface point
> of view. An generic multi-purpose PHY can support multiple speed. If

no it's not. Specially when you consider that your "speed" argument can
be just about anything and depending on the underlying bus, it *will* be
treated differently. Note that e.g. in OMAP devices the exact *same* PHY
IP is used for PCIe, SATA and USB... now, let's assume for the sake of
argument that we were to implement ->set_speed() in that environment,
how do you plan to do that ? a 6MHz arguments isn't valid from USB stand
point and could mean different things in PCIe or SATA.

> the upper layer wish to operate at an specified speed (say for testing
> purpose and etc), it can be allowed.

anything for testing purposes, should be limited to test scenarios.

> > After negoatiation, don't you
> > get any interrupt from your PHY indicating that link speed negotiation
> > is done ? Or is that IRQ only on AHCI IP ?
> 
> There is NO interrupt from the PHY. The IRQ is assoicated with the
> AHCI IP. With SATA host flow, it starts off with an COMRESET to start
> the link negotiation. At that point, it will poll for completion.
> 
> Any other concerns?

hey, calm down... just trying to prevent us from applying something
which isn't truly generic and I don't think "->set_speed" is generic
enough. The semantics of the "speed" argument won't be valid for all use
cases.

I can already see people using that to pass
USB_SPEED_{LOW,FULL,HIGH,SUPER}, instead of actual speed numbers. We wil
end up with a mess to handle from a PHY driver, specially in cases such
as OMAP where, as mentioned above, the same IP is used for SATA, PCIe
and USB3.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/ac781324/attachment.sig>
