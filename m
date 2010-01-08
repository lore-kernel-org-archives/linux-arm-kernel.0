From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 09:42:14 +0000
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <201001081426.09754.jk@ozlabs.org>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
	<201001081426.09754.jk@ozlabs.org>
Message-ID: <20100108094214.GA23420@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2010 at 02:26:09PM +1100, Jeremy Kerr wrote:
> Hi Hartley,
> 
> > I'm relucant to add anything to struct clock that isn't part of the kernel-
> > wide API.
> 
> This may have been a little cryptic, I'm sorry. The reason for not adding a 
> 'rate' member to the public clock API is that there would be now two methods 
> for getting the rate of a clock: calling clk->get_rate or accessing clk->rate 
> directly. The latter is not always guaranteed to work (perhaps there's a clock 
> out there that needs an explicit HW query to get the rate), so we don't want 
> generic drivers to be able to access this.

Having struct clk be a set of function pointers gets really expensive on
some platforms due to the shere number of struct clks - about 900; this
will be a bar to them adopting this not only due to the size but the
problems of ensuring correct initialisation.

Conversely, having those platforms use a pointer to a set of clk operations
structures is also prohibitive - some operations such as enable and disable
can be common, but the rest are extremely variable.

Plus there are platforms where struct clk is _valid_ a NULL pointer; they
only have one clock to deal with.  Why should they need to declare a
struct clk structure just for one fixed clock?

What is clear from the clk API as implemented today is that what's right
for one platform isn't right for another platform.  That's why we have
each platform implementing struct clk in their own way.
