From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Jun 2014 15:58:49 +0100
Subject: [PATCH v5 1/8] Documentation: arm: define DT idle states bindings
In-Reply-To: <1403705421-17597-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140625145849.GC15240@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Wed, Jun 25, 2014 at 03:10:14PM +0100, Lorenzo Pieralisi wrote:
> ARM based platforms implement a variety of power management schemes that
> allow processors to enter idle states at run-time.
> The parameters defining these idle states vary on a per-platform basis forcing
> the OS to hardcode the state parameters in platform specific static tables
> whose size grows as the number of platforms supported in the kernel increases
> and hampers device drivers standardization.
>
> Therefore, this patch aims at standardizing idle state device tree bindings for
> ARM platforms. Bindings define idle state parameters inclusive of entry methods
> and state latencies, to allow operating systems to retrieve the configuration
> entries from the device tree and initialize the related power management
> drivers, paving the way for common code in the kernel to deal with idle
> states and removing the need for static data in current and previous kernel
> versions.
>
> Reviewed-by: Sebastian Capella <sebcape@gmail.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
>  .../devicetree/bindings/arm/idle-states.txt        | 733 +++++++++++++++++++++
>  2 files changed, 741 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

[...]

> +===========================================
> +3 - idle-states node
> +===========================================
> +
> +ARM processor idle states are defined within the idle-states node, which is
> +a direct child of the cpus node [1] and provides a container where the
> +processor idle states, defined as device tree nodes, are listed.
> +
> +- idle-states node
> +
> +       Usage: Optional - On ARM systems, it is a container of processor idle
> +                         states nodes. If the system does not provide CPU
> +                         power management capabilities or the processor just
> +                         supports idle_standby an idle-states node is not
> +                         required.
> +
> +       Description: idle-states node is a container node, where its
> +                    subnodes describe the CPU idle states.
> +
> +       Node name must be "idle-states".
> +
> +       The idle-states node's parent node must be the cpus node.
> +
> +       The idle-states node's child nodes can be:
> +
> +       - one or more state nodes
> +
> +       Any other configuration is considered invalid.
> +
> +       An idle-states node defines the following properties:
> +
> +       - entry-method
> +               Usage: Required
> +               Value type: <stringlist>
> +               Definition: Describes the method by which a CPU enters the
> +                           idle states. This property is required and must be
> +                           one of:
> +
> +                           - "arm,psci"
> +                             ARM PSCI firmware interface [2].
> +
> +                           - "[vendor],[method]"
> +                             An implementation dependent string with
> +                             format "vendor,method", where vendor is a string
> +                             denoting the name of the manufacturer and
> +                             method is a string specifying the mechanism
> +                             used to enter the idle state.
> +
> +The nodes describing the idle states (state) can only be defined within the
> +idle-states node, any other configuration is considered invalid and therefore
> +must be ignored.
> +
> +===========================================
> +4 - state node
> +===========================================
> +
> +A state node represents an idle state description and must be defined as
> +follows:
> +
> +- state node
> +
> +       Description: must be child of the idle-states node
> +
> +       The state node name shall follow standard device tree naming
> +       rules ([5], 2.2.1 "Node names"), in particular state nodes which
> +       are siblings within a single common parent must be given a unique name.
> +
> +       The idle state entered by executing the wfi instruction (idle_standby
> +       SBSA,[3][4]) is considered standard on all ARM platforms and therefore
> +       must not be listed.
> +
> +       With the definitions provided above, the following list represents
> +       the valid properties for a state node:
> +
> +       - compatible
> +               Usage: Required
> +               Value type: <stringlist>
> +               Definition: Must be "arm,idle-state".
> +
> +       - logic-state-retained
> +               Usage: See definition
> +               Value type: <none>
> +               Definition: if present logic is retained on state entry,
> +                           otherwise it is lost.

What logic state is retained? All system registers?

> +       - cache-state-retained
> +               Usage: See definition
> +               Value type: <none>
> +               Definition: if present cache memory is retained on state entry,
> +                           otherwise it is lost.

Likewise, how much of the cache hierarchy is affected? Any of it? All of
it?

> +       - timer-state-retained
> +               Usage: See definition
> +               Value type: <none>
> +               Definition: if present the timer control logic is retained on
> +                            state entry, otherwise it is lost.

The architected generic timers? Any CPU-local timers? Or any timers
whatsoever?

> +       - power-rank
> +               Usage: Required
> +               Value type: <u32>
> +               Definition: It represents the idle state power-rank.
> +                           An increasing value implies less power
> +                           consumption. It must be given a sequential
> +                           value = {0, 1, ....}, starting from 0.
> +                           Phandles in the cpu nodes [1] cpu-idle-states
> +                           array property are not allowed to point at idle
> +                           state nodes having the same power-rank value.

Why can't this be implicit in the order of the cpu-idle-states list?
That way it's impossible to violate the ordering requirement.

> +       - entry-method-param
> +               Usage: See definition.
> +               Value type: <u32>
> +               Definition: Depends on the idle-states node entry-method
> +                           property value. Refer to the entry-method bindings
> +                           for this property value definition.

Should this not be left up to the particular mechanism to describe?
e.g. for PSCI we could have a arm,psci-suspend-param property.

Are we sure a single u32 value is going to be sufficient?

Thanks,
Mark.
