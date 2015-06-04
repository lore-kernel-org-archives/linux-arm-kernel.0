From: marex@denx.de (Marek Vasut)
Date: Thu, 4 Jun 2015 17:28:50 +0200
Subject: [PATCH 04/11] mtd: ofpart: do not fail probe when no partitions
 exist
In-Reply-To: <CAOMqctTB2AYOQZUc9o-R4PF1DQ-HY0RfSw5T-T28r5uP2s=qZA@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <201506040058.52882.marex@denx.de>
 <CAOMqctTB2AYOQZUc9o-R4PF1DQ-HY0RfSw5T-T28r5uP2s=qZA@mail.gmail.com>
Message-ID: <201506041728.50227.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 04, 2015 at 06:54:00 AM, Michal Suchanek wrote:
> On 4 June 2015 at 00:58, Marek Vasut <marex@denx.de> wrote:
> > On Wednesday, June 03, 2015 at 11:26:40 PM, Michal Suchanek wrote:
> >> On Exynos it is necessary to set SPI controller parameters that apply to
> >> a SPI slave in a DT subnode of the slave device. The ofpart code returns
> >> an error when there are subnodes of the SPI flash but no partitions are
> >> found. Change this condition to a warning so that flash without
> >> partitions can be accessed on Exynos.
> > 
> > I have to admit the rationale for this patch is not very clear to me,
> > sorry. Can you please explain this a bit more ?
> 
> This is how the DT entry for SPI slave looks with s3c64xx:
> flash: m25p80 at 0 {
>         #address-cells = <1>;
>         #size-cells = <1>;
>         compatible = "jedec,spi-nor";
>         reg = <0>;
>         spi-max-frequency = <40000000>;
>         linux,max_tx_len = <65536>;

SIDENOTE: I thought this was actually added by your patch #8 in this
series. The underscores in the name of the property are not really
consistent with the rest of the names.

>         m25p,fast-read;
>         controller-data {
>             samsung,spi-feedback-delay = <0>;
>         };
>     };
> 
> this is example of flash partitions:
> flash at 0 {
>         #address-cells = <1>;
>         #size-cells = <1>;
> 
>         partition at 0 {
>                 label = "u-boot";
>                 reg = <0x0000000 0x100000>;
>                 read-only;
>         };
> 
>         uimage at 100000 {
>                 reg = <0x0100000 0x200000>;
>         };
> };
> 
> The parser ignores any flash without subnodes and returns 0 (no
> partititon). When there is a subnode it assumes the flash is
> partitioned and tries to parse the subnodes as partitions. When there
> are subnodes and none parses as partition an error is returned. As
> shown above it is valid to have subnodes on unpartitioned flash.
>
> When an error is returned from a partition parser the mtdpart code
> passes on this error to the flash probe function and the proble of the
> flash fails.

What does /proc/mtd tell you when you have no partitions defined
in the DT ? It should provide you with the entire MTD device and
the code shouldn't even try to parse any OF partitions, since you
don't have any.

Best regards,
Marek Vasut
