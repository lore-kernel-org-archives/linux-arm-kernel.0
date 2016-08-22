From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 22 Aug 2016 09:44:37 +0200
Subject: [PATCH v2 1/2] mtd: brcmnand: iProc big endian and ONFI support
In-Reply-To: <CAC=U0a2fA=aYbfDdhcdRPATFuPEWd8qmdajwdn4UAFn=R4rUsQ@mail.gmail.com>
References: <1469051631-7896-1-git-send-email-ray.jui@broadcom.com>
 <1469051631-7896-2-git-send-email-ray.jui@broadcom.com>
 <20160810162438.4c6cffd3@bbrezillon>
 <CAC=U0a2fA=aYbfDdhcdRPATFuPEWd8qmdajwdn4UAFn=R4rUsQ@mail.gmail.com>
Message-ID: <20160822094437.4e9fec83@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Aug 2016 11:14:17 -0400
Kamal Dasu <kdasu.kdev@gmail.com> wrote:

> Boris
> 
> This change  looks good to me.

Is this an Acked-by or a Reviewed-by? :)

> 
> 
> On Wed, Aug 10, 2016 at 10:24 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Wed, 20 Jul 2016 14:53:50 -0700
> > Ray Jui <ray.jui@broadcom.com> wrote:
> >  
> >> This patch adds big endian and ONFI support for various iProc based
> >> SoCs that use the core brcmstb NAND controller  
> >
> > Brian, Kamal, can you review this patch?
> >  
> >>
> >> This patch was originally implemented by Prafulla Kota
> >> <prafulla.kota@broadcom.com> and fully tested on iProc based NS2 SVK
> >>
> >> Signed-off-by: Prafulla Kota <prafulla.kota@broadcom.com>
> >> Signed-off-by: Ray Jui <ray.jui@broadcom.com>  
> 
> Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
> 
> >> ---
> >>  drivers/mtd/nand/brcmnand/brcmnand.c   | 12 ++++++------
> >>  drivers/mtd/nand/brcmnand/brcmnand.h   | 13 ++++++++-----
> >>  drivers/mtd/nand/brcmnand/iproc_nand.c | 18 ++++++++++++++----
> >>  3 files changed, 28 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
> >> index b76ad7c..12a1585 100644
> >> --- a/drivers/mtd/nand/brcmnand/brcmnand.c
> >> +++ b/drivers/mtd/nand/brcmnand/brcmnand.c
> >> @@ -1279,7 +1279,7 @@ static void brcmnand_cmdfunc(struct mtd_info *mtd, unsigned command,
> >>               u32 *flash_cache = (u32 *)ctrl->flash_cache;
> >>               int i;
> >>
> >> -             brcmnand_soc_data_bus_prepare(ctrl->soc);
> >> +             brcmnand_soc_data_bus_prepare(ctrl->soc, true);
> >>
> >>               /*
> >>                * Must cache the FLASH_CACHE now, since changes in
> >> @@ -1292,7 +1292,7 @@ static void brcmnand_cmdfunc(struct mtd_info *mtd, unsigned command,
> >>                        */
> >>                       flash_cache[i] = be32_to_cpu(brcmnand_read_fc(ctrl, i));
> >>
> >> -             brcmnand_soc_data_bus_unprepare(ctrl->soc);
> >> +             brcmnand_soc_data_bus_unprepare(ctrl->soc, true);
> >>
> >>               /* Cleanup from HW quirk: restore SECTOR_SIZE_1K */
> >>               if (host->hwcfg.sector_size_1k)
> >> @@ -1508,12 +1508,12 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
> >>               brcmnand_waitfunc(mtd, chip);
> >>
> >>               if (likely(buf)) {
> >> -                     brcmnand_soc_data_bus_prepare(ctrl->soc);
> >> +                     brcmnand_soc_data_bus_prepare(ctrl->soc, false);
> >>
> >>                       for (j = 0; j < FC_WORDS; j++, buf++)
> >>                               *buf = brcmnand_read_fc(ctrl, j);
> >>
> >> -                     brcmnand_soc_data_bus_unprepare(ctrl->soc);
> >> +                     brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
> >>               }
> >>
> >>               if (oob)
> >> @@ -1678,12 +1678,12 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
> >>               (void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
> >>
> >>               if (buf) {
> >> -                     brcmnand_soc_data_bus_prepare(ctrl->soc);
> >> +                     brcmnand_soc_data_bus_prepare(ctrl->soc, false);
> >>
> >>                       for (j = 0; j < FC_WORDS; j++, buf++)
> >>                               brcmnand_write_fc(ctrl, j, *buf);
> >>
> >> -                     brcmnand_soc_data_bus_unprepare(ctrl->soc);
> >> +                     brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
> >>               } else if (oob) {
> >>                       for (j = 0; j < FC_WORDS; j++)
> >>                               brcmnand_write_fc(ctrl, j, 0xffffffff);
> >> diff --git a/drivers/mtd/nand/brcmnand/brcmnand.h b/drivers/mtd/nand/brcmnand/brcmnand.h
> >> index ef5eabb..5c44cd4 100644
> >> --- a/drivers/mtd/nand/brcmnand/brcmnand.h
> >> +++ b/drivers/mtd/nand/brcmnand/brcmnand.h
> >> @@ -23,19 +23,22 @@ struct dev_pm_ops;
> >>  struct brcmnand_soc {
> >>       bool (*ctlrdy_ack)(struct brcmnand_soc *soc);
> >>       void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
> >> -     void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare);
> >> +     void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
> >> +                              bool is_param);
> >>  };
> >>
> >> -static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc)
> >> +static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc,
> >> +                                              bool is_param)
> >>  {
> >>       if (soc && soc->prepare_data_bus)
> >> -             soc->prepare_data_bus(soc, true);
> >> +             soc->prepare_data_bus(soc, true, is_param);
> >>  }
> >>
> >> -static inline void brcmnand_soc_data_bus_unprepare(struct brcmnand_soc *soc)
> >> +static inline void brcmnand_soc_data_bus_unprepare(struct brcmnand_soc *soc,
> >> +                                                bool is_param)
> >>  {
> >>       if (soc && soc->prepare_data_bus)
> >> -             soc->prepare_data_bus(soc, false);
> >> +             soc->prepare_data_bus(soc, false, is_param);
> >>  }
> >>
> >>  static inline u32 brcmnand_readl(void __iomem *addr)
> >> diff --git a/drivers/mtd/nand/brcmnand/iproc_nand.c b/drivers/mtd/nand/brcmnand/iproc_nand.c
> >> index 585596c..4c6ae11 100644
> >> --- a/drivers/mtd/nand/brcmnand/iproc_nand.c
> >> +++ b/drivers/mtd/nand/brcmnand/iproc_nand.c
> >> @@ -74,7 +74,8 @@ static void iproc_nand_intc_set(struct brcmnand_soc *soc, bool en)
> >>       spin_unlock_irqrestore(&priv->idm_lock, flags);
> >>  }
> >>
> >> -static void iproc_nand_apb_access(struct brcmnand_soc *soc, bool prepare)
> >> +static void iproc_nand_apb_access(struct brcmnand_soc *soc, bool prepare,
> >> +                               bool is_param)
> >>  {
> >>       struct iproc_nand_soc *priv =
> >>                       container_of(soc, struct iproc_nand_soc, soc);
> >> @@ -86,10 +87,19 @@ static void iproc_nand_apb_access(struct brcmnand_soc *soc, bool prepare)
> >>
> >>       val = brcmnand_readl(mmio);
> >>
> >> -     if (prepare)
> >> -             val |= IPROC_NAND_APB_LE_MODE;
> >> -     else
> >> +     /*
> >> +      * In the case of BE or when dealing with NAND data, alway configure
> >> +      * the APB bus to LE mode before accessing the FIFO and back to BE mode
> >> +      * after the access is done
> >> +      */
> >> +     if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) || !is_param) {
> >> +             if (prepare)
> >> +                     val |= IPROC_NAND_APB_LE_MODE;
> >> +             else
> >> +                     val &= ~IPROC_NAND_APB_LE_MODE;
> >> +     } else { /* when in LE accessing the parameter page, keep APB in BE */
> >>               val &= ~IPROC_NAND_APB_LE_MODE;
> >> +     }
> >>
> >>       brcmnand_writel(val, mmio);
> >>  
> >  
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
