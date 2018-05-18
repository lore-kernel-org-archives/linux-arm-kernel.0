From: JOLLYS@xilinx.com (Jolly Shah)
Date: Fri, 18 May 2018 21:18:35 +0000
Subject: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
In-Reply-To: <be5cecb2-3d0d-22f8-48a2-f94ed9546e04@samsung.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
 <1519775750-21297-2-git-send-email-jollys@xilinx.com>
 <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
 <CGME20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5@epcas5p2.samsung.com>
 <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
 <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
 <DM2PR0201MB07670C06F504F97EF4E4BAD4B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <SN1PR02MB37588BFF357865F4C9628D99B8910@SN1PR02MB3758.namprd02.prod.outlook.com>
 <be5cecb2-3d0d-22f8-48a2-f94ed9546e04@samsung.com>
Message-ID: <SN1PR02MB37582339D5B3937748F4D9ACB8900@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

> -----Original Message-----
> From: Marek Szyprowski [mailto:m.szyprowski at samsung.com]
> Sent: Thursday, May 17, 2018 11:31 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; Geert Uytterhoeven <geert@linux-
> m68k.org>; Rob Herring <robh@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>; Andy Gross
> <andy.gross@linaro.org>; Shawn Guo <shawnguo@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; Bj?rn Andersson
> <bjorn.andersson@linaro.org>; sean.wang at mediatek.com; Michal Simek
> <michal.simek@xilinx.com>; Mark Rutland <mark.rutland@arm.com>; Rajan
> Vaja <RAJANV@xilinx.com>; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; Linux ARM <linux-arm-
> kernel at lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel at vger.kernel.org>
> Subject: Re: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain
> bindings
> 
> Hi Jolly,
> 
> On 2018-05-17 23:10, Jolly Shah wrote:
> 
> >>>>>> +Example:
> >>>>>> +     zynqmp-genpd {
> >>>>>> +             compatible = "xlnx,zynqmp-genpd";
> >>>>> What's the control interface for controlling the domains?
> >>>>>> +
> >>>>>> +             pd_usb0: pd-usb0 {
> >>>>>> +                     pd-id = <22>;
> >>>>>> +                     #power-domain-cells = <0>;
> >>>>> There's no need for all these sub nodes. Make #power-domain-cells
> >>>>> 1 and put the id in the cell value.
> >>>> That was my first reaction, too...
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             pd_sata: pd-sata {
> >>>>>> +                     pd-id = <28>;
> >>>>>> +                     #power-domain-cells = <0>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             pd_gpu: pd-gpu {
> >>>>>> +                     pd-id = <58 20 21>;
> >>>> ... until I saw the above.
> >>>> Controlling the GPU power area requires controlling 3 physical areas?
> >>>>
> >>>> However, doing it this way may bite you in the future, if a need
> >>>> arises to control a subset. And what about power up/down order?
> >>> What about defining 3 separate domains and arranging them in
> >>> parent-child relationship? generic power domains already supports
> >>> that and this allows to nicely define the power on/off order.
> >>>
> >>>>>> +                     #power-domain-cells = <0x0>;
> >>>>>> +             };
> >>>>>> +     };
> >> I agree it should be arranged in as parent child order to control
> >> subset or control order. Will incorporate those changes in next version.
> >
> > As suggested, I tried out parent, child approach. However what I found is
> Genpd core takes care of parent child dependencies for power on off routines
> only. In our case, We need them in attach-detach routines too. In that case, we
> need to handle dependencies manually for those routines. Please suggest better
> approach, if any.
> 
> What do you mean to handle attach-detach?
> 
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland

For our power domain driver,  we request usage of these nodes in attach routines and power them on in power on routine. So for below specific case, when attach_dev is called, all 3 nodes need to be requested.

> >>>>>> +             pd_gpu: pd-gpu {
> >>>>>> +                     pd-id = <58 20 21>;

Thanks,
Jolly Shah
