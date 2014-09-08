From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 8 Sep 2014 12:03:57 -0600
Subject: [PATCH RESEND] ARM: PCI: Use PCI_CLASS_* defines for PCI class
In-Reply-To: <CAErSpo7sOc72V3g5tOov8Yj4nKiuJupaUTKEEecHMcqEUrzh_g@mail.gmail.com>
References: <1410163532-31057-1-git-send-email-lisovy@gmail.com>
 <CAErSpo7sOc72V3g5tOov8Yj4nKiuJupaUTKEEecHMcqEUrzh_g@mail.gmail.com>
Message-ID: <20140908180357.GA6159@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 10:36:36AM -0600, Bjorn Helgaas wrote:

> Presumably these devices have PCI BARs (since that's how dev->resource
> got filled in), and we want to somehow ignore them, not assign
> resources to them, and not allow drivers to use whatever is mapped by
> the BARs.  But clearing out the struct resources isn't really safe by
> itself.  The hardware BAR still contains some value, and may still be
> enabled, which means that it may conflict with other devices.

I've seen this pattern before in the old mvebu stuff.

Essentially for that case the mvebu HW is a repurposed end port core,
so when working as a root port it presents an end port config space
(not a root port bridge config space). The BAR in that config space is
not relevant, so the old mvebu used code like this to hide it from the
PCI core. Otherwise the core will try to program it from the aperture,
and the default BAR size is really big, so it runs out of space.

Not sure if this is the same for this driver, but it looks very
similar..

Jason
