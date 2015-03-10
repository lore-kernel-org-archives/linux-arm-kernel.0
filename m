From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Mar 2015 18:41:16 +0100
Subject: [PATCH 00/15] musb: Add support for the Allwinner sunxi musb
 controller
In-Reply-To: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150310174116.GX5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 09:40:13PM +0100, Hans de Goede wrote:
> Hi All,
> 
> This patch set has been a while in the making, so I'm very happy to present
> the end result here, and I hope everyone likes it.
> 
> Before talking about merging this there are 2 things which I would like to
> point out:
> 
> a) The musb controller in the sunxi SoCs uses some SRAM which needs to be
> mapped to the musb controller by poking some bits in the SRAM controller,
> just like the EMAC patches which were send a while back I've chosen to use
> syscon for this, actually 2 of the patches in this set come directly from the
> SRAM mapping patchset for the EMAC.
> 
> I know that Maxime is not 100% in favor of using syscon:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/320221.html
> 
> But I disagree with his arguments for writing a special driver for the SRAM
> controller:

And I disagree with your disagreement :)

> 1) syscon was specifically designed for global system control registers like
> this and is fine to use as long as there are no conflicts where 1 bit is of
> interest to multiple drivers, and there is no such conflict here

No. Syscon has been designed for being lazy.

This is a huge abstraction non-sense. You have to put all the logic of
dealing with some external register layout in clients drivers,
including dealing with the different revisions/SoC that are different
from that aspect, and duplicating that code across all client drivers.

> 2) Maxime's other arguments seem to boil down to it would be nice / prettier
> to have a specific driver for this, without really proving a hard need for
> such a driver. But writing such a driver is going to be a lot of work, and
> we've a ton of other work to do, and as said there is no real need for a
> separate driver, syscon works fine for this.

Actually, I already wrote some prototype for this. I'll clean this up
and send it tonight/tomorrow.

> 3) I actually believe that having a specific driver for this is a bad idea,
> because that means inventing a whole new cross driver API for this, and
> getting those right is, hard, a lot of work, and even then one is still likely
> to get it wrong. We can avoid all this by going with the proven syscon solution.

Except that modifying an in-kernel API, especially when we have two
users, is easy. Moving back from syscon is not.

> Maxime, can we please have your ack for moving forward with this using syscon?
> (see above for my arguments why)

If you can address my objections above, sure.

Thanks for your awesome work on this,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/4f70d506/attachment-0001.sig>
