From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 10 Dec 2014 11:26:00 +0100
Subject: [PATCH 1/2] usb: chipidea: usbmisc: skip clocks on i.MX6
In-Reply-To: <20141210050928.GB11802@shlinux2>
References: <1418141616-29671-1-git-send-email-p.zabel@pengutronix.de>
 <20141210050928.GB11802@shlinux2>
Message-ID: <1418207160.3258.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am Mittwoch, den 10.12.2014, 13:09 +0800 schrieb Peter Chen:
> On Tue, Dec 09, 2014 at 05:13:35PM +0100, Philipp Zabel wrote:
> > On i.MX6Q, the USBMISC registers are clocked by the IPG clock,
> > so there is no need to enable USBOH3 for the USBMISC driver.
> 
> Access the registers at usbmisc needs the same clock with chipidea core,
> both are usboh3.

Alright, I'll drop this patch.

It was my understanding that the usbmisc register space is clocked by
ipg_clk_s, which is not gated by usboh3_clk_enable:
Having a look at the "i.MX 6Dual/6Quad Applications Processor Reference
Manual, Rev. 1, 04/2013", Figure 65-1 "USB block diagram" shows the USB
Control Register (usbmisc) directly connected via "IP Bus1" separately
from the host cores (these are connected behind a PL301).
In chapter 18.4 "System Clocks", the table entry for the block instance
"USB" shows that the usboh3_clk_enable bit gates only the ipg_ahb_clk,
ipg_clk_s_pl301, test_clk_240m, test_clk_480m, and test_clk_60m inputs
to the USB block. The ipg_clk_s (from ipg_clk_root) and ipg_clk_32khz
inputs are not marked as gated. Still, it seems that indeed the usbmisc
region is inaccessible after gating usboh3 by unbinding the usb drivers.

regards
Philipp
