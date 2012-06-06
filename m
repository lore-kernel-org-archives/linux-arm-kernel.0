From: Josh.wu@atmel.com (Wu, Josh)
Date: Wed, 6 Jun 2012 03:32:08 +0000
Subject: [PATCH v10 3/3] MTD: at91: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <1338901457.2507.53.camel@sauron.fi.intel.com>
References: <1338545594-18483-1-git-send-email-josh.wu@atmel.com>
 <1338545594-18483-4-git-send-email-josh.wu@atmel.com>
 <1338901457.2507.53.camel@sauron.fi.intel.com>
Message-ID: <94D61891A2E83846BC68FB50291DC2DD0F68A271@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem

On 6/5/2012 9:04 PM, Artem Bityutskiy wrote:

> On Fri, 2012-06-01 at 18:13 +0800, Josh Wu wrote:
>> +       end_time = jiffies + msecs_to_jiffies(PMECC_MAX_TIMEOUT_MS);
>> +       while ((pmecc_readl_relaxed(host->ecc, SR) & PMECC_SR_BUSY)) {
>> +               if (unlikely(time_after(jiffies, end_time))) {
>> +                       dev_err(host->dev, "PMECC: Timeout to get ECC
>> value.\n");
>> +                       BUG();
>> +               }
>> +               cpu_relax();
>> +       } 

> Sorry, but crashing the kernel is the worst thing to do. You should make
> '->write_page()' allow to return an error code, just like
> '->read_page()' does.

> -- 
> Best Regards,
> Artem Bityutskiy

I understand crashing kernel here is not good. but I think it makes a little sense because if the PMECC status reading is time out (I set a very long time duration here), that only means the PMECC configuration is not correct. 
In other word, user needs set the PMECC correctly, then the PMECC status reading will not meet time out error. Otherwise they will get a Time out error.

Yes, If the '->write_page()' can return an error code then it should be better. But in the 'struct nand_ecc_ctrl', the '->write_page()' defined as void function, shows in following,
        void (*write_page)(struct mtd_info *mtd, struct nand_chip *chip, const uint8_t *buf);

So change the above definition of '->write_page()' to return a error code will impact all other nand ecc code. Such change is out of the scope of this patch series. And maybe it also need another discussion.

Best Regards,
Josh Wu
