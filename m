From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 00:11:29 -0600
Subject: [PATCH 19/20] ARM: Exynos5: Add combiner,
 wakeup interrupt controller and ethernet nodes
In-Reply-To: <CAOesGMhxn6L+Pcp-v2v6z7srGd=8kGwqff7Tt6ok8pHMVXp3ZQ@mail.gmail.com>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-20-git-send-email-thomas.abraham@linaro.org>
 <CAOesGMhxn6L+Pcp-v2v6z7srGd=8kGwqff7Tt6ok8pHMVXp3ZQ@mail.gmail.com>
Message-ID: <20120519061129.BEE9D3E046E@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 May 2012 10:57:11 -0700, Olof Johansson <olof@lixom.net> wrote:
> Hi,
> 
> [adding devicetree-discuss]
> 
> On Mon, Apr 30, 2012 at 12:14 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> > And interrupt combiner, external interrupt wakeup interrupt controller
> > and smsc9215 lan controller nodes.
> >
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> > ---
> > ??arch/arm/boot/dts/exynos5250-smdk5250.dts | ?? 11 ++++++
> > ??arch/arm/boot/dts/exynos5250.dtsi ?? ?? ?? ?? | ?? 55 +++++++++++++++++++++++++++++
> > ??2 files changed, 66 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > index bcc4b89..dbc4bdb 100644
> > --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> > @@ -24,6 +24,17 @@
> > ?? ?? ?? ?? ?? ?? ?? ??bootargs = "root=/dev/ram0 rw ramdisk=8192 console=ttySAC1,115200";
> > ?? ?? ?? ??};
> >
> > + ?? ?? ?? lan9215 at 0x05000000 {
> > + ?? ?? ?? ?? ?? ?? ?? compatible = "smsc,lan9215", "smsc,lan9115";
> > + ?? ?? ?? ?? ?? ?? ?? reg = <0x05000000 0x20000>;
> > + ?? ?? ?? ?? ?? ?? ?? interrupts = <5 0>;
> > + ?? ?? ?? ?? ?? ?? ?? interrupt-parent = <&wakeup_eint>;
> > + ?? ?? ?? ?? ?? ?? ?? phy-mode = "mii";
> > + ?? ?? ?? ?? ?? ?? ?? smsc,irq-push-pull;
> > + ?? ?? ?? ?? ?? ?? ?? smsc,force-internal-phy;
> > + ?? ?? ?? ?? ?? ?? ?? local-mac-address = [00 80 00 23 45 67];
> > + ?? ?? ?? };
> > +
> 
> since the 911x sits on a chipselect bus, you should instead add that
> bus to the dtsi and define this on that bus.
> 
> Something like this in the dtsi:
> 
>        sromc-bus {
>                #address-cells = <2>;
>                #size-cells = <1>;
>                ranges = < 0 0 0x04000000 0x20000
>                           1 0 0x05000000 0x20000
>                           2 0 0x06000000 0x20000
>                           3 0 0x07000000 0x20000>;
>        };
> 
> and in the dts:
> 
>        sromc-bus {
>                lan9215 at 1,0 {
>                        compatible = "smsc,lan9215", "smsc,lan9115";
>                        reg = <1 0 0x20000>;
>                        interrupts = <5 0>;
>                        interrupt-parent = <&wakeup_eint>;
>                        phy-mode = "mii";
>                        smsc,irq-push-pull;
>                        smsc,force-internal-phy;
>                        local-mac-address = [00 80 00 23 45 67];
>                };
>         };
> 
> 
> (You might be able to do just fine with one address cell, I'm not 100%
> sure why Grant's example uses two, but I used the same above for
> consistency).

Because otherwise there is no way to describe an offset from the base
of the chipselect base value, and the core code will try to apply the
size to the cs part of the address specifier. (so in the example
above the address range described by:

	reg = <1 0x20000>;

would mean cs values 1 to 0x20001; which is definitely wrong.

> Also, I don't think it's a good idea to hardcode the mac address in
> the dts like this; have u-boot fill it in from the environment
> variable there instead, if needed.

Very bad practice indeed.
