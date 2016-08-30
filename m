From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 30 Aug 2016 19:32:02 +0200
Subject: [PATCH v3] mmc: sunxi: Handle the 'New Timing' mode
In-Reply-To: <20160830162613.GG18605@lukather>
References: <20160813175611.79E0323C@mail.free-electrons.com>
 <20160830162613.GG18605@lukather>
Message-ID: <20160830193202.4baaefd508a5d20d48b2cbed@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Aug 2016 18:26:13 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > There are 2 flags saying that the new timing is used:
> > - the bit 'mode select' in the clock register, and
> > - the bit 'new timing' in the MMC register.
> > Both bits must be set/reset at the same time, otherwise the device
> > does not work (tested with wifi and eMMC in H3 and A83T boards).
> > So, some synchronization must exist.
> > 
> > The previous versions was using a DT property for the MMC and a flag
> > in the clock driver. This did work with a correct configuration
> > on both sides, but experiment showed that it was easy to do an error.
> 
> I still believe that we will need a property, at least to identify on
> which we can try the new mode, and on which clocks it's irrelevant (at
> least for the A33 and A83T).

As told above, setting the new mode on side (clock or MMC) and not on
the other one prevents the devices to work. Then, it is safer to have
the new mode capability flag only once for both sides.

Now, as the clocks are defined by memory tables and not by the DT, it
seems natural to have the flag on the clock side.

> However, I also believe we should make that mode switching explicit
> through a function call, instead of relying on some side effect (of
> some non-upstream code).

Do you mean a direct call from the MMC driver to the clock driver?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
