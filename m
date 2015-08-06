From: robherring2@gmail.com (Rob Herring)
Date: Wed, 5 Aug 2015 22:14:51 -0500
Subject: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
In-Reply-To: <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Define and add Generic PM domains (genpd) for ARM CPU clusters. Many new
> SoCs group CPUs as clusters. Clusters share common resources like GIC,
> power rail, caches, VFP, Coresight etc. When all CPUs in the cluster are
> idle, these shared resources may also be put in their idle state.
>
> The idle time between the last CPU entering idle and a CPU resuming
> execution is an opportunity for these shared resources to be powered
> down. Generic PM domain provides a framework for defining such power
> domains and attach devices to the domain. When the devices in the domain
> are idle at runtime, the domain would also be suspended and resumed
> before the first of the devices resume execution.
>
> We define a generic PM domain for each cluster and attach CPU devices in
> the cluster to that PM domain. The DT definitions for the SoC describe
> this relationship. Genpd callbacks for power_on and power_off can then
> be used to power up/down the shared resources for the domain.

[...]

> +ARM CPU Power domains
> +
> +The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
> +CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
> +caches, VFP and power controller and other peripheral hardware. Generally,
> +when the CPUs in the cluster are idle/suspended, the shared resources may also
> +be suspended and resumed before any of the CPUs resume execution.
> +
> +CPUs are the defined as the PM domain consumers and there is a PM domain
> +provider for the CPUs. Bindings for generic PM domains (genpd) is described in
> +[1].
> +
> +The ARM CPU PM domain follows the same binding convention as any generic PM
> +domain. Additional binding properties are -
> +
> +- compatible:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Must also have
> +                       "arm,pd"
> +               inorder to initialize the genpd provider as ARM CPU PM domain.

A compatible string should represent a particular h/w block. If it is
generic, it should represent some sort of standard programming
interface (e.g, AHCI, EHCI, etc.). This doesn't seem to be either and
is rather just a mapping of what "driver" you want to use.

I would expect that identifying a cpu's or cluster's power domain
would be done by a phandle between the cpu/cluster node and power
domain node. But I've not really looked at the power domain bindings
so who knows.

Rob
