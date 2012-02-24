From: timur@freescale.com (Timur Tabi)
Date: Fri, 24 Feb 2012 17:22:14 -0600
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120224231501.GD15120@n2100.arm.linux.org.uk>
References: <4F465A33.3020208@ru.mvista.com> <4F465EE5.4010908@freescale.com>
 <20120223165242.GB22562@n2100.arm.linux.org.uk>
 <4F4671BB.7060409@freescale.com>
 <20120223171407.GC22562@n2100.arm.linux.org.uk>
 <4F480120.6080409@freescale.com> <20120224215448
 <20120224231501.GD15120@n2100.arm.linux.org.uk>
Message-ID: <4F481BA6.7050705@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> What would be wrong with converting in_be32() in these drivers to
> instead ioread32be()?

Well, it wouldn't actually fix any problems.   It's just a stylistic
change for PowerPC.  On ARM, however, ioread32be() is wrong because the
SSI registers are little-endian.

In case you're confused:  the SSI is an I2S audio controller developed by
the i.MX (ARM) division on Freescale.  When the PowerPC division wanted to
add an I2S controller to its SOCs, they just took the same SSI device and
dropped in the PowerPC SOC.  But since PowerPC is big-endian, the
registers are byte-swapped in hardware.  So even though the i.MX SSI and
the PowerPC SSI have the same registers and do the same thing, those
actual registers are little-endian on i.MX and big-endian on PowerPC.

As far as I know, there is no single function in the kernel that will
perform an ordered 32-bit big-endian read on PowerPC and an ordered 32-bit
little-endian read on ARM.

-- 
Timur Tabi
Linux kernel developer at Freescale
