From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 25 Oct 2016 12:17:45 +0200
Subject: [RFC] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <20161024170035.GO15620@leverpostej>
References: <1477327596-16060-1-git-send-email-bgolaszewski@baylibre.com>
 <1477327596-16060-2-git-send-email-bgolaszewski@baylibre.com>
 <20161024170035.GO15620@leverpostej>
Message-ID: <CAMpxmJWkb3OQAxCMWT6yrGu1df8vXtxOJHS6Qu4pyrSaYJ5xEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-24 19:00 GMT+02:00 Mark Rutland <mark.rutland@arm.com>:
> On Mon, Oct 24, 2016 at 06:46:36PM +0200, Bartosz Golaszewski wrote:
>> +
>> +     dev = &pdev->dev;
>> +     node = dev->of_node;
>> +
>> +     /* Find the board name. */
>> +     for (parent = node;
>> +          !of_node_is_root(parent);
>> +          parent = of_get_parent(parent));
>> +
>> +     ret = of_property_read_string(parent, "compatible", &board);
>> +     if (ret) {
>> +             dev_err(dev, "unable to read the soc model\n");
>> +             return ret;
>> +     }
>
> I can see that you want to expose sysfs knobs for this, but is it really
> necessary to match boards like this? It's very fragile, and commits us
> to maintaining a database of board data (i.e. a board file).
>
> I am very much not keen on that.
>

I Mark,

I don't want to expose any new sysfs interface.

The initial idea was to follow the way the ti-aemif driver is
implemented and expose DT bindings for the memory controller knobs
(initially only the Peripheral Bus Burst Priority Register, tweaking
which is required to make LCDC work correctly on da850 based boards as
mentioned by Kevin). This was rejected as it's not hardware
description but configuration, so it should not be controlled by DT
properties.

The correct approach for this kind of performance knobs doesn't exist
yet. There was a BoF during this year's ELCE in Berlin during which
several ideas were discussed, but no code has been written so far.

Using sysfs would have exactly the same disadvantage - committing to a
stable interface that would have to be maintained indefinitely.

In the end it was decided that a fairly good, temporary solution would
be to create a driver for the da850 DDR controller which would
hardcode the required tweaks for several boards (as the LCDC issue is
known to affect more TI SoCs and boards). Once a framework for
performance knobs is implemented and merged, it would be easy to port
the driver to it as we would not have implemented any stable
interface.

The same solution would be used for the SYSCFG registers on the da8xx SoCs.

Hope that clarifies the need for this patch a bit. I will address all
other issues in v2.

Best regards,
Bartosz Golaszewski
