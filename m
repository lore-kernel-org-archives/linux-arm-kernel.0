From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Sep 2012 08:54:23 +0200
Subject: [PATCH v3 1/9] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <504FB869.60201@wwwdotorg.org>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120911164409.4c030bd8@skate> <504FB869.60201@wwwdotorg.org>
Message-ID: <20120912085423.21af58d5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 11 Sep 2012 16:17:13 -0600,
Stephen Warren <swarren@wwwdotorg.org> a ?crit :

> 
> +static struct mvebu_mpp_mode dove_mpp_modes[] = {
> +	MPP_MODE(0,
> +		MPP_FUNCTION(0x00, "gpio", NULL),
> +		MPP_FUNCTION(0x02, "uart2", "rts"),
> +		MPP_FUNCTION(0x03, "sdio0", "cd"),
> +		MPP_FUNCTION(0x0f, "lcd0", "pwm"),
> +		MPP_FUNCTION(0x10, "pmu", NULL)),
> 
> it's defining the functions within the context of a particular group
> ("mode" in the drivers terminology, I think...) rather than defining
> functions and groups as separate top-level tables.

This data structure really reflects what the datasheet says. Typically,
for SoCs where each pin is independently muxable (AT91, i.MX23/28,
Marvell, and probably many more), the datasheet has a big array, with
one line per pin, and then several columns which tell for a given pin,
what is "function 0", "function 1", "function 2", "function 3", etc.

So the data structure that Sebastian has implemented in the mvebu
driver immediately reflects this. In fact, the pinctrl table code for
Armada 370 and Armada XP was semi-automatically generated from CSV data
of the pinmux functions, directly coming from the datasheets. Having to
create a global list of all possible functions seems useless and
painful, since the functions only make sense in the context of one
particular pin.

Could you be more specific as to what representation you're looking
after? You're proposing to "define functions and groups as separate
top-level tables", but then how to you map which functions are
available for which group, and what is the number of that function is
this group (which we need to actually configure the mapping). I'd
really like to see (with a short code example) what is your view of how
pinmux should be handled for SoCs having independently muxable pins.

I really don't understand how a global list of functions make sense:
the functions make sense on a per-group basis, and this is how the
hardwaredatasheet defines them. If we could keep this representation,
it would really be useful.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
