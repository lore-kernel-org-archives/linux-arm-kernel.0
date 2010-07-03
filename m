From: jason77.wang@gmail.com (jason)
Date: Sat, 03 Jul 2010 19:21:45 +0800
Subject: [PATCH] spi/omap2_mcspi: disable and enable chan between each
	SPI 	transfer
In-Reply-To: <E1C7579D1379824DAE67858071C810382DD859571A@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTin7mqe_zJIbyDcRPpCLaxPhl_dZQrSGua2z1nYW@mail.gmail.com>
	<4C24A182.4060009@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD8495B26@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C289CCB.7010409@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD84963BC@NOK-EUMSG-02.mgdnok.nokia.com>
	<4C2C82E9.2010103@gmail.com>
	<E1C7579D1379824DAE67858071C810382DD859571A@NOK-EUMSG-02.mgdnok.nokia.com>
Message-ID: <4C2F1D49.3090802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

roman.tereshonkov at nokia.com wrote:
> Hi Jason,
>
> Your logs do not show what I wanted to see.
> But what I can see now at least is the case when TX is full and RX is full at the same time.
>
> 1.  Put 
> 	dev_dbg(&spi->dev, "status reg: %08x\n", __raw_readl(chstat_reg));
> 	after "do" and before "while (c)" in omap2_mcspi_txrx_pio function.
> 	I want to see how status is changed before and after TX or RX transaction.
> 2. Also try to make fake reading 
> 	__raw_readl(tx_reg)
> 	 after TX write in omap2_mcspi_txrx_pio.
> 	and 
> 	__raw_readl(cs->base + OMAP2_MCSPI_TX0);
> 	in mcspi_work function.
> 	This should exclude the posted write effect if such present.
>
> If you put more logging info from other spi registers it might be also usefull in problem analyzing.
> And it is better to concentrate on your test case 1. 
> So as it is the test which gives the bug with unknown yet nature.
>
>
>
> Regards
> Roman Tereshonkov
>
>   
Hi roman,
The test is designed just as your suggestion.

We get status reg=0x5(RX Full & TX FULL at the same time) in the first 
round in RX_ONLY
transfer. It seems that the RX_ONLY triggering write is not finished yet 
but we have received something.
I guess the last received data in TX_ONLY transfer affect the FXS bit in 
the first round of RX_ONLY transfer.


<4>======SPI MESSAGE BEGIN======
<7>ads7846 spi1.0: work tx reg(1): 00000000
<7>ads7846 spi1.0: after do stat reg: 00000006
<7>ads7846 spi1.0: write-8 93
<7>ads7846 spi1.0: after write tx reg: 00000093
<7>ads7846 spi1.0: before while(c) stat reg: 00000006
<7>ads7846 spi1.0: work tx reg(1): 00000093
<7>ads7846 spi1.0: after do stat reg: 00000000
<7>ads7846 spi1.0: status reg: 00000005
<7>ads7846 spi1.0: read-8 f0
<7>ads7846 spi1.0: before while(c) stat reg: 00000007
<7>ads7846 spi1.0: after do stat reg: 00000007
<7>ads7846 spi1.0: status reg: 00000007
<7>ads7846 spi1.0: read-8 77
<7>ads7846 spi1.0: before while(c) stat reg: 00000006
<7>ads7846 spi1.0: work tx reg(1): 00000000
<7>ads7846 spi1.0: after do stat reg: 00000006
<7>ads7846 spi1.0: write-8 93
<7>ads7846 spi1.0: after write tx reg: 00000093
<7>ads7846 spi1.0: before while(c) stat reg: 00000006
<7>ads7846 spi1.0: work tx reg(1): 00000093
<7>ads7846 spi1.0: after do stat reg: 00000000
<7>ads7846 spi1.0: status reg: 00000005
<7>ads7846 spi1.0: read-8 f8
<7>ads7846 spi1.0: before while(c) stat reg: 00000007
<7>ads7846 spi1.0: after do stat reg: 00000007
<7>ads7846 spi1.0: status reg: 00000007
<7>ads7846 spi1.0: read-8 75
<7>ads7846 spi1.0: before while(c) stat reg: 00000006
<4>.....SPI MESSAGE END.....


Subject: [PATCH] SPI/test1: print tx data & rx data when ads7846 works

when we touch the top-left corner of the touchscreen, the ads7846
driver will send a read-y command(one 8-bit word, 0x93) and receive
y coordinate(two 8-bit words, MSB 12bits are meaningful). now print
all tx word, staus reg and rx word when RXS bit is set. Test1 only
add debug output and have no other modification.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
drivers/spi/omap2_mcspi.c | 32 ++++++++++++++++++++++++++++++--
1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b3a94ca..76bbdeb 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -40,6 +40,8 @@
#include <plat/clock.h>
#include <plat/mcspi.h>

+#define VERBOSE
+
#define OMAP2_MCSPI_MAX_FREQ 48000000

/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
@@ -482,6 +484,10 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct 
spi_transfer *xfer)
tx = xfer->tx_buf;

do {
+#ifdef VERBOSE
+ dev_dbg(&spi->dev, "after do stat reg: %08x\n",
+ __raw_readl(chstat_reg));
+#endif
c -= 1;
if (tx != NULL) {
if (mcspi_wait_for_reg_bit(chstat_reg,
@@ -494,6 +500,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct 
spi_transfer *xfer)
word_len, *tx);
#endif
__raw_writel(*tx++, tx_reg);
+
+#ifdef VERBOSE
+ dev_dbg(&spi->dev, "after write tx reg: %08x\n",
+ __raw_readl(tx_reg));
+#endif
+
}
if (rx != NULL) {
if (mcspi_wait_for_reg_bit(chstat_reg,
@@ -502,6 +514,11 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct 
spi_transfer *xfer)
goto out;
}

+#ifdef VERBOSE
+ dev_dbg(&spi->dev, "status reg: %08x\n",
+ __raw_readl(chstat_reg));
+#endif
+
if (c == 1 && tx == NULL &&
(l & OMAP2_MCSPI_CHCONF_TURBO)) {
omap2_mcspi_set_enable(spi, 0);
@@ -527,6 +544,11 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct 
spi_transfer *xfer)
word_len, *(rx - 1));
#endif
}
+
+#ifdef VERBOSE
+ dev_dbg(&spi->dev, "before while(c) stat reg: %08x\n",
+ __raw_readl(chstat_reg));
+#endif
} while (c);
} else if (word_len <= 16) {
u16 *rx;
@@ -893,9 +915,15 @@ static void omap2_mcspi_work(struct work_struct *work)
spi = m->spi;
cs = spi->controller_state;
cd = spi->controller_data;
-
+ printk("======SPI MESSAGE BEGIN======\n");
omap2_mcspi_set_enable(spi, 1);
list_for_each_entry(t, &m->transfers, transfer_list) {
+
+#ifdef VERBOSE
+ dev_dbg(&spi->dev, "work tx reg(1): %08x\n",
+ __raw_readl(cs->base + OMAP2_MCSPI_TX0));
+#endif
+
if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
status = -EINVAL;
break;
@@ -971,7 +999,7 @@ static void omap2_mcspi_work(struct work_struct *work)
omap2_mcspi_force_cs(spi, 0);

omap2_mcspi_set_enable(spi, 0);
-
+ printk(".....SPI MESSAGE END.....\n");
m->status = status;
m->complete(m->context);

-- 
1.5.6.5
