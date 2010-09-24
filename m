From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Sep 2010 17:00:38 +0100
Subject: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
In-Reply-To: <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
	<1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
	<AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
	<AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
Message-ID: <20100924160038.GD14809@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 08:38:37AM -0700, Cory Maccarrone wrote:
> Not really sure, I wasn't the one who first came up with that mask.
> All I know is that it seems to work, and not just for my device, but
> lots of other HTC OMAP850 devices we've tried it on too.
> 
> I'm interested though, what in particular makes it unusual?

It's normal to set all bits between the maximum and minimum voltages
rather than alternate bits.  So if you support voltages between 3.0
and 3.5 volts, all these should be used:

#define MMC_VDD_30_31           0x00040000      /* VDD voltage 3.0 ~ 3.1 */
#define MMC_VDD_31_32           0x00080000      /* VDD voltage 3.1 ~ 3.2 */
#define MMC_VDD_32_33           0x00100000      /* VDD voltage 3.2 ~ 3.3 */
#define MMC_VDD_33_34           0x00200000      /* VDD voltage 3.3 ~ 3.4 */
#define MMC_VDD_34_35           0x00400000      /* VDD voltage 3.4 ~ 3.5 */

rather than just MMC_VDD_30_31, MMC_VDD_32_33, MMC_VDD_34_35.

Note that if you support just one voltage, (eg, 3.3V) you should
use the two which overlap this - MMC_VDD_32_33 and MMC_VDD_33_34.
There are cards which go unresponsive if you supply just a single
bit in the OCR mask.
