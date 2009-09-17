From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Sep 2009 11:31:01 +0300
Subject: [PATCH] Samsung SoCs: OneNAND support
In-Reply-To: <20090917081659.GA28591@july>
References: <20090917081659.GA28591@july>
Message-ID: <4AB1F3C5.7000309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2009 11:16 AM, Kyungmin Park wrote:
> +static int s3c_onenand_wait(struct mtd_info *mtd, int state)
> +{
> +	unsigned int flags = INT_ACT;
> +	unsigned int stat, ecc;
> +	unsigned long timeout;
> +
> +	switch (state) {
> +	case FL_READING:
> +		flags |= BLK_RW_CMP | LOAD_CMP;
> +		break;
> +	case FL_WRITING:
> +		flags |= BLK_RW_CMP | PGM_CMP;
> +		break;
> +	case FL_ERASING:
> +		flags |= BLK_RW_CMP | ERS_CMP;
> +		break;
> +	case FL_LOCKING:
> +		flags |= BLK_RW_CMP;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* The 20 msec is enough */
> +	timeout = jiffies + msecs_to_jiffies(20);
> +	while (time_before(jiffies, timeout)) {
> +		stat = s3c_read_reg(INT_ERR_STAT_OFFSET);
> +		if (stat&  flags)
> +			break;
> +
> +		if (state != FL_READING)
> +			cond_resched();
> +	}
> +	/* To get correct interrupt status in timeout case */
> +	stat = s3c_read_reg(INT_ERR_STAT_OFFSET);
> +	s3c_write_reg(stat, INT_ERR_ACK_OFFSET);
> +
> +	/*
> +	 * 	
> +	 * In the Spec. it checks the controller status first
> +	 * However if you get the correct information in case of
> +	 * power off recovery (POR) test, it should read ECC status first
> +	 */
> +	if (stat&  LOAD_CMP) {
> +		ecc = s3c_read_reg(ECC_ERR_STAT_OFFSET);
> +		if (ecc&  ONENAND_ECC_4BIT_UNCORRECTABLE) {
> +			printk(KERN_INFO "onenand_wait: ECC error = 0x%04x\n", ecc);

Copy-paste error? Also see below.

> +			mtd->ecc_stats.failed++;
> +			return -EBADMSG;
> +		}
> +	}
> +
> +	if (stat&  (LOCKED_BLK | ERS_FAIL | PGM_FAIL | LD_FAIL_ECC_ERR)) {
> +		printk(KERN_INFO "s3c_onenand_wait: controller error = 0x%04x\n", stat);
> +		if (stat&  LOCKED_BLK)
> +			printk(KERN_INFO "s3c_onenand_wait: it's locked error = 0x%04x\n", stat);

Very quick comment. Could you please avoid this style of putting function
name to the printk? We have lots of this in onenand_base.c, and they are
often wrong, because function names change.

Could we please use dev_printk(), dev_dbg() and the like instead? You'll have
to do some more work and make MTD a bit more linux-device-model-friendly, but
someone has to do this :-)

But in the worst case, use at least %s + __func__.

And you could also clean things up similarly for onenenand.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
