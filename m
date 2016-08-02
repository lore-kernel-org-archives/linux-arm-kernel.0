From: dhdang@apm.com (Duc Dang)
Date: Tue, 2 Aug 2016 12:10:28 -0700
Subject: [PATCH v5 09/11] dtb: xgene: Add MDIO node
In-Reply-To: <CAOesGMiF0PQocy2jj9Fpz_K-dYRtJDnd789DOCLz35y5g+KVzw@mail.gmail.com>
References: <1467932579-14320-1-git-send-email-isubramanian@apm.com>
 <1467932579-14320-10-git-send-email-isubramanian@apm.com>
 <CAOesGMiF0PQocy2jj9Fpz_K-dYRtJDnd789DOCLz35y5g+KVzw@mail.gmail.com>
Message-ID: <CADaLNDnizBfxXcy8_W2WQ29X_s3FxOsU+CGV_O63ES_4zSLZcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 1, 2016 at 2:13 PM, Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> I came across this now when looking at merge conflicts when preparing
> this. I wish I had seen it sooner.
>
> On Thu, Jul 7, 2016 at 4:02 PM, Iyappan Subramanian
> <isubramanian@apm.com> wrote:
> > Added mdio node for mdio driver.  Also added phy-handle
> > reference to the ethernet nodes.
> >
> > Removed unused mdio subnode within storm menet ethernet node.
> > Removed unused clock node from storm sgenet1.
> >
> > Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> > Tested-by: Fushen Chen <fchen@apm.com>
> > Tested-by: Toan Le <toanle@apm.com>
> > Tested-by: Matthias Brugger <mbrugger@suse.com>
> > ---
> >  arch/arm64/boot/dts/apm/apm-mustang.dts | 12 +++++++++++
> >  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 36 ++++++++++++---------------------
> >  2 files changed, 25 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
> > index 44db32e..b7fb5d9 100644
> > --- a/arch/arm64/boot/dts/apm/apm-mustang.dts
> > +++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
> > @@ -79,3 +79,15 @@
> >  &mmc0 {
> >         status = "ok";
> >  };
> > +
> > +&mdio {
> > +       menet0phy: phy at 3 {
> > +               reg = <0x3>;
> > +       };
> > +       sgenet0phy: phy at 4 {
> > +               reg = <0x4>;
> > +       };
> > +       sgenet1phy: phy at 5 {
> > +               reg = <0x5>;
> > +       };
> > +};
> > diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> > index 5147d76..a415b3a 100644
> > --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> > +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> > @@ -237,20 +237,11 @@
> >                                 clocks = <&socplldiv2 0>;
> >                                 reg = <0x0 0x1f21c000 0x0 0x1000>;
> >                                 reg-names = "csr-reg";
> > -                               csr-mask = <0x3>;
> > +                               csr-mask = <0xa>;
> > +                               enable-mask = <0xf>;
> >                                 clock-output-names = "sge0clk";
> >                         };
> >
> > -                       sge1clk: sge1clk at 1f21c000 {
> > -                               compatible = "apm,xgene-device-clock";
> > -                               #clock-cells = <1>;
> > -                               clocks = <&socplldiv2 0>;
> > -                               reg = <0x0 0x1f21c000 0x0 0x1000>;
> > -                               reg-names = "csr-reg";
> > -                               csr-mask = <0xc>;
> > -                               clock-output-names = "sge1clk";
> > -                       };
> > -
> >                         xge0clk: xge0clk at 1f61c000 {
> >                                 compatible = "apm,xgene-device-clock";
> >                                 #clock-cells = <1>;
> > @@ -921,6 +912,14 @@
> >                         clocks = <&rtcclk 0>;
> >                 };
> >
> > +               mdio: mdio at 0x17020000 {
> > +                       compatible = "apm,xgene-mdio-rgmii";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0x0 0x17020000 0x0 0xd100>;
> > +                       clocks = <&menetclk 0>;
> > +               };
> > +
> >                 menet: ethernet at 17020000 {
>
>
> This new mmio node has the same unit address, and claims the same
> register window as the ethernet controller.
> That's doesn't seem correct?
Hi Olof,

Unfortunately, Iyappan is on vacation. He will respond as soon as he gets back.

Regards,
Duc Dang.
>
>
> -Olof
