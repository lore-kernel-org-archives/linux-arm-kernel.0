From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Apr 2018 08:28:17 +0200
Subject: [PATCH 1/2 v2] drm/pl111: Support the Versatile Express
In-Reply-To: <87d0zao5ua.fsf@anholt.net>
References: <20180406141935.6801-1-linus.walleij@linaro.org>
 <87d0zao5ua.fsf@anholt.net>
Message-ID: <CACRpkdbXj_KDpw-dg0fCweW-vBGmaO2Z2Q+n4=nMyfrJTg986Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 8, 2018 at 3:16 AM, Eric Anholt <eric@anholt.net> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

>> -     void *regs;
>> +     void __iomem *clcd_memory;
>
> This doesn't seem to be used anywhere.

Ah development artifact, I'll get rid of it.

>> +int pl111_vexpress_clcd_init(struct device *dev,
>> +                          struct pl111_drm_dev_private *priv,
>> +                          struct regmap *map)
>> +{
>> +     struct device_node *memory;
>> +     u32 val;
>> +     int ret;
>> +
>> +     /*
>> +      * The CLCD on the motherboard has a special memory region and
>> +      * does not make use of CMA. We differentiate between the different
>> +      * CLCD controllers using this memory region phandle.
>> +      */
>> +     memory = of_parse_phandle(dev->of_node, "memory-region", 0);
>> +     if (!memory) {
>> +             if (motherboard_muxed) {
>> +                     dev_info(dev, "motherboard CLCD muxed in\n");
>> +                     dev_info(dev, "daughterboard takes precedence\n");
>> +                     dev_info(dev, "motherboard CLCD will not be muxed out\n");
>> +             }
>> +             dev_info(dev,
>> +                      "DVI muxed to daughterboard 1 (core tile) CLCD\n");
>> +             val = VEXPRESS_FPGAMUX_DAUGHTERBOARD_1;
>> +             daughterboard_muxed = true;
>> +     } else {
>> +             priv->clcd_memory = of_iomap(memory, 0);
>> +             if (!priv->clcd_memory)
>> +                     dev_err(dev, "could not remap CLCD memory\n");
>> +             /* Fall through and try to use CMA */
>> +             if (daughterboard_muxed) {
>> +                     dev_info(dev, "daughterboard takes precedence\n");
>> +                     dev_info(dev, "motherboard CLCD will not be muxed out\n");
>> +                     return -ENODEV;
>> +             }
>> +             dev_info(dev, "DVI muxed to motherboard CLCD\n");
>> +             val = VEXPRESS_FPGAMUX_MOTHERBOARD;
>> +             motherboard_muxed = true;
>> +     }
>
> I'm confused by global bools here.  It seems like we're trying to
> coordinate between the instantiation of multiple CLCDs here, to set up
> the mux appropriately.  Does it make sense to do things that way, if
> probe order is unreliable?

Hm I guess I should parse the graph and see what is connected instead,
and bail out if we have two CLCDs and are not the desired one.

I'll go and poke at it.

Yours,
Linus Walleij
