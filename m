From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 22:15:09 +0200
Subject: [PATCH 02/16] clk: sunxi-ng: Add common infrastructure
In-Reply-To: <20160516100239.a93a238b0d458b38a3689a95@free.fr>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-3-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67XWt6tjG_xXWgGatTaiN5uYQb2_Q6bgixMDUkHfVHLHg@mail.gmail.com>
 <20160515183122.GA27618@lukather>
 <20160516100239.a93a238b0d458b38a3689a95@free.fr>
Message-ID: <20160516201509.GL27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Francois,

On Mon, May 16, 2016 at 10:02:39AM +0200, Jean-Francois Moine wrote:
> On Sun, 15 May 2016 20:31:22 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > > +void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
> > > > +{
> > > > +       u32 reg;
> > > > +
> > > > +       if (!(common->features & CCU_FEATURE_LOCK))
> > > > +               return;
> > > > +
> > > > +       WARN_ON(readl_relaxed_poll_timeout(common->base + common->reg, reg,
> > > > +                                          !(reg & lock), 0, 500));
> > > 
> > >                                     no delay between reads? ^
> > 
> > Yes, I intended it to be a simple busy waiting loop since I don't
> > expect it to be very long. Do yu have any more data on how much time
> > it usually takes?
> 
> I have a Soc in which the rate of the audio clock is stable after a
> good second.

You mean before the clock is actually stable, or before the lock bit
is cleared?

Which SoC is it? As far as I've seen, only the H3 allows to configure
the stable time, and while by default it will take 16us, you can
configure as high as 66ms (which is still way higher than the current
limit).

Thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160516/c43f8041/attachment.sig>
