From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2012 20:30:24 +0000
Subject: [PATCH 09/13] SPEAr: clk: Add Auxiliary Synthesizer clock
In-Reply-To: <20120417185111.GH3852@pengutronix.de>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <e5ea0b5c1511fe29d1b452fb3095f4380db58455.1334660432.git.viresh.kumar@st.com>
 <20120417185111.GH3852@pengutronix.de>
Message-ID: <201204172030.25267.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Sascha Hauer wrote:
> > +{
> > +     struct clk_aux *aux = to_clk_aux(hw);
> > +     unsigned int num = 1, den = 1, val, eqn;
> > +     unsigned long flags = 0;
> > +
> > +     if (aux->lock)
> > +             spin_lock_irqsave(aux->lock, flags);
> > +
> > +     val = readl_relaxed(aux->reg);
> > +
> > +     if (aux->lock)
> > +             spin_unlock_irqrestore(aux->lock, flags);
> > +
> 
> A single read is atomic and needs no lock.

That depends on whether the read has any side-effects. There
is another function that does a read-modify-write on the
same register, and you might need to prevent this one from
reading the register between the other read and the following
write.

The spinlock also has the benefit of enforcing the ordering
of the read with regard to your instruction stream, otherwise
it can be delayed on out-of-order CPUs until the value
is actually used.

	Arnd
