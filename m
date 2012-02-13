From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 13 Feb 2012 11:58:37 -0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178EF838EB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a summary of what we discussed and agreed upon in the pinctrl
meetings at Linaro Connect:

* We will allow drivers that define the SoC's entire set of capabilities
in static tables in the pinctrl driver. However, drivers will not be
required to do this; it's a decision of the individual driver writer
whether to

** Store the data in static tables in the driver, or in device tree, or
elsewhere.

** Expose all of the SoC's capabilities to the pinctrl core, or only
those capabilities required for the current board (this is somewhat more
of an issue for drivers storing their data in device tree).

* We will merge the pinmux mapping table and pin config mapping table
into a single table, so that a single set of APIs will program both
pin mux and pin config into HW at the same time.

* The pinctrl client-side API will be reworked slightly, to support this;
it'll use "named states" rather like the recent pin config API propsals:

struct pinctrl *p;
struct pinctrl_state *active;
struct pinctrl_state *standby;

// Slowpath: locks all mappings and pins for this device irrespective
// of state name
p = pintrl_get(dev); 
active = pinctrl_get_state(p, "active"); // Slowpath
standby = pinctrl_get_state(p, "standby"); // Slowpath
pinctrl_select_state(p, active); // Fastpath
pinctrl_select_state(p, standby); // Fastpath
pinctrl_put(p); // Slowpath

Note: I added the "p" parameter to pinctrl_select_state() as proposed
by Simon Glass. I think we did briefly agree to this. It'll give us
completely flexibility for the opaque values "p", "active", and "standby"
if we need to change them in the future.

Note: There was some discussion re: pinctrl_get_state() being imbalanced
since there is no pinctrl_put_state(); pinctrl_put() does that. We didn't
entirely resolve that, I think. I propose renaming pinctrl_get_state() to
pinctrl_lookup_state() to avoid that imbalance. Does anyone disagree with
that? (I'm hoping not to start a bikeshed discussion here:-)

* We will remove the "hog_on_boot" field from the mapping table. Instead,
such entries will be represented as part of the pin controller driver's
own pin states. Linusw has already sent the patches to do this.

* We will add an (optional) "op" (function) to the pinctrl driver struct,
which informs the driver when all mux/config values have been set for the
selected named state. This can be used to either flush a register cache
to HW, perform error-checking on the complete HW configuration, etc.

* We will add an "of_node" field to the mapping table. When dynamically
constructing the mapping table from device tree, we can use this field
to match entries against drivers. This removes the requirement to know
a device's dev_name when creating the mapping table, which may happen
before drivers are probed.

swarren notes now: This point is no longer relevant given the next:

* When creating the mapping table from device tree, we will defer
parsing of the common pinctrl properties of each client devices's node
until that device's driver calls pinctrl_get(). This removes the need
for the pinctrl core to scan the entire device tree early during boot
looking for all nodes that use pinctrl properties, in order to construct
the mapping table; instead it may be constructed lazily, and feed into
deferred probe nicely.

* The /common/ pinctrl bindings will be:

Each device will have a set of numbered states that can be activated.
These will be numbered contiguously starting with 0, so 0, 1, 2, ...

Optionally, these states may have names too.

Each client driver's binding or driver defines the number of states,
what each state ID means, whether states have names, and what those
names are. The pinctrl common bindings don't impose any rules here.

For each state, there will be an associated list of phandles that describe
the HW programming for that state. A list is needed primarily to allow a
device to rely on configuring multiple pin controllers at once, but may be
used for other purposes such as combining different common configuration
subsets together.

Each of the nodes referenced by the listed phandles must be stored
underneath the pin controller that it affects. The content of those nodes
is not described in any way at all by the common pinctrl bindings; it is
/entirely/ up to the bindings of the individual pin controller to define
the content of that node. Each pinctrl driver will provide an "op"
(function) to convert these nodes into a list of mapping table entries
for use during DT parsing.

Given:

        pinmux at 70000000 {
                compatible = "nvidia,tegra20-pinmux";
                reg = <...>;
                // SoC-specific properties here
                pmx_sdhci: pmx_sdhci {
                        // SoC-specific properties here
                };
        };

The simplest possible common bindings example is:

        sdhci at c8000200 {
                pinctrl-0 = <&pmx_sdhci>;
        };

A slightly more complex example:

        sdhci at c8000200 {
                pinctrl-0 = <&pmx_sdhci &pmx_sdhci_active>;
                pinctrl-1 = <&pmx_sdhci &pmx_sdhci_standby>;
                /* An optional list of state names; depends on SDHCI driver */
                pinctrl-names = "active", "suspend";
        };

* Since I proposed most of this and completely understand what I mean, I
will write patches to document and implement all of the above, ASAP.

-- 
nvpublic
