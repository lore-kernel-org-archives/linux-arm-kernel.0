From: marex@denx.de (Marek Vasut)
Date: Fri, 5 Jun 2015 16:13:09 +0200
Subject: [PATCH 04/11] mtd: ofpart: do not fail probe when no partitions
 exist
In-Reply-To: <CAOMqctQTxVZspcocDsNP6GzsRw5-0zPqkNScS8PzNvkFjBWatQ@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <201506041728.50227.marex@denx.de>
 <CAOMqctQTxVZspcocDsNP6GzsRw5-0zPqkNScS8PzNvkFjBWatQ@mail.gmail.com>
Message-ID: <201506051613.09187.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 04, 2015 at 05:40:58 PM, Michal Suchanek wrote:
> On 4 June 2015 at 17:28, Marek Vasut <marex@denx.de> wrote:
> > On Thursday, June 04, 2015 at 06:54:00 AM, Michal Suchanek wrote:
> >> On 4 June 2015 at 00:58, Marek Vasut <marex@denx.de> wrote:
> >> > On Wednesday, June 03, 2015 at 11:26:40 PM, Michal Suchanek wrote:
> >> >> On Exynos it is necessary to set SPI controller parameters that apply
> >> >> to a SPI slave in a DT subnode of the slave device. The ofpart code
> >> >> returns an error when there are subnodes of the SPI flash but no
> >> >> partitions are found. Change this condition to a warning so that
> >> >> flash without partitions can be accessed on Exynos.
> >> > 
> >> > I have to admit the rationale for this patch is not very clear to me,
> >> > sorry. Can you please explain this a bit more ?
> >> 
> >> This is how the DT entry for SPI slave looks with s3c64xx:
> >> flash: m25p80 at 0 {
> >> 
> >>         #address-cells = <1>;
> >>         #size-cells = <1>;
> >>         compatible = "jedec,spi-nor";
> >>         reg = <0>;
> >>         spi-max-frequency = <40000000>;
> >>         linux,max_tx_len = <65536>;
> > 
> > SIDENOTE: I thought this was actually added by your patch #8 in this
> > series. The underscores in the name of the property are not really
> > consistent with the rest of the names.
> > 
> >>         m25p,fast-read;
> >>         controller-data {
> >>         
> >>             samsung,spi-feedback-delay = <0>;
> >>         
> >>         };
> >>     
> >>     };
> >> 
> >> this is example of flash partitions:
> >> flash at 0 {
> >> 
> >>         #address-cells = <1>;
> >>         #size-cells = <1>;
> >>         
> >>         partition at 0 {
> >>         
> >>                 label = "u-boot";
> >>                 reg = <0x0000000 0x100000>;
> >>                 read-only;
> >>         
> >>         };
> >>         
> >>         uimage at 100000 {
> >>         
> >>                 reg = <0x0100000 0x200000>;
> >>         
> >>         };
> >> 
> >> };
> >> 
> >> The parser ignores any flash without subnodes and returns 0 (no
> >> partititon). When there is a subnode it assumes the flash is
> >> partitioned and tries to parse the subnodes as partitions. When there
> >> are subnodes and none parses as partition an error is returned. As
> >> shown above it is valid to have subnodes on unpartitioned flash.
> >> 
> >> When an error is returned from a partition parser the mtdpart code
> >> passes on this error to the flash probe function and the proble of the
> >> flash fails.
> > 
> > What does /proc/mtd tell you when you have no partitions defined
> > in the DT ? It should provide you with the entire MTD device and
> > the code shouldn't even try to parse any OF partitions, since you
> > don't have any.
> 
> mtdinfo shows I have no mtd devices and the log shows that probe
> failed unless I patch the kernel.
> 
> When there is *support* for of partitions the ofparser is run on mtd
> probe. If it fails because it considers
> 
> >>         controller-data {
> >>         
> >>             samsung,spi-feedback-delay = <0>;
> >>         
> >>         };
> 
> an invalid partition and does not find any valid partition the probe fails.

OK, now it has become clearer to me, thanks!

> There are two problems here
> 
> 1) the above is not invalid. It just is not a partition. The parser
> should not fail seeing this

The parser should complain verbosely and ignore this I guess ?

> 2) the mtd probe should not fail when a partition parser fails and
> should present the unpartitioned device

OK

> Both are addressed in separate patches.
> 
> Thanks
> 
> Michal
