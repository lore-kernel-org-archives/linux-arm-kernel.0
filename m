From: zonque@gmail.com (Daniel Mack)
Date: Mon, 11 Jul 2011 16:49:12 +0200
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <4E1411BB.4010000@compulab.co.il>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
	<1309771536-10597-4-git-send-email-leiwen@marvell.com>
	<4E1411BB.4010000@compulab.co.il>
Message-ID: <CACTFLAOmRMDH_6qo_WkndoWX-HPw9RTqbtsURDfw22sWEFS2wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 9:41 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Daniel,
>
> have you tested the suspend/resume with this patch?
> (and keep_config on?)

We did now test this with keep_config=1 and it seems that we indeed
have a problem with suspend/resume after this patch. Affected machines
show the following after wake up:


[ 1295.458958] PM: resume of devices complete after 296.228 msecs
[ 1295.717773] Restarting tasks ...
[ 1295.729639] UBI error: ubi_io_write: error -5 while writing 2048
bytes to PEB 19:59392, written 0 bytes
[ 1295.761672] done.
[ 1295.772706] UBI warning: ubi_eba_write_leb: failed to write data to PEB 19
[ 1295.782492] UBI: recover PEB 19, move data to PEB 405
[ 1295.849084] mmc0: new SDIO card at address 0001
[ 1295.978045] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1295.983153] UBI warning: ubi_io_read_vid_hdr: no VID header found
at PEB 19, only 0xFF bytes
[ 1296.015382] UBI: run torture test for PEB 405
[ 1296.024375] UBI warning: ubi_ro_mode: switch to read-only mode
[ 1296.032321] UBI error: do_sync_erase: read-only mode
[ 1296.037296] UBI error: erase_worker: failed to erase PEB 405, error -30
[ 1296.058363] UBIFS error (pid 1303): ubifs_wbuf_write_nolock: cannot
write 424 bytes to LEB 317:55296, error -5
[ 1296.080917] UBIFS error (pid 1092): ubifs_wbuf_write_nolock: cannot
write 416 bytes to LEB 317:55296, error -30
[ 1296.094470] UBIFS warning (pid 1303): ubifs_ro_mode: switched to
read-only mode, error -5
[ 1296.106183] UBIFS error (pid 1092): ubifs_create: cannot create
regular file, error -30
[ 1296.118007] UBI error: do_work: work failed with error code -30
[ 1296.123915] UBI error: ubi_thread: ubi_bgt0d: work failed with error code -30
[ 1296.742934] libertas_sdio mmc0:0001:1: (unregistered net_device):
00:19:88:11:db:67, fw 9.70.7p0, cap 0x00000303
[ 1296.779845] libertas_sdio mmc0:0001:1: wlan0: Marvell WLAN 802.11 adapter
[ 1296.847141] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[ 1298.041988] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[ 1300.957951] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1301.157810] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1301.357874] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1301.557924] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1301.563064] UBIFS error (pid 1260): ubifs_read_node: bad node type
(255 but expected 1)
[ 1301.573526] UBIFS error (pid 1260): ubifs_read_node: bad node at
LEB 112:18808, LEB mapping status 1
[ 1301.583586] UBIFS error (pid 1260): do_readpage: cannot read page 3
of inode 10295, error -22
[ 1301.787877] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1301.987891] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1302.187878] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1302.387878] pxa3xx-nand pxa3xx-nand: Wait time out!!!
[ 1302.393866] UBIFS error (pid 1260): ubifs_read_node: bad node type
(255 but expected 1)
[ 1302.403452] UBIFS error (pid 1260): ubifs_read_node: bad node at
LEB 112:18808, LEB mapping status 1
[ 1302.413507] UBIFS error (pid 1260): do_readpage: cannot read page 3
of inode 10295, error -22


The UBIFS is very likely toast after this.

Lei, any ideas, can you reproduce this? To avoid further regressions
of this driver, you really should have a system on which you can test
suspend and resume after each commit.


Thanks,
Daniel
