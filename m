From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Mar 2013 08:33:06 +0100
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <CAAfodu3cfphzUPPgH7OiicnD-_YinuZZOPPStKxmOcf4uWWgpw@mail.gmail.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303211730.23247.arnd@arndb.de>
 <20130321184641.GB13280@titan.lakedaemon.net>
 <CAAfodu3cfphzUPPgH7OiicnD-_YinuZZOPPStKxmOcf4uWWgpw@mail.gmail.com>
Message-ID: <20130328083306.3c2a23de@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Neil Greatorex,

On Thu, 28 Mar 2013 01:32:11 +0000, Neil Greatorex wrote:

> This set of patches seems to break the mvsdio driver (and hence
> mwifiex_sdio) on the Globalscale Mirabox. I believe this is because
> mvsdio.c contains a function mv_conf_mbus_windows that seems to
> conflict with the new mbus driver. I don't understand enough about the
> hardware (without the datasheets anyway) to be able to understand the
> exact problem, but I hope that this is enough to point you (or someone
> else) to it!

Thanks for reporting this problem. As Ryan Press said in reply to your
e-mail, it is well known that the mvsdio driver doesn't handle DMA
properly with SDIO devices that are not SD cards, and this, regardless
of whether the mvebu-mbus driver patches are applied or not.

Therefore, are you sure that this problem is really introduced by the
mvebu-mbus driver, and doesn't exist without applying the patches?

The mv_conf_mbus_windows() function of the mvsdio driver doesn't
conflict with the mvebu-mbus driver. What the mvsdio driver does is
request the list of DRAM chip-selects using mv_mbus_dram_info(), and
configure the SDIO unit with those informations in
mv_conf_mbus_windows(). But yes, the list of DRAM chip-selects is
provided by mv_mbus_dram_info() and this function has changed by the
introduction of the mvebu-mbus driver.

I'm on the move right now, so I don't have hardware around to test
this. Would it be possible for you to test the Mirabox with the
following patch applied on mvsdio, and do a run with and without the
patch series that introduces mvebu-mbus? The idea is that the
informations listed should be identical. If not, then indeed there is
potentially a problem with the mvebu-mbus driver.

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 145cdaf..65648ee 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -674,6 +674,8 @@ mv_conf_mbus_windows(struct mvsd_host *host,
 
        for (i = 0; i < dram->num_cs; i++) {
                const struct mbus_dram_window *cs = dram->cs + i;
+               pr_info("mvsdio: CS[%d], base = 0x%x, size = 0x%x, mbus_attr = 0x%x\n",
+                       i, cs->base, cs->size, cs->mbus_attr);
                writel(((cs->size - 1) & 0xffff0000) |
                       (cs->mbus_attr << 8) |
                       (dram->mbus_dram_target_id << 4) | 1,

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
