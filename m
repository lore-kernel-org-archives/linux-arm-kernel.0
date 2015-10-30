From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 30 Oct 2015 13:51:03 +0300
Subject: [PATCH v4 2/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <56333731.1000400@samsung.com>
References: <cover.1446122247.git.p.fedin@samsung.com>
 <eafa355058ff500a72ff2e3408ab635954467a76.1446122247.git.p.fedin@samsung.com>
 <CAGcde9EXfe0amqoTOwgKi-Y6=4mRcEbZrA=as-BxzfMv3ntAhQ@mail.gmail.com>
 <009f01d112dd$fab40830$f01c1890$@samsung.com> <56333731.1000400@samsung.com>
Message-ID: <00d501d11300$e0b4fb60$a21ef220$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> >>> +               sromc: sromc at 12250000 {
> >>> +                       #address-cells = <1>;
> >>> +                       #size-cells = <1>;
> >>> +                       ranges;
> >>> +
> >>
> >> We do not need to specify these three properties as they are already
> >> present in parent node "soc".
> >
> >   We do, otherwise dtc complains about defaults of #address-cells = 2 and #size-cells=1, and
> without empty "ranges" subnode's resources are not correctly translated.
> >
> 
> First of all this patch will not give this error. So this part should
> not be a part of this patch.
> You should be getting above error after applying v4 4/4 "ARM: dts: Add
> Ethernet chip to SMDK5410". So if its failing for ethernet subnode, you
> can move this address-cells and size-cells in dts file just above
> ethernet node as shown below:
> 
> index 311e7be..d69981d 100644
> --- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
> +++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> @@ -95,6 +95,9 @@
>   };
> 
>   &sromc {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       ranges;
>          pinctrl-names = "default";
>          pinctrl-0 = <&srom_ctl>, <&srom_ebi>;
> 

 IMHO this makes little of sense, because in this case you would have to duplicate these properties for every supported machine. address-cells, size-cells and ranges belong to the controller itself, not to its children.
 Of course i could split up the patch into two, first introduce sromc, second introduce mapping. But does it worth that? Both patches would be 3 lines of code each.
 Anyway, this specific talk is outdated by now, please check out neighbor topic, we are discussing significantly improved binding with Krzystof.

> And another question still remains open, we can't just like that change
> "smsc,lan9115" binding by adding samsung specific properties.

 I am sorry, but you either do not understand us with Krzystof, or not reading at all...
 This is not a change in the binding. And these properties do not belong to smsc at all. They would be added to *ANY* device which sits on top of SROMc. This is more like a bus-specific extra. It's similar to "reg" property having different meanings for different buses.

> Probably you can check suggestions from Krzysztof, where he pointed out
> some hint on how other places this is getting used.

 Did you read them? I did, and they do exactly the same thing as i do.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
