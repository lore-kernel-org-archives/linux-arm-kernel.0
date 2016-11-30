From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 30 Nov 2016 10:47:26 +0100
Subject: [PATCH net-next v4 0/4] Fix OdroidC2 Gigabit Tx link issue
In-Reply-To: <049b1efc-3bad-92e0-45ef-0563dc5d81de@gmail.com>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
 <049b1efc-3bad-92e0-45ef-0563dc5d81de@gmail.com>
Message-ID: <1480499246.17538.208.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-11-28 at 09:54 -0800, Florian Fainelli wrote:
> On 11/28/2016 07:50 AM, Jerome Brunet wrote:
> > 
> > This patchset fixes an issue with the OdroidC2 board (DWMAC +
> > RTL8211F).
> > The platform seems to enter LPI on the Rx path too often while
> > performing
> > relatively high TX transfer. This eventually break the link (both
> > Tx and
> > Rx), and require to bring the interface down and up again to get
> > the Rx
> > path working again.
> > 
> > The root cause of this issue is not fully understood yet but
> > disabling EEE
> > advertisement on the PHY prevent this feature to be negotiated.
> > With this change, the link is stable and reliable, with the
> > expected
> > throughput performance.
> > 
> > The patchset adds options in the generic phy driver to disable EEE
> > advertisement, through device tree. The way it is done is very
> > similar
> > to the handling of the max-speed property.
> > 
> > Patch 4 is provided here for testing purpose only. Please don't
> > merge
> > patch 4, this change will go through the amlogic's tree.
> 
> Sorry, but I really don't like the route this is going, and I should
> have made myself clearer before on that, I really think utilizing a
> PHY
> fixup is more appropriate here than an extremely generic DT property.
> The fixup code can be in the affected PHY driver, or it can be
> somewhere
> else, your call. There is no shortage of option on how to implement
> it,
> and this would be something easy to enable/disable for known good
> configurations (ala PCI/USB fixups).
> 
> If we start supporting generic "enable", "disable" type of properties
> with values that map directly to register definitions of the HW, we
> leave too much room for these properties to be utilized to implement
> a
> specific policy, and this is not acceptable.

Florian,?

I agree that DT should not be used to setup a policy, but to describe
what the HW is.

I tried to implement it the way you suggested, using phy fixup, too see
what it looks like.
There is 2 places in the code that seems (remotely) linked to the
issue:?
- meson8b_dwmac driver : if the mac, regardless of the board/platform,
?could not tolerate to have EEE activated, it would make sense to have
the fixup here. It can provide a C callback for such case.
- realtek phy driver: philosophy is kind of the same

To be clear, it is doable and it works that way, but I don't think
embedding this directly in the code is the right way to do it. It seems
we are hiding an information specific about the board inside a generic
driver.

We have several amlogic's design with the same MAC, sometimes with the
same PHY, which have no problem with EEE at all. The issue is really
about the board design.

What I propose is not an enable/disable configuration switch, but to
clearly state that a particular mode of operation is broken. Like the
"max-speed" property, it setup a restriction. IMO, this is a
description of what the HW is and is capable of, and as such it should
be part of the DT.

Yes the property directly map to a register, but it does let you
directly manipulate it (you can't pass the value you want to write in
the register). Having it this way just makes the code simple on both
ends (user and driver).

Yes people could start abusing this to setup policy. In the end, it is
our responsibility, as community, to make sure APIs are used in a
proper way, and not let it be used that way.

I'm open to suggestion on how improve the solution, maybe something
which could bring more confidence that property won't be misused.

Jerome
