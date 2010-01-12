From: francesco.virlinzi@st.com (Francesco VIRLINZI)
Date: Tue, 12 Jan 2010 09:00:39 +0100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <201001111437.16404.jeremy.kerr@canonical.com>
References: <1262907852.736281.78480196040.1.gpush@pororo>	<201001081426.09754.jk@ozlabs.org>	<20100108094214.GA23420@n2100.arm.linux.org.uk>
	<201001111437.16404.jeremy.kerr@canonical.com>
Message-ID: <4B4C2C27.6030306@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all
>
>    
I'm following this discussion as I'm interested on clocks API and
  as I wrote a generic clock framework (ELC-E 2009) to link clocks and 
devices and
  to notify the clock rate update to the interested devices
> As Benh has suggested, I've refactored my patchset to use a clk_operations
> structure:
>    
> struct clk_operations {
>         int             (*enable)(struct clk *);
>         void            (*disable)(struct clk *);
>         unsigned long   (*get_rate)(struct clk *);
>         void            (*put)(struct clk *);
>         long            (*round_rate)(struct clk *, unsigned long);
>         int             (*set_rate)(struct clk *, unsigned long);
>         int             (*set_parent)(struct clk *, struct clk *);
>         struct clk*     (*get_parent)(struct clk *);
> };
>
> struct clk {
> 	const struct clk_operations *ops;
> };
>
>    
On this proposal I would suggest:

struct clk_operations {
	int (*init)(struct clk *);	/* used on clk_register and during resume from hibernation */
	...
}
struct clk {
	const struct clk_operations *ops;
	spinlock_t	lock;	/* to serialize the clk_operations */
	const 		*name;
	int 		id;
	unsigned long	rate;		/* used when ops->get_rate is NULL */
};


Regards
  Francesco
