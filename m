Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41C2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:54:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0716218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SqvL6nWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0716218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=true.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2eb/SdPOGzWR4+vSH5ZWAs3hV5T21t5Y6YOQd4Y5DbI=; b=SqvL6nWOHXOAq/
	I8BOrALQcYRfCQbLoUztyNV9GSqeyQgClBgYRDRCObs38covIGK5deFpOqCQBT3xVjr5DOPgQrE6s
	A9eqTgv/+yfc46SnwXy/s+8iIUtTI5lGP6ha2RHtXT0wcbVp7e5nAJHkabsj7PMnSF9q195d+1NGN
	kBRw1+XBK/QozIsbsGcQ7JP4KOF1L9FThqkilXkuuRGTs4W9hvMR9tnMOCNTtCLF4H1RuqMt020uv
	0hBpQkvHDLNo/gIf41+jsae+a3qiIIWYTvDOwKOC2lVFTuMp0uBDVTzm38AdbaFXR8pgg8+daQ7N8
	rMl55APC4zbDOHQMw4yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKqJ-0008M1-HK; Wed, 06 Feb 2019 10:54:11 +0000
Received: from smtp-out.xnet.cz ([178.217.244.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKqD-0008KP-P0
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:54:09 +0000
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
 (Authenticated sender: petr@true.cz)
 by smtp-out.xnet.cz (Postfix) with ESMTPSA id AA2443B64;
 Wed,  6 Feb 2019 11:53:59 +0100 (CET)
Received: from localhost (meh.true.cz [local])
 by meh.true.cz (OpenSMTPD) with ESMTPA id 5b001470;
 Wed, 6 Feb 2019 09:13:10 +0100 (CET)
Date: Wed, 6 Feb 2019 09:13:10 +0100
From: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To: dmaengine@vger.kernel.org
Subject: imx-uart DMA transaction error leading to OOPS on 4.14.95
Message-ID: <20190206081310.GP26426@meh.true.cz>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_025405_966221_84367977 
X-CRM114-Status: UNSURE (   9.56  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I've just encountered following OOPS on 4.14.95:

  imx-uart 21f0000.serial: DMA transaction error.
  Unable to handle kernel paging request at virtual address a0ee501a
  pgd = 9d7d4000
  [a0ee501a] *pgd=2d8d1811, *pte=00000000, *ppte=00000000
  Internal error: Oops: 7 [#1] SMP ARM
  Modules linked in: ath9k ath9k_htc ath9k_common qcserial ath9k_hw ath usb_wwan ti_usb_3410_5052 qmi_wwan pl2303 mac80211 keyspan iptable_nat iptable_mangle iptable_filter ipt_REJECT ipt_MASQUERADE ip_tables ftdi_sio cypress_m8 cp210x ch341 cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD x_tables usbserial usbnet usblp spidev nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv4 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat_ftp nf_nat nf_log_ipv4 nf_log_common nf_flow_table_hw nf_flow_table nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack_ftp nf_conntrack lm75 lib80211_crypt_wep lib80211_crypt_tkip lib80211_crypt_ccmp lib80211 ezusb crc_itu_t crc_ccitt compat cdc_wdm cdc_acm evdev usb_f_acm u_serial
  libcomposite ledtrig_oneshot ledtrig_heartbeat pinctrl_mcp23s08 tun vfat fat configfs nls_utf8 nls_iso8859_2 nls_iso8859_1 nls_cp852 nls_cp850 nls_cp1250 eeprom_93cx6 gpio_keys usb_storage input_core leds_gpio sd_mod mii
  CPU: 0 PID: 2536 Comm: sh Not tainted 4.14.95 #0
  Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
  task: 9f67ca00 task.stack: 9b642000
  PC is at sdma_int_handler+0x7c/0x17c
  LR is at console_unlock+0x480/0x4ec
  pc : [<803e2690>]    lr : [<80158054>]    psr: 60000193
  sp : 9b643e70  ip : 00000003  fp : 9b643eac
  r10: 00000001  r9 : 9f56e010  r8 : 0000000c
  r7 : 00000000  r6 : 9f56e2ec  r5 : 00000003  r4 : 9f56e2e0
  r3 : a0ee5018  r2 : 00000018  r1 : 1f35f000  r0 : a0ee5000
  Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
  Control: 10c5387d  Table: 2d7d404a  DAC: 00000051
  Process sh (pid: 2536, stack limit = 0x9b642210)
  Stack: (0x9b643e70 to 0x9b644000)
  3e60:                                     00080040 00000008 00000000 00000000
  3e80: 9b643eac 9f6bfe80 9f61e200 00000000 9b643efc 0000003d 9f61e200 8090babc
  3ea0: 9b643ef4 9b643eb0 8015a4f0 803e2620 00008124 9b643f00 00000000 80746dc4
  3ec0: 80746db0 80746d88 00000000 9f61e200 9f61e200 00000000 00000001 9f408000
  3ee0: f4001100 00000000 9b643f14 9b643ef8 8015a5e0 8015a498 00000000 00000000
  3f00: 9f61e200 9f61e264 9b643f34 9b643f18 8015a668 8015a5c8 9f61e200 80907fc0
  3f20: 00000000 00000001 9b643f4c 9b643f38 8015df40 8015a628 8085bad4 00000000
  3f40: 9b643f5c 9b643f50 80159774 8015de6c 9b643f84 9b643f60 80159d3c 80159754
  3f60: 80903e28 80912da8 f400010c f4000100 9b643fb0 f4001100 9b643fac 9b643f88
  3f80: 80101454 80159ca8 00054574 40000010 ffffffff 10c5387d 10c5387d 00087bb0
  3fa0: 00000000 9b643fb0 8010c654 801013fc 0085eba4 0000000a 00000000 00000000
  3fc0: 0000000a 0085eba4 76f9b200 00000000 00087c44 00087bb0 00000000 0085f398
  3fe0: 0085f384 7ece9608 00054b28 00054574 40000010 ffffffff 00000000 00000000
  Backtrace:
  [<803e2614>] (sdma_int_handler) from [<8015a4f0>] (__handle_irq_event_percpu+0x64/0x130)
  r10:8090babc r9:9f61e200 r8:0000003d r7:9b643efc r6:00000000 r5:9f61e200
  r4:9f6bfe80
  [<8015a48c>] (__handle_irq_event_percpu) from [<8015a5e0>] (handle_irq_event_percpu+0x24/0x60)
  r10:00000000 r9:f4001100 r8:9f408000 r7:00000001 r6:00000000 r5:9f61e200
  r4:9f61e200
  [<8015a5bc>] (handle_irq_event_percpu) from [<8015a668>] (handle_irq_event+0x4c/0x70)
  r5:9f61e264 r4:9f61e200
  [<8015a61c>] (handle_irq_event) from [<8015df40>] (handle_fasteoi_irq+0xe0/0x17c)
  r7:00000001 r6:00000000 r5:80907fc0 r4:9f61e200
  [<8015de60>] (handle_fasteoi_irq) from [<80159774>] (generic_handle_irq+0x2c/0x3c)
  r5:00000000 r4:8085bad4
  [<80159748>] (generic_handle_irq) from [<80159d3c>] (__handle_domain_irq+0xa0/0xb4)
  [<80159c9c>] (__handle_domain_irq) from [<80101454>] (gic_handle_irq+0x64/0x98)
  r9:f4001100 r8:9b643fb0 r7:f4000100 r6:f400010c r5:80912da8 r4:80903e28
  [<801013f0>] (gic_handle_irq) from [<8010c654>] (__irq_usr+0x54/0x80)
  Exception stack(0x9b643fb0 to 0x9b643ff8)
  3fa0:                                     0085eba4 0000000a 00000000 00000000
  3fc0: 0000000a 0085eba4 76f9b200 00000000 00087c44 00087bb0 00000000 0085f398
  3fe0: 0085f384 7ece9608 00054b28 00054574 40000010 ffffffff
  r9:00087bb0 r8:10c5387d r7:10c5387d r6:ffffffff r5:40000010 r4:00054574
  Code: e3a0c003 e5940038 e0020298 e0803002 (e5d31002)
  ---[ end trace 3895211c674c9887 ]---
  Kernel panic - not syncing: Fatal exception in interrupt
  CPU1: stopping
  CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.14.95 #0
  Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
  Backtrace:
  [<8010b3e8>] (dump_backtrace) from [<8010b6c0>] (show_stack+0x18/0x1c)
  r7:00000001 r6:60000193 r5:00000000 r4:80930c5c
  [<8010b6a8>] (show_stack) from [<8064e290>] (dump_stack+0x90/0xa4)
  [<8064e200>] (dump_stack) from [<8010e528>] (handle_IPI+0xec/0x194)
  r7:00000001 r6:00000000 r5:9f475f38 r4:80931738
  [<8010e43c>] (handle_IPI) from [<80101484>] (gic_handle_irq+0x94/0x98)
  r7:f4000100 r6:f400010c r5:80912da8 r4:80903e28
  [<801013f0>] (gic_handle_irq) from [<8010c28c>] (__irq_svc+0x6c/0x90)
  Exception stack(0x9f475f38 to 0x9f475f80)
  5f20:                                                       00000000 00eadc48
  5f40: 1f36e000 80114780 ffffe000 80903c30 80903be4 8090b6ba 807461e4 412fc09a
  5f60: 00000000 9f475f94 9f475f98 9f475f88 80108668 8010866c 60000013 ffffffff
  r9:9f474000 r8:807461e4 r7:9f475f6c r6:ffffffff r5:60000013 r4:8010866c
  [<80108630>] (arch_cpu_idle) from [<80667750>] (default_idle_call+0x30/0x34)
  [<80667720>] (default_idle_call) from [<8014f5e4>] (do_idle+0xc0/0x124)
  [<8014f524>] (do_idle) from [<8014f8b0>] (cpu_startup_entry+0x20/0x24)
  r9:412fc09a r8:1000406a r7:80931748 r6:10c0387d r5:00000001 r4:00000084
  [<8014f890>] (cpu_startup_entry) from [<8010e1b8>] (secondary_start_kernel+0x154/0x160)
  [<8010e064>] (secondary_start_kernel) from [<1010178c>] (0x1010178c)
  r5:00000051 r4:2f46806a
  Rebooting in 3 seconds..

It has happened during the system shutdown phase (after OpenWrt system
upgrade), and I've tried to trigger it for few more times with the same steps,
but I wasn't able to reproduce it anymore.

Please keep me in the Cc loop as I'm not subscribed to the mailing lists.

Thanks.

-- ynezz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
