From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 16 Aug 2016 14:44:44 +0200
Subject: [V2, 10/15] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 MAN_TUNING
In-Reply-To: <20160816101818.GD9211@shlinux2>
References: <1468309584-3591-11-git-send-email-aisheng.dong@nxp.com>
 <20160815145941.GA23663@t450s.lan> <20160816101818.GD9211@shlinux2>
Message-ID: <20160816124444.GA31259@t450s.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 06:18:18PM +0800, Dong Aisheng wrote:
> On Mon, Aug 15, 2016 at 04:59:41PM +0200, Gary Bisson wrote:
> > Dong Aisheng, All,
> > 
> > On Tue, Jul 12, 2016 at 03:46:19PM +0800, Dong Aisheng wrote:
> > > Indicating hw auto retuning support for mx6qdl in the fake caps_1
> > > register and enable auto retuning in post_tuning process after
> > > tuning completes.
> > 
> > Have you tried this change with a SDIO3.0 device? I'm asking because a
> 
> Tested with SD3.0 device.
> Not really for SDIO3.0 device since there's no SDIO3.0 device on my
> available MX6Q/DL boards.

Someone answered on the Community that it has been tested on i.MX7 SABRE
board but not on i.MX6 right?

> > similar change in latest NXP 4.1.15 kernel broke SDIO3.0 support.
> > With this tuning, the kernel would report:
> > mmc2: Got data interrupt 0x00000002 even though no data operation was in
> > progress.
> > 
> 
> Can you provide the full enumeration log?

Here is the mmc related part of dmesg:
# dmesg | grep mmc2
mmc2: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
mmc2: queuing unknown CIS tuple 0x01 (3 bytes)
mmc2: queuing unknown CIS tuple 0x1a (5 bytes)
mmc2: queuing unknown CIS tuple 0x1b (8 bytes)
mmc2: queuing unknown CIS tuple 0x14 (0 bytes)
mmc2: queuing unknown CIS tuple 0x80 (1 bytes)
mmc2: queuing unknown CIS tuple 0x81 (1 bytes)
mmc2: queuing unknown CIS tuple 0x82 (1 bytes)
mmc2: new ultra high speed SDR104 SDIO card at address 0001
mmc2: queuing unknown CIS tuple 0x01 (3 bytes)
mmc2: queuing unknown CIS tuple 0x1a (5 bytes)
mmc2: queuing unknown CIS tuple 0x1b (8 bytes)
mmc2: queuing unknown CIS tuple 0x14 (0 bytes)
ar6k_wlan mmc2:0001:1: Direct firmware load for qsetup30.bin failed with
error -2
mmc2: Got data interrupt 0x00000002 even though no data operation was in
progress.
mmc2: Got data interrupt 0x00000002 even though no data operation was in
progress.

Without the MAN_TUN patch, everything is the same (as expected) but
without the last two errors. Note that when WiFi connection is up, this
warning keeps poping up every few seconds.

> > Doing a 'git bisect' and then reverting this patch fixed the issue.
> > Although I haven't tested that change on mainline kernel, I wanted you
> > to know about this observation before it gets merged.
> > 
> > As a FYI, the issue has been reported to NXP community:
> > https://community.nxp.com/thread/431316
> > 
> 
> Thanks for nofity.
> I will check it on my side.

Not sure you've seen my last post from today, but you can actually try
the device I'm using (QCA9377) on SABRE using the evaluation kit:
http://www.silexamerica.com/products/connectivity-solutions/embedded-wireless/sdio-radios/sx-sdcac/

Maybe there's a hw mod to do on SABRE in order to get SDIO3.0/1.8V vcc.

Regards,
Gary
