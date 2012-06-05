From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 05 Jun 2012 16:04:17 +0300
Subject: [PATCH v10 3/3] MTD: at91: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <1338545594-18483-4-git-send-email-josh.wu@atmel.com>
References: <1338545594-18483-1-git-send-email-josh.wu@atmel.com>
 <1338545594-18483-4-git-send-email-josh.wu@atmel.com>
Message-ID: <1338901457.2507.53.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-06-01 at 18:13 +0800, Josh Wu wrote:
> +       end_time = jiffies + msecs_to_jiffies(PMECC_MAX_TIMEOUT_MS);
> +       while ((pmecc_readl_relaxed(host->ecc, SR) & PMECC_SR_BUSY)) {
> +               if (unlikely(time_after(jiffies, end_time))) {
> +                       dev_err(host->dev, "PMECC: Timeout to get ECC
> value.\n");
> +                       BUG();
> +               }
> +               cpu_relax();
> +       } 

Sorry, but crashing the kernel is the worst thing to do. You should make
'->write_page()' allow to return an error code, just like
'->read_page()' does.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/64e19bed/attachment.sig>
