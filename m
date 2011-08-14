From: olof@lixom.net (Olof Johansson)
Date: Sun, 14 Aug 2011 00:24:37 -0700
Subject: [RFC PATCH 06/12] arm/dt: Tegra: Add pinmux node
In-Reply-To: <1313189697-21287-7-git-send-email-swarren@nvidia.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
	<1313189697-21287-7-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMheuUfSe1uUA6LxZ71V0-DR3XX7bEJqhVxJ-ZqrWWa1bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 12, 2011 at 3:54 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Add a pinmux node to tegra20.dtsi in order to instantiate the future
> pinmux device. Add pinmux nodes to Harmony and Seaboard, which detail
> the entire default pinmux configuration. This configuration is identical
> to that in board-harmony/seaboard-pinmux.c.

Again, documentation for the binding is needed.

Seeing the table coded up now though, I wonder if it could make sense
to flip it around? The number of functions multiplexed out are fewer
than the pin groups (and this would be even more true on platforms
that have per-pin configurations and/or smaller groups).

I.e. something like:

    sdio4 {
            nvidia,pingroups = < DTA DTD >; // Not sure how to
reference this though -- integers would be hard to read. DTA/DTD
aren't valid values in the syntax.
            nvidia,pull-up
    },

And any pingroups not covered by a function would be left alone (one
could easily define a few no-op functions to set pull up/down and
tristate values on the unused groups).

[...]

> + ? ? ? pinmux: pinmux at 70000000 {
> + ? ? ? ? ? ? ? ATA {

I would prefer seeing these in lower case (since device tree tends to
be no-caps). Should be easy to switch to strcasecmp in the code.

[...]
> + ? ? ? ? ? ? ? CDEV2 {
> + ? ? ? ? ? ? ? ? ? ? ? nvidia,function = "PLLP_OUT4";

The string here is a bit unfortunate. It's really just used to map
from the string to an integer anyway, with the reverse mapping being
produced by the debugfs output. But especially if the function is
flipped above, the different pingroups referenced might not use the
same value for each function, so some sort of lookup will still be
needed. Not much to do about, it seems. :(


> + ? ? ? ? ? ? ? ? ? ? ? nvidia,pull = "down";

This should be done by discrete properties instead: nvidia,pull-up,
nvidia-pull-down (and omitted means normal), without values.


-Olof
