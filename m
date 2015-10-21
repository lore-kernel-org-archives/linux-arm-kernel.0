From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 21 Oct 2015 13:29:08 +0200
Subject: [PATCH v4 04/22] of: add function to allow probing a device from
 a OF node
In-Reply-To: <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAMuHMdW+Uq+mu=iy852bzcvRs8E=w8-WV4oDUyTyLOaDnwrp1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

On Mon, Sep 7, 2015 at 2:23 PM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> Walks the OF tree up and finds the closest ancestor that has a struct
> device associated with it, probing it if isn't bound to a driver yet.
>
> The above should ensure that the dependency represented by the passed OF
> node is available, because probing a device should cause its descendants
> to be probed as well (when they get registered).
>
> Subsystems can use this when looking up resources for drivers, to reduce
> the chances of deferred probes because of the probing order of devices.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
> Changes in v4:
> - Rename of_platform_probe to of_device_probe
> - Use device_node.device instead of device_node.platform_dev
>
> Changes in v3:
> - Set and use device_node.platform_dev instead of reversing the logic to
>   find the platform device that encloses a device node.
> - Drop the fwnode API to probe firmware nodes and add OF-only API for
>   now. I think this same scheme could be used for machines with ACPI,
>   but I haven't been able to find one that had to defer its probes because
>   of the device probe order.
>
> Changes in v2: None
>
>  drivers/of/device.c       | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/platform.c     |  2 ++
>  include/linux/of_device.h |  3 +++
>  3 files changed, 63 insertions(+)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 8b91ea241b10..c32ac7b6fbe2 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -286,3 +286,61 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
>
>         return 0;
>  }
> +
> +/**
> + * of_device_probe() - Probe device associated with OF node
> + * @np: node to probe
> + *
> + * Probe the device associated with the passed device node.
> + */
> +void of_device_probe(struct device_node *np)
> +{
> +       struct device_node *target;
> +       struct device *dev = NULL;
> +
> +       if (!of_root || !of_node_check_flag(of_root, OF_POPULATED_BUS))
> +               return;
> +
> +       if (!np)
> +               return;
> +
> +       of_node_get(np);
> +
> +       /* Find the closest ancestor that has a device associated */
> +       for (target = np;
> +            !of_node_is_root(target);
> +            target = of_get_next_parent(target))
> +               if (target->device) {
> +                       dev = target->device;
> +                       break;
> +               }
> +
> +       of_node_put(target);
> +
> +       if (!dev) {
> +               pr_warn("Couldn't find a device for node '%s'\n",
> +                       of_node_full_name(np));

This is triggered for all devices with clocks instantiated through
CLK_OF_DECLARE().
E.g. on r8a7791/koelsch ("... | sort | uniq -c"):

      1 Couldn't find a device for node '/clocks/audio_clk_a'
      1 Couldn't find a device for node '/clocks/audio_clk_b'
      1 Couldn't find a device for node '/clocks/audio_clk_c'
      2 Couldn't find a device for node '/clocks/cpg_clocks at e6150000'
      1 Couldn't find a device for node '/clocks/m2_clk'
      2 Couldn't find a device for node '/clocks/mstp0_clks at e6150130'
     34 Couldn't find a device for node '/clocks/mstp10_clks at e6150998'
      2 Couldn't find a device for node '/clocks/mstp1_clks at e6150134'
      2 Couldn't find a device for node '/clocks/mstp2_clks at e6150138'
     10 Couldn't find a device for node '/clocks/mstp3_clks at e615013c'
      3 Couldn't find a device for node '/clocks/mstp5_clks at e6150144'
      8 Couldn't find a device for node '/clocks/mstp7_clks at e615014c'
      4 Couldn't find a device for node '/clocks/mstp8_clks at e6150990'
     22 Couldn't find a device for node '/clocks/mstp9_clks at e6150994'
      1 Couldn't find a device for node '/clocks/pcie_bus_clk'

Corresponding DTS is arch/arm/boot/dts/r8a7791.dtsi.

> +               return;
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
