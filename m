From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jun 2012 13:58:55 +0300
Subject: [PATCH v10 3/3] MTD: at91: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <94D61891A2E83846BC68FB50291DC2DD0F68A271@penmbx02>
References: <1338545594-18483-1-git-send-email-josh.wu@atmel.com>
 <1338545594-18483-4-git-send-email-josh.wu@atmel.com>
 <1338901457.2507.53.camel@sauron.fi.intel.com>
 <94D61891A2E83846BC68FB50291DC2DD0F68A271@penmbx02>
Message-ID: <1338980335.6875.44.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Wed, 2012-06-06 at 03:32 +0000, Wu, Josh wrote:
> > On Fri, 2012-06-01 at 18:13 +0800, Josh Wu wrote:
> >> +       end_time = jiffies +
> msecs_to_jiffies(PMECC_MAX_TIMEOUT_MS);
> >> +       while ((pmecc_readl_relaxed(host->ecc, SR) &
> PMECC_SR_BUSY)) {
> >> +               if (unlikely(time_after(jiffies, end_time))) {
> >> +                       dev_err(host->dev, "PMECC: Timeout to get
> ECC
> >> value.\n");
> >> +                       BUG();
> >> +               }
> >> +               cpu_relax();
> >> +       } 
> 
> > Sorry, but crashing the kernel is the worst thing to do. You should
> make
> > '->write_page()' allow to return an error code, just like
> > '->read_page()' does.
> 
> > -- 
> > Best Regards,
> > Artem Bityutskiy
> 
> I understand crashing kernel here is not good. but I think it makes a
> little sense because if the PMECC status reading is time out (I set a
> very long time duration here), that only means the PMECC configuration
> is not correct.

.. or that means that the hardware has issues, which happens sometimes,
or the driver has bugs, or whatever - there may be a lot of reasons, if
you do not foresee all of them, it does not mean they do not exist. Your
driver should be resilient to that. It should not crash the system but
should return an error.

> In other word, user needs set the PMECC correctly, then the PMECC
> status reading will not meet time out error. Otherwise they will get a
> Time out error.

Is BUG() a time-out error? It is more like "crash the kernel".

> Yes, If the '->write_page()' can return an error code then it should
> be better. But in the 'struct nand_ecc_ctrl', the '->write_page()'
> defined as void function, shows in following,
>         void (*write_page)(struct mtd_info *mtd, struct nand_chip
> *chip, const uint8_t *buf);

I alluded that you should just change this.
> 
> So change the above definition of '->write_page()' to return a error
> code will impact all other nand ecc code. Such change is out of the
> scope of this patch series. And maybe it also need another discussion.

But this is how opensource works. You are plugging a new driver to the
MTD infrastructure, and the infrastructure is not good enough for you,
probably because previously drivers never failed in '->write_page()'.
And it is your call to first change the infrastructure to fulfill your
needs, and then add the driver.

This happens to many people very often, and you should not get
frustrated, you just need to do a bit more work than you originally
planned.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120606/c81a171f/attachment-0001.sig>
