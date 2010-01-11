From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 11 Jan 2010 14:37:16 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <20100108094214.GA23420@n2100.arm.linux.org.uk>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<201001081426.09754.jk@ozlabs.org>
	<20100108094214.GA23420@n2100.arm.linux.org.uk>
Message-ID: <201001111437.16404.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Having struct clk be a set of function pointers gets really expensive on
> some platforms due to the shere number of struct clks - about 900; this
> will be a bar to them adopting this not only due to the size but the
> problems of ensuring correct initialisation.

That's OK, we should only use the common struct clk where it makes sense.

However in the 900 clocks case, I think we have the potential to use similar 
or less memory with a common struct clk that is 'subclassed' by different 
clock types.

As Benh has suggested, I've refactored my patchset to use a clk_operations 
structure:

struct clk_operations {
       int             (*enable)(struct clk *);
       void            (*disable)(struct clk *);
       unsigned long   (*get_rate)(struct clk *);
       void            (*put)(struct clk *);
       long            (*round_rate)(struct clk *, unsigned long);
       int             (*set_rate)(struct clk *, unsigned long);
       int             (*set_parent)(struct clk *, struct clk *);
       struct clk*     (*get_parent)(struct clk *);
};

struct clk {
	const struct clk_operations *ops;
};

This way, each clock will require the operations pointer, plus any clock-
specific fields. The fixed clocks on the system only require an unsigned long; 
more complex clocks get whatever fields they need.

The benefit of this is that we no longer need to allocate structures 
containing a superset of all possible fields. For example, on PXA we're 
reserving space for .delay, .rate  and .cken for all clocks, where only some 
types of clock use these. Subclassing struct clk allows us to only declare 
fields that are relevant to each clock type.

Also, we're now able to define generic clocks, separate from the platform. I 
have done this with icst307, with the realview and versatile platforms sharing 
the generic icst307 clock code. I'm sure there are other areas where we can 
provide similar platform-independent clock definitions.

Currently, there's no way to neatly initialise a struct clk outside of the 
platform code (without making bold assumptions about struct clk); this 
prevents us from parsing clocks directly from the device tree.

Cheers,


Jeremy




    
