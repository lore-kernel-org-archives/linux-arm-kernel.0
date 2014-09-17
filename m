From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 17 Sep 2014 17:03:03 +0200
Subject: [RFC PATCH 0/3] PM / clock_ops: allow to specify custom
 pm_clk_notifier callback
In-Reply-To: <540F0381.7010500@ti.com>
References: <1406313096-29761-1-git-send-email-grygorii.strashko@ti.com>
 <7hr3zln692.fsf@linaro.org> <540F0381.7010500@ti.com>
Message-ID: <CAMuHMdUJzXNep14ny24R=FhA4WzsWU9401ZU-nnZ_CkkJqxSsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grygorii,

On Tue, Sep 9, 2014 at 3:41 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>> Since you're essentially gutting clock_ops, have you considered
>> migrating to genpd and having your own pm_domain ops that manage your clocks?
>
> Yes. I've thought about using genpd. But:
> - PM domain is not merged in 3.17 and I don't know if it will be merged in 3.18 :(
> http://www.spinics.net/lists/arm-kernel/msg357003.html

Let's wait and see...

> - To switch using PM domains I will need to create PM domain node PER EACH device,
> (if I understand PM domain bindings right). For example:
>
> +power_netcp: power-controller at 0 {
> +               compatible = "keystone,power-controller";
> +               #power-domain-cells = <0>;
> +               clocks = <&clkcpgmac>, <&clkpa>, <&chipclk12>;
> +       };
>
> netcp: netcp at 2090000 {
>                 reg = <0x2620110 0x8>;
> +               power-domains = <&power_netcp>;
> ...
> }

I think you can have one power-controller, and add the clocks and
power-domains properties to the individual device nodes.

Then the power-controller driver can use the attach callback
introduced in "[PATCH/RFC v2 04/12] PM / Domains: Add genpd attach/detach
callbacks" (https://lkml.org/lkml/2014/9/16/429) to set up the clocks?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
