From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 16:55:53 +0200
Subject: [PATCH v3] mmc: sunxi: Handle the 'New Timing' mode
In-Reply-To: <20160830193202.4baaefd508a5d20d48b2cbed@free.fr>
References: <20160813175611.79E0323C@mail.free-electrons.com>
 <20160830162613.GG18605@lukather>
 <20160830193202.4baaefd508a5d20d48b2cbed@free.fr>
Message-ID: <20161011145553.GZ3462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 07:32:02PM +0200, Jean-Francois Moine wrote:
> On Tue, 30 Aug 2016 18:26:13 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > There are 2 flags saying that the new timing is used:
> > > - the bit 'mode select' in the clock register, and
> > > - the bit 'new timing' in the MMC register.
> > > Both bits must be set/reset at the same time, otherwise the device
> > > does not work (tested with wifi and eMMC in H3 and A83T boards).
> > > So, some synchronization must exist.
> > > 
> > > The previous versions was using a DT property for the MMC and a flag
> > > in the clock driver. This did work with a correct configuration
> > > on both sides, but experiment showed that it was easy to do an error.
> > 
> > I still believe that we will need a property, at least to identify on
> > which we can try the new mode, and on which clocks it's irrelevant (at
> > least for the A33 and A83T).
> 
> As told above, setting the new mode on side (clock or MMC) and not on
> the other one prevents the devices to work. Then, it is safer to have
> the new mode capability flag only once for both sides.
> 
> Now, as the clocks are defined by memory tables and not by the DT, it
> seems natural to have the flag on the clock side.

You can look at it from two sides.

Either you try to switch to the new mode all the time, or you try to
do it only for MMC controllers (and their associated clocks) that
support it.

In the former case, you'll need to ignore a failure in the switch
(mostly if the clock doesn't support it) only for the MMC controllers
that do not have that mode. For the controllers that support it, you
cannot ignore that error anymore. So you have to have some way to
identify in which case you are.

And you need to have that in the former case too, so there's really no
way you can go without such a flag.

> > However, I also believe we should make that mode switching explicit
> > through a function call, instead of relying on some side effect (of
> > some non-upstream code).
> 
> Do you mean a direct call from the MMC driver to the clock driver?

Yes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/69218957/attachment.sig>
