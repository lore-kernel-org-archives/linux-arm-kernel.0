From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 27 Mar 2012 16:57:40 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203271115.07805.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203221420.10127.arnd@arndb.de> <4F71961E.2080208@st.com>
 <201203271115.07805.arnd@arndb.de>
Message-ID: <4F71A42C.3090108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/27/2012 4:45 PM, Arnd Bergmann wrote:
> On Tuesday 27 March 2012, Viresh Kumar wrote:
> The normal way is to turn around the logic so you don't have to include this test
> at all. Just have one soc-specific init_machine and map_io function, that calls
> both soc-specific and shared soc functions, e.g.

But with that, i need multiple DT_MACHINE_START(). Isn't it?
Is this advisable?

> The other option would be to try to move stuff to a later point, e.g. don't
> initialize the clocks until the basic device tree is set up.
> of_machine_is_compatible() should work at init_early() time, but not at
> map_io() time. Other platforms set up the clocks at init_early() time.
> The spear3xx_dt_init function should be called from init_machine(), which
> happens much later, so I'm pretty sure you can use of_machine_is_compatible()
> if you can't just avoid it.

DT should be up but, nodes would be up only once we call
of_platform_populate() from this init routine. And i had following code in
my patch:

static void __init spear3xx_dt_init(void)
{
...
	if (of_machine_is_compatible("st,spear300"))
		of_platform_populate(NULL, of_default_bus_match_table,
				spear300_auxdata_lookup, NULL);
	else if (of_machine_is_compatible("st,spear310"))
		of_platform_populate(NULL, of_default_bus_match_table,
				spear310_auxdata_lookup, NULL);
	else if (of_machine_is_compatible("st,spear320"))
		of_platform_populate(NULL, of_default_bus_match_table,
				spear320_auxdata_lookup, NULL);

...
}

And so these checks are not working here. :(

> In case of the clocks, I think you could already merge all the clk_lookup
> arrays into one, which would result in a larger kernel image but should
> do no harm otherwise.

Actually we can't do it. :(
If i boot 300 then i will also get clocks of 310 and 320 in my clock list.
And once i go through this clock list to create clock tree (parent-child
relationship), i will try to access hardware registers of 310 & 320,
which are just not valid for 300. Kernel Crash!!

-- 
viresh
