From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 18 May 2018 12:46:58 +0200
Subject: [PATCH 5/9] PM / Domains: dt: Allow power-domain property to be a
 list of phandles
In-Reply-To: <1526639490-12167-6-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-6-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdUTF-8_V6kMAE0THNES+yv2HhZGJA3f41Yfpd1Bs6txHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Fri, May 18, 2018 at 12:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To be able to describe topologies where devices are partitioned across
> multiple power domains, let's extend the power-domain property to allow
> being a list of phandles.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -111,8 +111,9 @@ Example 3:
>  ==PM domain consumers==
>
>  Required properties:
> - - power-domains : A phandle and PM domain specifier as defined by bindings of
> -                   the power controller specified by phandle.
> + - power-domains : A phandle and PM domain specifier, or a list of phandles, as

A list of PM domain specifiers?

(A PM domain specifier consists of a phandle, and zero or more indices)

> +                  defined by bindings of the power controller specified by
> +                  phandle.
>
>  Example:
>
> @@ -122,9 +123,16 @@ Example:
>                 power-domains = <&power 0>;
>         };
>
> -The node above defines a typical PM domain consumer device, which is located
> -inside a PM domain with index 0 of a power controller represented by a node
> -with the label "power".
> +       leaky-device at 12350000 {

I know it's just an example, but this uses the same unit-address and
reg property
as the device node above.

There's a similar issue with the two other examples below, but they
use different
node names (leaky-device0 and leaky-device1).

> +               compatible = "foo,i-leak-current";
> +               reg = <0x12350000 0x1000>;
> +               power-domains = <&power0 0>, <&power1 0> ;
> +       };
> +
> +The first example above defines a typical PM domain consumer device, which is
> +located inside a PM domain with index 0 of a power controller represented by a
> +node with the label "power". In the second example the consumer device are
> +partitioned across two PM domains.
>
>  Optional properties:
>  - required-opps: This contains phandle to an OPP node in another device's OPP

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
