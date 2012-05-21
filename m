From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 21 May 2012 11:46:42 +0300
Subject: Clock register in early init
In-Reply-To: <CAJOA=zM_o1Nqw55xxFvw6KssM50Q+7yyo41rUSH2Aoo1neTMjg@mail.gmail.com>
References: <1337227884.2066.9.camel@pgaikwad-dt2>
 <20120517062131.GA9305@gmail.com>
 <1337316517.22560.19.camel@pgaikwad-dt2>
 <20120518112104.GL20304@tbergstrom-lnx.Nvidia.com>
 <CAJOA=zM_o1Nqw55xxFvw6KssM50Q+7yyo41rUSH2Aoo1neTMjg@mail.gmail.com>
Message-ID: <20120521084642.GV20304@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On OMAP I think the only "gotcha" is setting up the timer.  One
> solution is to open code the register reads and the rate calculation
> in the timer code.  That is ugly... but it works.
> 
> > Which advantages do you see in dynamically allocating all this?
> >
> 
> There are many but I'll name a couple.  The most significant point is
> that we can avoid exposing the definition of struct clk if we
> dynamically allocate stuff.  One can use struct clk_hw_init to
> statically initialize data, or instead rely on direct calls to
> clk_register with a bunch of parameters.
> 

Which means if you make a mistake in specifying parents for example, it will
only fail at runtime, possibly before any console is active. With static
initialization, this will fail at compiletime. Much easier to debug.

> Another point is that copying the data at registration-time makes
> __initdata possible.  I haven't done the math yet to see if this
> really makes a difference.  However if we start doing single zImage's
> with multiple different ARM SoCs then this could recover some pages.
> 

On the other hand most clock structures are small, so there will be internal
fragmentation. Also the arrays of parent clock pointers can be shared between
different clocks. We have about 70 muxes in Tegra30 and 12 different parent
arrays.

Cheers,

Peter.
