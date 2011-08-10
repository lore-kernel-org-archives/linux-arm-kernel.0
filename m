From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 10 Aug 2011 13:03:54 -0700
Subject: Tegra pinmux Device Tree support
In-Reply-To: <CAOesGMgONkY2i+1H+zZ2MJSDnPmFT8AnSjDQxJGaQZvVCExm2A@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF049F17229E@HQMAIL01.nvidia.com>
	<CAOesGMgONkY2i+1H+zZ2MJSDnPmFT8AnSjDQxJGaQZvVCExm2A@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04A0687569@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Tuesday, August 09, 2011 11:35 AM:
> On Mon, Aug 8, 2011 at 2:42 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Grant, Linus, & all,
> >
> > I was thinking of adding some Device Tree support to Tegra's existing
> > pinmux driver. This would remove the dependence of mach-tegra/board-dt.c
> > on board-{harmony,seaboard}-pinmux.c, and make the DT board stand on its
> > own.
...
> This sounds similar to what I had in mind to look at when I got back
> from vacation (not enough rainy days here to deal with it during :).
> 
> Some devices/drivers might need to make references to a pinmux (what
> comes to mind is the i2c driver that has two virtual busses on two
> separate multiplexed outputs on some boards). So having a tegra-pinmux
> node with a sub-node for every pin group might get verbose but
> definitely most flexible.
> 
> Each sub-node could encode the mux type with separate properties, for
> example for the ata case above:
> 
> .../pinmux/ata:
>     nvidia,pingroup-number = <>
>     nvidia,tristate-normal
>     nvidia,mux-mode = <>   (this should probably be an integer, seems
> appropriate since the TRM uses integers as well)
>     nvidia,pull-up-down-normal
... 
> This way the i2c virtual busses could just refer to the pingroup by
> phandle for the mux flipping, with one of them being enabled by
> default and the others inactive.

I now have both the Tegra GPIO and pinmux drivers working as platform
devices, and performing initial setup from device tree, in Grant's
devicetree/test branch. I implemented a syntax similar to Olof's above,
but with a few differences I'll explain below.

For GPIOs, the DT node gains a list of GPIOs replaces gpio_table[] in
board-harmony-pinmux.c. For each entry, tegra_gpio_enable() is called so
that the GPIO driver gains control over the pin.

	gpio: gpio at 6000d000 {
		nvidia,gpios = <
			69	// TEGRA_GPIO_PI5 SD2_CD
			57	// TEGRA_GPIO_PH1 SD2_WP
		>;
	};

For pinmux, I allowed a sub-node for each group, which configures the
properties of that group. "nvidia,pull" is optional, and defaults to
none. "nvidia,tristate" is optional, and defaults to driven. For a given
pinmux group, the whole node is optional; if not present, the driver will
simply leave that group alone at boot time.

	pinmux: pinmux at 70000000 {
		CDEV1 {
			nvidia,function = "PLLA_OUT";
		};
		CDEV2 {
			nvidia,function = "PLLP_OUT4";
			nvidia,pull = "down";
			nvidia,tristate;
		};
	};

Some differences from Olof's proposal:

1) I chose not to support disabling the pingroup (child) nodes. That
would only be required if other devices want to reference these pingroup
nodes using phandles when defining any dynamic pinmux configuration they
will use. I'm not convinced that we want to tie that configuration into
device tree, since drivers using the dynamic pinmux feature would use the
future pinmux/pinctrl API to implement the muxing, and I don't think we
want to restrict that API to systems that use device tree.

2) Given (1), having multiple entries for the same pingroup isn't
required, so storing the pingroup name/number in a property of the node
isn't required. Instead, I name the child nodes based on the pingroup
they apply to.

3) I made the value of "nvidia,function" be the textual name of the
function. This is a value from the Tegra pinmux API's global list of all
functions, rather than the pin-specific mux selector 0..3 used by the
Tegra registers and manual. I did this because:

3a) It was easier to convert the existing board files' pinmux tables; I
didn't need to map each name back to the mux select value using the
manual.

3b) When we do have a pinmux/pinctrl API, it looks like that API will
use a global (at least within a SoC) namespace for function names, and
one that's text-based. Using those same names here will keep everything
consistent.

Does that seem reasonable?

Finally note that I implemented handling of the pinmux node's children
as:

for each pingroup:
    find child node based on pingroup's name
    if it exists:
        process it

That required the following new function on drivers/of/base.c:

struct device_node *of_find_child_node_by_name(
	const struct device_node *parent, const char *name)
{
	struct device_node *child;

	read_lock(&devtree_lock);

	for_each_child_of_node(parent, child) {
		if (!strcmp(child->name, name))
			break;
	}

	read_unlock(&devtree_lock);

	return child;
}
EXPORT_SYMBOL(of_find_child_node_by_name);

Does that seem reasonable, or should I enumerate all the child nodes,
and map each node's name back to the pingroup value? That would remove
the need for the new function above, but the pinmux driver would need
to add a simple loop over the pingroup name table to map the name.

Thanks for any feedback.

-- 
nvpublic
