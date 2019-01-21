Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0648EC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:22:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACCB21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mvtpBRwP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Rlp3dl07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACCB21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9/Mw2ZReOZLmnqyPB6Vqas0tY4XO1VhTCwdBOLX1Yxk=; b=mvtpBRwPynvjdI
	35+nWJvL/bAV8KEgbGHgauO5aCh8Wq8JdKIrbupNlXwwHYDfMa/HGlfQRUyRNbkbc6aSUVW7zNNBt
	H3gS1oep27d6rWDptoiEmWnTn4mGrGFLgG/URdysk+VqjYWsB4bkoeDy9HxIs8FVKm1vAW3moos4B
	W6R8yVNLDU0LI1/ouRJkrio86qWfFpvLQZO/8wOoDNVCAzDhSrjHKk8LNsM467Mvo3RRUQbAW/mfY
	Hl08RnaMZLYJ2bDu4WcfYyy3EWc6y+I3Mn6ce9eEftzMw1CycHyIP28hem8YyeqT2fwiPhdK6U8lA
	dKGZbYZvjSxGs/3vStNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glf9k-0006QR-HG; Mon, 21 Jan 2019 19:22:48 +0000
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glf9g-0006Q2-K9
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 19:22:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbKnFUTEA9RElEoXsVoJ/FcNsFfpk9fL1OWMEdP2a+0=;
 b=Rlp3dl07KX6XeCnzj/hIQOTL51XVqfarmILIAYfiYMgTiNhIxtsZduZ38B+tmAB1X+EP6p+GTWAquoJWYst08xq9zwoDZaGQZ1JkhldUlpcNqdzoAKi3vFs91RO6mNWepokfRF7KKWg23c1nyCS8ugjQ2JVrrifaLUTqGH69y4I=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3461.eurprd05.prod.outlook.com (10.170.223.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Mon, 21 Jan 2019 19:22:41 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 19:22:41 +0000
From: Liming Sun <lsun@mellanox.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Thread-Topic: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Thread-Index: AQHUcgMEWmkOtMRYOEe8dmJo8nndDKW1ql2AgASf0nA=
Date: Mon, 21 Jan 2019 19:22:41 +0000
Message-ID: <DB6PR05MB32233FF89600716711441C04A19F0@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com>
 <1541089538-175682-5-git-send-email-lsun@mellanox.com>
 <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
In-Reply-To: <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR05MB3461;
 6:DOhumki9ZAur9SKpHcy6sKep8NEs0klcqaouU+puA1mScNOrtWRQSxekF/BpVJfSQgVE5RJI2X5gesgXzVOGKErMZOineQlNHXieQwqNyEx2LtfJDIip2pRhJfNGT9gDkC45Dyahw03H5nLmZqIXQOakYz3S4r4SG9+m7qYgljk/cy/h94Gm9PrBbm6XrVCP45wVDYTubOsbSgTasDl+Jz9ljkYAUzCipdz6rZGjMyCeg10aapBdSamXrxuh9ygN0VM27ZsHXDeVAiEAE69T4vVBwpWn5hfL656sQGdWRMVXkomBWzgVhEt11laV3145w8Oi/P8pFu7LZ83Qhcg7SmWbtZqVmEPFj4x1rdFpdHwV03phxvtiyzGFWEvfN4vXg4/0XcqZdND+ZwtSot6NG+Rz7bTwTT/DHY/VJkVimOzultLMfQB2g/QRxT7w2yO7OjJU7f00UN4WzpMgQAJEjg==;
 5:Ck/GJNY8Mz14rOSPStz+CM9W7hgwY+S1pxLJKJJp8dX3nosrFaq5ksnjLQoiDqlpF4zuDiEC446+Txfg4yFQmQBle3k+GL5DPyVK/5Wy7OQVTYvgEJX5ayapSItezpWY+aLYObTaSkc0aOPycZdBOELcXN2Sw1XUZ3keEeuK0ptjGbDIcER5LvJeXcPxQdCp3gCMXNMm+MGEVC+YuW3vrg==;
 7:Zyb/lVWWdENfKZDjyJH/303RZWROtogrCtvwSVhKAPMcpEcenDjj2tO/iF0TElEadyX75gqPWz/Y8mgAgT+CqKUBp6kJ8Tf904SHfIr7XixpNlG5Bevgq2E5K3dZ+5xhwH10sWazQFLrb8JM/8X2WA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bf79ac90-ac69-4c3f-354e-08d67fd5d01c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR05MB3461; 
x-ms-traffictypediagnostic: DB6PR05MB3461:
x-microsoft-antispam-prvs: <DB6PR05MB34619B09B8E16F4920D931A0A19F0@DB6PR05MB3461.eurprd05.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(366004)(13464003)(189003)(199004)(7696005)(86362001)(55016002)(446003)(486006)(4326008)(74316002)(9686003)(6916009)(33656002)(229853002)(25786009)(476003)(6436002)(2906002)(11346002)(71200400001)(71190400001)(97736004)(6116002)(3846002)(316002)(99286004)(68736007)(53546011)(7736002)(54906003)(478600001)(305945005)(6506007)(76176011)(102836004)(14444005)(256004)(93886005)(186003)(81166006)(7416002)(53936002)(105586002)(66066001)(26005)(14454004)(6246003)(81156014)(106356001)(8676002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR05MB3461;
 H:DB6PR05MB3223.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MkvCh3CI4SAHbZqv66xacflpxHdu9R4+G4cMxj5375LQFX7Pv9aLUWape7xsQZp/WlFEYFFabvp/JI6Skg5zOlKb6zW77s+0Ev/1ybE3s0ETqz89EjTpyDDLvpwrz4K/Vn0dbNmrwP/w7UAfk5mo7RvR5c/2e8GEM9QYD+dWB51RyIP1Xe9qk8rzEOWTIgOF2mcPk5Ol6/raDRShCevTByRtFdzbN3T3ZpG+hZAdVBDASsTQ6wLLDIvb9ksJOOtgbUeUiQ9xHRU2kshQchUsk3a97wVQNFngG2z+9AHTl9bFvHu4LVclZsGXV2jVwoM+neKkz7Hzrg0zhOrRfiXdoHqtO64iz4swT+ZRXvT1AmKt8DZBFo3FYV+1Irbt3IgR93OHLoutXTBHLBgueWU0e0OzKCsqdSoBDlRAtV9JvO8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf79ac90-ac69-4c3f-354e-08d67fd5d01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 19:22:41.4837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3461
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_112244_714848_3592EF17 
X-CRM114-Status: GOOD (  38.96  )
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
Cc: DTML <devicetree@vger.kernel.org>, David Woods <dwoods@mellanox.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks Arnd for the comments. The 0/9 email was sent out just now to
add more details about the design and changes. Please also see my response
below.

- Liming

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Friday, January 18, 2019 11:02 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Olof Johansson <olof@lixom.net>; David Woods <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-soc
> <arm@kernel.org>; DTML <devicetree@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>; Vincent Whitchurch
> <vincent.whitchurch@axis.com>; linux-pci <linux-pci@vger.kernel.org>; linux-ntb@googlegroups.com; Christoph Hellwig <hch@lst.de>
> Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side Rshim driver
> 
> On Thu, Nov 1, 2018 at 5:49 PM Liming Sun <lsun@mellanox.com> wrote:
> >
> > An external host can connect to a Mellanox BlueField SoC via an
> > interface called Rshim. The Rshim driver provides boot, console,
> > and networking services over this interface. This commit is
> > the common driver where the other backend (transport) driver will
> > use.
> >
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> 
> Hi Liming,
> 
> I've taken a new look at your patch series for drivers/soc/ now,
> thanks for your continued submissions.
> 
> This is again just a set of very high-level comments, but I think we
> should resolve some of the fundamental questions first.
> Incidentally, Vincent Whitchurch has recently posted another
> patch series with a very similar intention, but for other hardware
> and taking a different approach.
> 
> In both cases, the idea is to use virtio based drivers to provide
> services from a host machine into another Linux instance running
> on an embedded system behind a PCIe slot or similar. Your
> Bluefield SoC patches are well written, but are intentionally
> kept specific to a particular use case and tied to one piece
> of hardware. In contrast, Vincent uses the existing code from
> drivers/misc/mic/vop/ that is equally hardware specific, but he
> extends it to be applicable to other hardware as well.
> 
> It would be good if you could look at each other's approaches
> to see where we could take it from here. I think ideally we
> should have a common driver framework for doing the same
> thing across both of your devices and as well as others.

Yes, I checked drivers/misc/mic/vop and Vincent Whitchurch's patches 
(Virtio-over-PCIe on non-MIC) and related comments. I kind of feel 
that besides the common virtio infrastructure, there seems not much
to be reused in the rest of implementation yet, though they are trying
to do the similar things.  (Feel free to correct me if I misunderstood it.)

I just submitted the patch 0/9 to explain some details of the rshim
component and the driver patches. Could you help take a look?

The rshim driver of BlueField SoC has a few more functionalities 
which are very HW-specific. Some needs driver support from both 
ARM target and the external host, some only needs external host 
driver support.

As for common framework, we used to implement the drivers based on
the remote proc (Documentation/remoteproc.txt), which seems more
close to what we wanted (in my humble opinion). Later due to more 
functionalities to add and the lack of remote proc in old kernels, we 
changed to use virtio framework directly, which seems very helpful and
saved quite some driver work.

> 
> That would also resolve my main concern about the drivers,
> which is the placement in drivers/soc/ for a set of drivers
> that are unlike most drivers in that directory not mean for
> running on the SoC itself in order drive unusual functionality
> on the SoC, but are (at least partially) meant for running on
> a host machine to communicate with that SoC over PCIe
> or USB.
> 
> As an example, your network driver should really be placed
> in drivers/net/, though it is unclear to me how it relates
> to the existing virtio_net driver. In the case of mic/vop,
> the idea is to use virtio_net on the device side, but have
> vhost_net or a user space implementation on the host side,
> but that is apparently not what you do here. Can you
> explain why?

Yes, I actually have the same concerns where the host side
drivers should go.  For now ther're just added for code review
purpose. drivers/soc/ seems not a good place. One thought
is to move the rshim_net, rshim_pcie and rshim_pcie_lf backend
driver to drivers/net/ethernet/Mellanox/rshim/ and move the
rshim common driver to drivers/char as it creates the character
devices?

The device side of this patch uses the virtio_net driver as well. 

The host side is not just for networking, which was mentioned 
in the 0/9 patch. The host side driver manages the whole rshim
component and is called the 'rshim' driver. It includes driver
to access the TmFifo, where virtio_net is used to provide 
networking support. It needs to talk to the common
driver then the USB or PCIe backend driver.  It seems to me that
vhost_net doesn't quite fit this model and might make it 
over-complicated.

> 
> Another high-level question I have is on how your various
> drivers relate to one another. This should normally be
> explained in the 0/9 email, but I don't seem to have received
> such a mail. I see that you have multiple back-end drivers
> for the underlying transport, with one of them based on USB.
> Have you come up with a way to use the same high-level
> driver such as the network link over this USB back-end,
> or is this for something else?

Yes, 0/9 has been sent. Sorry I should have provided since beginning.

The USB (or PCIe) provide the general transport to access the RShim
component, for networking, console, register access, boot service,
etc. So it's not just for network link. The implementation seems very
HW specific, such as providing APIs like rshim_usb_read_rshim()
and rshim_usb_write_rshim(). In PCIe backend it has similar APIs
like rshim_pcie_read(), rshim_pcie_write().

Not very clear about what you meant the " the same high-level driver 
such as the network link over this USB back-end". Do you mean using
any existing network over USB framework or provide some mechanism
to be reused by other network over USB driver?

By the way, the 0/9 has been sent. Could you help take a look whether 
it clarifies a little bit or not?

> 
>       Arnd
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
