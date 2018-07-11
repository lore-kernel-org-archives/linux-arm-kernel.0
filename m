From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 11 Jul 2018 09:51:29 -0500
Subject: [PATCH 1/2] ARM: dts: arria10: update NAND clocking
In-Reply-To: <CAK7LNATNjPuGmzA_mS+yvVC8TpPsvQNvKedJ6emt114xGy7m3Q@mail.gmail.com>
References: <1531176063-30140-1-git-send-email-dinguyen@kernel.org>
 <CAK7LNARAVSK5VY=_RfO2PXJCAnXJN3sXoAY=ijSwVojeo=c66w@mail.gmail.com>
 <b33d18b2-1956-50a4-9a3f-6d2a0abd4b81@kernel.org>
 <CAK7LNATNjPuGmzA_mS+yvVC8TpPsvQNvKedJ6emt114xGy7m3Q@mail.gmail.com>
Message-ID: <CADhT+wfJ2Kq9Lq4_eA9uDgmRLoS8hHaWsr8cskUxWC5xh=vdRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

On Tue, Jul 10, 2018 at 9:45 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 2018-07-10 22:35 GMT+09:00 Dinh Nguyen <dinguyen@kernel.org>:
> >
> >
> > On 07/09/2018 08:31 PM, Masahiro Yamada wrote:
> >> 2018-07-10 7:41 GMT+09:00 Dinh Nguyen <dinguyen@kernel.org>:
> >>> The NAND IP needs 2 clocks(nand_x_clk and nand_clk). This patch adds a
> >>> nand_x_clk, which is derived from the nand_clk, but has a fixed divider
> >>> of 4.
> >>>
> >>> Update the NAND node to use the additional clock.
> >>>
> >>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> >>> ---
> >>>  arch/arm/boot/dts/socfpga_arria10.dtsi | 13 +++++++++++--
> >>>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> >>> index a4dcb68..558b5ea 100644
> >>> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> >>> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> >>> @@ -377,13 +377,21 @@
> >>>                                                 clk-gate = <0xC8 11>;
> >>>                                         };
> >>>
> >>> -                                       nand_clk: nand_clk {
> >>> +                                       nand_x_clk: nand_x_clk {
> >>>                                                 #clock-cells = <0>;
> >>>                                                 compatible = "altr,socfpga-a10-gate-clk";
> >>>                                                 clocks = <&l4_mp_clk>;
> >>>                                                 clk-gate = <0xC8 10>;
> >>>                                         };
> >>>
> >>> +                                       nand_clk: nand_clk {
> >>> +                                               #clock-cells = <0>;
> >>> +                                               compatible = "altr,socfpga-a10-gate-clk";
> >>> +                                               clocks = <&nand_x_clk>;
> >>> +                                               fixed-divider = <4>;
> >>> +                                               clk-gate = <0xC8 10>;
> >>> +                                       };
> >>> +
> >>>                                         spi_m_clk: spi_m_clk {
> >>>                                                 #clock-cells = <0>;
> >>>                                                 compatible = "altr,socfpga-a10-gate-clk";
> >>> @@ -650,7 +658,8 @@
> >>>                         reg-names = "nand_data", "denali_reg";
> >>>                         interrupts = <0 99 4>;
> >>>                         dma-mask = <0xffffffff>;
> >>> -                       clocks = <&nand_clk>;
> >>> +                       clocks = <&nand_clk>, <&nand_x_clk>;
> >>> +                       clock-names = "nand", "nand_x";
> >>
> >>
> >> Doesn't SOCFPGA really need the ECC clock?
> >>
> >
> > I don't see any mentions of an ECC clock in any of the SoCFPGA
> > documentation for the NAND IP.
>
>
> I'd like you to check the IP documentation
> published by Denali (or Cadence),
> not published by Altera.
>
> Is it available for you?
>
>
>
> In my SoCs, the same clock signal (nand-clk-200m)
> is connected to clk_x and ecc_clk, like this:
>
>                                          -------------
> --------------                           | DENALI IP |
> |            |                           |           |
> | clk        |---(nand-clk-50m)--------->| clk       |
> | controller |                           |           |
> |            |---(nand-clk-200m)-------->| clk_x     |
> --------------?                      |   |           |
>                                      --->| ecc_clk   |
>                                          |           |
>                                          -------------
>
>
> Some clock lines are often tied-up,
> but such low-level information does not appear in
> user documents.
> I talked to a hardware engineer to get this information.
>
>
>
> I guess the situation is similar for your case,
> but I do not have information enough to argue this.
>

I don't disagree with this representation. But after asking around,
I'm getting the impression that the ECC clock is not exposed to the
clock manager. This implies that the clock is always turned on and
there doesn't seem to be any software control for it. I tested ECC
with this patch and it looks to be working correctly, without any ecc
clock representation.

I'm not sure if I should expose a dummy ecc_clk to satisfy the binding?

Dinh
