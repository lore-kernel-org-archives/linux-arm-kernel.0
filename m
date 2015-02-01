From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 1 Feb 2015 10:36:54 +0100
Subject: [PATCH v4 5/5] drivers: bus: Add Simple Power-Managed Bus Driver
In-Reply-To: <CAPDyKFpf74Mxova+QsYfhSVPc26-NhC7A4vFJfywPzP9oHkVhw@mail.gmail.com>
References: <1422288977-20353-1-git-send-email-geert+renesas@glider.be>
 <1422288977-20353-6-git-send-email-geert+renesas@glider.be>
 <CAPDyKFpf74Mxova+QsYfhSVPc26-NhC7A4vFJfywPzP9oHkVhw@mail.gmail.com>
Message-ID: <CAMuHMdVCHYSo-OWDqHWQ+0YHa_gn8o_7-vUSOiRKO-r-c6+Rcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Fri, Jan 30, 2015 at 10:34 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 January 2015 at 17:16, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> Add a driver for transparent busses that don't need a real driver, but
>> where the bus controller is part of a PM domain, or under the control of
>> a functional clock.  Typically, the bus controller's PM domain and/or
>> clock must be enabled for child devices connected to the bus (either
>> on-SoC or externally) to function.
>>
>> Hence the sole purpose of this driver is to enable its clock and PM
>> domain (if exist(s)), which are specified in the DT and managed from
>> platform and PM domain code, and to probe for child devices.
>>
>> Due to the child-parent relationship with devices connected to the bus,
>> PM domain and clock state transitions are handled in the correct order.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

>> --- /dev/null
>> +++ b/drivers/bus/simple-pm-bus.c

>> +static int simple_pm_bus_probe(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +
>> +       dev_dbg(&pdev->dev, "%s\n", __func__);
>> +
>> +       pm_runtime_enable(&pdev->dev);
>> +
>> +       if (np)
>> +               of_platform_populate(np, NULL, NULL, &pdev->dev);
>> +
>
> I am not sure my comments is valid in this initial step. Yet, you
> state in the DT documentation, that this driver supports clocks and PM
> domains.
>
> How you are going add that support it quite interesting. :-) I also

The clock can be controlled through e.g. pm_clk domain (pm_clk_notifier
and pm_clk_{suspend,resume}()) or genpd (GENPD_FLAG_PM_CLK,
which you have added yourself ;-)

> especially interested how the interaction (child to parents) through
> runtime PM will look like.

When a child is to be runtime-resumed, the core make sure the parent is
runtime-resumed. When all children have been runtime-suspended, the parent
is runtime-suspended. This is already working. This patch series is the
only missing piece: without a driver that calls pm_runtime_enable(), the
parent is not runtime-managed.

> Overall, I like the idea in patchset, but I would like to understand a
> bit more around the above.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
