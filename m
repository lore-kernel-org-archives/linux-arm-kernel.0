From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 11 Jul 2014 09:43:37 -0700
Subject: [PATCH 5/8] of: Add Tegra124 EMC bindings
In-Reply-To: <1405088313-20048-6-git-send-email-mperttunen@nvidia.com>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <1405088313-20048-6-git-send-email-mperttunen@nvidia.com>
Message-ID: <CAL1qeaGHfjQhLHvgzt85hmbuY4FOG5-k=f80=CNvzPDEgi9_6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 7:18 AM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> Add binding documentation for the nvidia,tegra124-emc device tree
> node.

> diff --git a/Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt b/Documentation/devicetree/bindings/memory-controllers/tegra-emc.txt

> +Required properties :
> +- compatible : "nvidia,tegra124-emc".
> +- reg : Should contain 1 or 2 entries:
> +  - EMC register set
> +  - MC register set : Required only if no node with
> +    'compatible = "nvidia,tegra124-mc"' exists. The MC register set
> +    is first read from the MC node. If it doesn't exist, it is read
> +    from this property.
> +- timings : Should contain 1 entry for each supported clock rate.
> +  Entries should be named "timing at n" where n is a 0-based increasing
> +  number. The timings must be listed in rate-ascending order.

There are upcoming boards which support multiple DRAM configurations
and require a separate set of timings for each configuration.  Could
we instead have multiple sets of timings with the proper one selected
at runtime by RAM code, as reported by PMC_STRAPPING_OPT_A_0?
Something like:

emc {
        emc-table at 0 {
                nvidia,ram-code = <0>;
                timing at 0 {
                        ...
                };
                ...
        };
        emc-table at 1 {
                nvidia,ram-code = <4>;
                timing at 0 {
                        ...
                };
                ...
        };
        ...
};
