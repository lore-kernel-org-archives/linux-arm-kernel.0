From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 22 Nov 2012 17:32:38 +0900
Subject: [PATCH v5 07/15] ARM: mach-shmobile: Add DT table of INTC for
 sh7372
In-Reply-To: <1353571213-26006-8-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <1353571213-26006-8-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <CANqRtoS-w4pJ-rgwa_o1VSnnbw2Ae=nruJ7HYkbcMw-eJnWcjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iwamatsu-san,

Thanks for your efforts so far.

On Thu, Nov 22, 2012 at 5:00 PM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---
> v5 [Nobuhiro Iwamatsu]
>   Add interrupt-cells to interrupt-controllers.
>
> v4 [Magnus Damm]
> * Rework the sh7372 DT INTC setup code to only make use of
>   "renesas,sh_intc" instead of using multiple special cases.
>
> v3
> * No change
>
> v2 [Simon Horman]
> * Use only tabs for indentation
>
> v1 [Nobuhiro Iwamatsu]
> ---
>  arch/arm/boot/dts/sh7372.dtsi | 1140 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1140 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
> index 677fc60..00f1645 100644
> --- a/arch/arm/boot/dts/sh7372.dtsi
> +++ b/arch/arm/boot/dts/sh7372.dtsi

> +               intcs: interrupt-controller at 1 {
> +                       compatible = "renesas,sh_intc";
> +                       interrupt-controller;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       #interrupt-cells = <1>;
> +                       ranges;
> +                       group_size = <11>;
> +
> +                       reg = <0xffd20000 0x200>,
> +                               <0xffd50000 0x200>;
> +
> +                       VEU_VEU0: intsrc1 { vector = <0x3b00>; };
> +                       VEU_VEU1: intsrc2 { vector = <0x3b20>; };
> +                       VEU_VEU2: intsrc3 { vector = <0x3b40>; };
> +                       VEU_VEU3: intsrc4 { vector = <0x3b60>; };

Uhm... No.

We want the same vector number here as described in the data sheet.
This looks like you're adding a software-defined base offset to the DT
data instead of using IRQ domains as expected. So it should read
<0x0700> which is the same as the VEU definition in the INTCS code in
intc-sh7372.c.

I recommend you to remove the INTCS support from these patches and
focus on INTCA only to begin with. Then later when you have corrected
INTCS tables and perhaps also the C code then it can be added
incrementally.

Please work on getting something small and simple merged.

Thanks,

/ magnus
