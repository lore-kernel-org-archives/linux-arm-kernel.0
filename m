From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Feb 2011 00:30:54 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <AANLkTi=yj716us6bHFfGRwm2Q_iPEAJeQHDjB=3_pTe5@mail.gmail.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<20110130212939.GA384@n2100.arm.linux.org.uk>
	<AANLkTi=yj716us6bHFfGRwm2Q_iPEAJeQHDjB=3_pTe5@mail.gmail.com>
Message-ID: <20110203003054.GA7068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 11:24:09AM +0100, Linus Walleij wrote:
> 2011/1/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > ? ? ? ? ? ? ? ? ? ? ? ?data->error = -EILSEQ;
> > ? ? ? ? ? ? ? ?} else if (status & MCI_DATATIMEOUT) {
> > - ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = success;
> > + ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = success & ~(data->blksz - 1);
> > ? ? ? ? ? ? ? ? ? ? ? ?data->error = -ETIMEDOUT;
> > ? ? ? ? ? ? ? ?} else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
> > - ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = success;
> > + ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = success & ~(data->blksz - 1);
> > ? ? ? ? ? ? ? ? ? ? ? ?data->error = -EIO;
> > ? ? ? ? ? ? ? ?}

Grr, we still haven't got this quite right.  If I make the MMC block
layer believe data_xfered bytes were transfered successfully, then
I see corruption with FIFO errors:

-00430bf0  71 28 10 81 5b 75 ea b7  4c 3c 35 de 8f 9a ee f9  |q(..[u..L<5.....|
+00430bf0  71 28 10 81 5b 75 ea b7  4c 3c 35 de c4 61 e5 69  |q(..[u..L<5..a.i|

Block #1072 -> Part. #302150 -> Phys Sect #2417263..241771 -> 2417268 in error
mmcblk0: error -5 transferring data, sector 2417269, nr 106, cmd response 0x900, card status 0xb00

-005b39f0  2b d5 e1 e1 f6 c6 6d a8  9e 9e a8 47 a6 cb 80 ea  |+.....m....G....|
+005b39f0  0e 05 01 cd e8 4d ca 84  ce 45 9f ae 8b 4d 91 84  |.....M...E...M..|

Block #1459 -> Part. #302537 -> Phys Sect #2420359..2420367 -> 2420363 in error
mmcblk0: error -5 transferring data, sector 2420364, nr 83, cmd response 0x900, card status 0xb00

-009ddbd0  bb 24 ea e7 97 cb c7 40  74 83 c0 da 07 7f ef aa  |.$..... at t.......|
-009ddbe0  04 22 ff 01 0f 81 72 e0  62 47 4d 3e 2b fa bf 2a  |."....r.bGM>+..*|
-009ddbf0  bf f4 97 29 d9 47 fd 1e  2a 03 7c ad 5e 42 5d ec  |...).G..*.|.^B].|
+009ddbd0  45 45 46 47 49 4b 4b 4c  4b 4b 4c 4d 4e 4f 4f 50  |EEFGIKKLKKLMNOOP|
+009ddbe0  54 57 5b 5e 61 64 6a 6e  74 77 7d 85 86 8c 92 97  |TW[^adjntw}.....| 
+009ddbf0  99 9e a2 a5 aa ad af b1  b1 b3 b4 b4 b3 b3 b2 b1  |................| 

Block #2525 -> Part. #303604 -> Phys Sect #2428895..2428903 -> 2428900 in error
mmcblk0: error -5 transferring data, sector 2428901, nr 2, cmd response 0x900, card status 0xb00

-00e4d5f0  49 f8 f8 bd 54 fa 8d 9c  d6 b7 0d 7a c1 d1 70 1f  |I...T......z..p.|
+00e4d5f0  49 f8 f8 bd 54 fa 8d 9c  73 75 70 6a 65 61 5d 4d  |I...T...supjea]M|

Block #3661 -> Part. #304741 -> Phys Sect #2437991..2437999 -> 2437993 in error
mmcblk0: error -5 transferring data, sector 2437994, nr 13, cmd response 0x900, card status 0xb00 

Notice how the sector number in the kernel reports are for the following
sector, and also notice that the corruption is within the last FIFO-worth
of data.

Most of the time it seems to blame the correct sector, but occasionally,
when the overflow happens towards the end of a block, it doesn't.

It looks to me like the data counter decrements according to bytes
transferred on the MMC bus.  When a FIFO overrun error occurs, we
immediately handle this, disable the data path, and that prevents the
remaining good FIFO data being read.  So, the corruption represented
above is because we haven't read the pending data from the FIFO.

In the vast majority of cases, it seems there's little point as it won't
get us up to a block boundary, so maybe the correct answer is on overruns
to subtract the FIFO size, but not for underruns.  So something like the
below.  I'll give it a spin tomorrow.

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fe7facc..ada362c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -293,7 +293,14 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		} else if (status & MCI_DATATIMEOUT) {
 			data->bytes_xfered = round_down(success, data->blksz);
 			data->error = -ETIMEDOUT;
-		} else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+		} else if (status & MCI_TXUNDERRUN) {
+			data->bytes_xfered = round_down(success, data->blksz);
+			data->error = -EIO;
+		} else if (status & MCI_RXOVERRUN) {
+			if (success > host->variant->fifosize)
+				success -= host->variant->fifosize;
+			else
+				success = 0;
 			data->bytes_xfered = round_down(success, data->blksz);
 			data->error = -EIO;
 		}
