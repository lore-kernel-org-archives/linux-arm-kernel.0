From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 5 May 2017 09:49:39 +0000
Subject: [RFC PATCH] mtd: spi-nor: handle signal case as failure
In-Reply-To: <845ce78f-f3b0-35c0-8e3d-580ce4e1f63a@st.com>
References: <1493805189-25327-1-git-send-email-der.herr@hofr.at>
 <b3de06f6-9fcd-4b58-60f2-14c55d83898d@wedev4u.fr>
 <845ce78f-f3b0-35c0-8e3d-580ce4e1f63a@st.com>
Message-ID: <20170505094939.GB13297@osadl.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 09:40:11AM +0200, Ludovic BARRE wrote:
> On 05/03/2017 11:23 PM, Cyrille Pitchen wrote:
> >Hi all,
> >
> >Le 03/05/2017 ? 11:53, Nicholas Mc Guire a ?crit :
> >>  The problem is that stm32_qspi_wait_cmd() will indicate success in case of
> >>  being interrupted. The if condition is incomplete here as
> >>  wait_for_copletion_interruptible_timeout can return -ERESTARTSYS but this
> >>  is not handled by if(!wait_for_completion_interruptible_timeout()).
> >>  While somewhat unlikely it probably would be hard to figure out what went
> >>  wrong if the signal case does occur.
> >>
> >>Fixes: commit 0d43d7ab277a ("mtd: spi-nor: add driver for STM32 quad spi flash controller")
> >>Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> >>---
> >>Problem found by experimental coccinelle script
> >>
> >>Its not clear if its sufficient to simply treat this case as failure or
> >>if it might need some debug output to allow differentiation of signal
> >>and timeout case.
> >>
> >>Patch was compile tested with: stm32_defconfig +CONFIG_MTD=y, CONFIG_MTD_SPI_NOR=y,
> >>CONFIG_SPI_STM32_QUADSPI=m
> >>
> >>Patch is against v4.11-rc8 (localversion-next is next-20170503)
> >>
> >>  drivers/mtd/spi-nor/stm32-quadspi.c  | 10 ++++++++--
> >>  1 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
> >>index 1056e74..27147ad 100644
> >>--- a/drivers/mtd/spi-nor/stm32-quadspi.c
> >>+++ b/drivers/mtd/spi-nor/stm32-quadspi.c
> >>@@ -159,6 +159,7 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi)
> >>  {
> >>  	u32 cr;
> >>  	int err = 0;
> >>+	long timeout = 0;
> >>  	if (readl_relaxed(qspi->io_base + QUADSPI_SR) & SR_TCF)
> >>  		return 0;
> >>@@ -167,8 +168,13 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi)
> >>  	cr = readl_relaxed(qspi->io_base + QUADSPI_CR);
> >>  	writel_relaxed(cr | CR_TCIE, qspi->io_base + QUADSPI_CR);
> >>-	if (!wait_for_completion_interruptible_timeout(&qspi->cmd_completion,
> >>-						       msecs_to_jiffies(1000)))
> >Ludovic, can we just use wait_for_completion_timeout() instead?
> exactly, I would use _interruptible extension to allow "user" to
> abort a long transfer (without wait the end of command transfert).
> But it's not crucial for stm32_qspi, this could be replace by
> wait_for_completion_timeout.
> sorry to disturb the "mtd pull" :-(
>
ok - so would you take care of this then - I guess it makes more
sense for the patch to come from someone that understand the context
than from someone that just pinpionted an inconsistency in API use.

thx!
hofrat 
