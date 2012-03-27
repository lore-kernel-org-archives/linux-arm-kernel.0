From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2012 11:15:07 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <4F71961E.2080208@st.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203221420.10127.arnd@arndb.de> <4F71961E.2080208@st.com>
Message-ID: <201203271115.07805.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 March 2012, Viresh Kumar wrote:
> On 3/22/2012 7:50 PM, Arnd Bergmann wrote:
> > The direct replacement is of_machine_is_compatible(), but there are a lot
> > of cases where it's better to have a local property in the device node
> > that a driver is using.
> 
> Hey Arnd,
> 
> I used of_machine_is_compatible() at several places, where it is not working :(
> Actually all these usages are before a call to of_platform_populate() and
> it looks the tree is not up by this time.
> 
> So, of_machine_is_compatible() always fails. The places where i am using this
> routine are:
> - spear3xx_dt_init(): to call SoC specific of_platform_populate()
> - spear3xx_clk_init(): to call SoC specific clk_register()
> 
> Can you please suggest what should i do here?

The normal way is to turn around the logic so you don't have to include this test
at all. Just have one soc-specific init_machine and map_io function, that calls
both soc-specific and shared soc functions, e.g.

void __init spear3xx_clk_init(void)
{
	int i;
	struct clk_lookup *lookups;

	for (i = 0; i < ARRAY_SIZE(spear3xx_clk_lookups); i++) 
		clk_register(&spear3xx_clk_lookups[i])
}

void __init spear300_clk_init(void)
{
	int i;
	struct clk_lookup *lookups;

	spear3xx_clk_init();

	for (i = 0; i < ARRAY_SIZE(spear300_clk_lookups); i++) 
		clk_register(&spear300_clk_lookups[i])

	clk_init();
}

void __init spear300_map_io(void)
{
	spear3xx_map_io();
	spear300_clk_init();
}

The other option would be to try to move stuff to a later point, e.g. don't
initialize the clocks until the basic device tree is set up.
of_machine_is_compatible() should work at init_early() time, but not at
map_io() time. Other platforms set up the clocks@init_early() time.
The spear3xx_dt_init function should be called from init_machine(), which
happens much later, so I'm pretty sure you can use of_machine_is_compatible()
if you can't just avoid it.

In the long run, I would hope that a lot of the differences go away anyway
as information that is now hardcoded just moves into the device tree.
At that point, you should no longer need to care which soc you are running
on. I realize that there is still significant amount of work to be done
until you get there.

In case of the clocks, I think you could already merge all the clk_lookup
arrays into one, which would result in a larger kernel image but should
do no harm otherwise.

	Arnd
