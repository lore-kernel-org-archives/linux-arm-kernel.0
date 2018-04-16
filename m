From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 16 Apr 2018 15:33:49 -0500
Subject: [PATCH v2 1/3] drm/vc4: Remove the need for the GPU-subsystem DT
 node.
In-Reply-To: <20180416172546.32118-1-eric@anholt.net>
References: <20180413175632.oz62n363g6rxdp6z@rob-hp-laptop>
 <20180416172546.32118-1-eric@anholt.net>
Message-ID: <CAL_JsqKJD86tV0jno_cZR=nLoOThT5rjRu3BPpzAwpcHgxSArQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 12:25 PM, Eric Anholt <eric@anholt.net> wrote:
> The GPU subsystem node was a workaround to have a central device to
> bind V3D and display to.  Following the lead of 246774d17fc0
> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
> the subsystem node usage and just create a platform device for the DRM
> device to attach to if any of the subsystem devices are present.
>
> v2: Simplify the DT walking code.

> +static bool
> +driver_of_table_has_a_match(const struct platform_driver *driver)
> +{
> +       struct device_node *node;
> +
> +       node = of_find_matching_node_and_match(NULL,
> +                                              driver->driver.of_match_table,
> +                                              NULL);
> +       if (of_device_is_available(node)) {
> +               of_node_put(node);

You need to put the node regardless.

> +               return true;
> +       }
> +
> +       return false;
> +}
