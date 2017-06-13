From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Jun 2017 09:43:20 -0500
Subject: [PATCH 1/4] dt-bindings: tps65217: Update binding documentation.
In-Reply-To: <CAFqH_53+diszv4QtKU0CgVPb3TO-MeDWjbPpFQuVzLXZsQ=Zog@mail.gmail.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
 <20170609140309.zhagc5g662d4la3z@rob-hp-laptop>
 <CAFqH_53+diszv4QtKU0CgVPb3TO-MeDWjbPpFQuVzLXZsQ=Zog@mail.gmail.com>
Message-ID: <CAL_JsqJ8--8Wj9L3LFDrUpeQ33MUu3RwZfxM2x5tAr0Dp4uVqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 5:30 PM, Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
> Hello Rob,
>
> 2017-06-09 16:03 GMT+02:00 Rob Herring <robh@kernel.org>:
>> On Wed, Jun 07, 2017 at 12:32:39PM +0200, Enric Balletbo i Serra wrote:
>>> This patch adds a new binding documentation for the TPS65217 MFD and
>>> updates the documentation for all the sub-devices in accordance to get
>>> each individual sub-driver functioning correctly.
>>
>> Explain why breaking compatibility is okay.
>>
>
> We had some discussion in patch 4 that make me rethink a bit all this,
> please let me send a new version and continue the discussion there
> (now I'm not sure if I'll break the compatibility or not)
>
> But let me ask a question. The TPS65217 MFD has different sub-nodes
> (charger, backlight, pwrbutton, regulators) in DT, I suspect the
> answer is no, but is it ok that some of them were not described in the
> DT because there is nothing to configure?

But you are configuring the interrupts. I'm all for not creating nodes
just for the purpose instantiating a driver (DT is not the only way to
create platform devices) when the parent node is sufficient. We see
both models, but we don't really want a mixture of both ways so I'd
stick with the latter here.

> i.e: Have this because the resources of charger and pwrbutton are
> static so can be hard-coded in the driver
>
> &tps {
>         compatible = "ti,tps65217";
>         interrupt-controller;
>         #interrupt-cells = <1>;
>
>         regulators {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 dcdc1_reg: regulator at 0 {
>                         reg = <0>;
>                 ...
>        };
> };
>
> instead of :
>
> &tps {
>         compatible = "ti,tps65217";
>         interrupt-controller;
>         #interrupt-cells = <1>;
>
>         charger {
>                 compatible = "ti,tps65217-charger";
>                 interrupts = <0>, <1>;
>                 interrupt-names = "USB", "AC";
>         };
>
>         pwrbutton {
>                 compatible = "ti,tps65217-pwrbutton";
>                 interrupts = <2>;
>         };
>
>         regulators {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 dcdc1_reg: regulator at 0 {
>                         reg = <0>;
>                 ...
>        };
> };
