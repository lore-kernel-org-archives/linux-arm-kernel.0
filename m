From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 14 Nov 2016 09:53:28 -0800
Subject: [PATCH 1/2] mfd: pm8921: add support to pm8821
In-Reply-To: <852fbb95-852e-0612-77a8-b0b072a68c51@linaro.org>
References: <1478622577-20699-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20161108190751.GO25787@tuxbot>
 <852fbb95-852e-0612-77a8-b0b072a68c51@linaro.org>
Message-ID: <20161114175328.GB27931@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 14 Nov 09:33 PST 2016, Srinivas Kandagatla wrote:

[..]
> >>+static int pm8821_irq_block_handler(struct pm_irq_chip *chip,
> >>+				    int master_number, int block)
> >>+{
> >>+	int pmirq, irq, i, ret;
> >>+	unsigned int bits;
> >>+
> >>+	ret = pm8821_read_block_irq(chip, master_number, block, &bits);
> >>+	if (ret) {
> >>+		pr_err("Failed reading %d block ret=%d", block, ret);
> >>+		return ret;
> >>+	}
> >>+	if (!bits) {
> >>+		pr_err("block bit set in master but no irqs: %d", block);
> >>+		return 0;
> >>+	}
> >>+
> >>+	/* Convert block offset to global block number */
> >>+	block += (master_number * PM8821_BLOCKS_PER_MASTER) - 1;
> >
> >So this is block -= 1 for master 0 and block += 6 for master 1, is the
> >latter correct?
> >
> Yes, both of them are correct.
> 
> for master 0 which has block numbers from 1-7 should translate to 0-6 in
> linear space.
> for master 1 which has block numbers from 1-7 should translate to 7-13 in
> linear space.
> 
> so for master0 it is -=1 and and for master1 it is +=6 seems correct.
> 

Ahh, because block is 1-indexed when we enter, so have to switch base
and then calculate the global number, like:

  block = block - 1 + (master * PER_MASTER) + 7

but we cancel out the subtraction. I agree that this looks correct then.

I would prefer less of a mixture between 0-indexing and 1-indexing, but
I don't have any good ideas on how to restructure it to make it better.

Regards,
Bjorn
