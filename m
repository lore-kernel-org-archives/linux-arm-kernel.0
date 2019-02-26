Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E316C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:16:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE49217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eDz9Ng0/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="pDMJq9rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE49217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Qe/D9zApw+pFCylbL7JS/Dc52vW2lhjdMqCIbuBNMI=; b=eDz9Ng0/FwLWeF
	SV6WwdMi2V+8UtIRDXtcwsvDB5hXD2JnDD1o7ZFU9ZSvJBoYuaUpV4euaZn2l3VeK2ThZa9gb87IS
	d21AvGT2TI6GlBnwkMPzQ8VBrzUosAwT44qKopPU1DX1cbED1ZHCUPklKmu1Gkgda/igxPRm8dJ4T
	UVz+/UlVA2iNTTHIewP+OYb4Wr3LIuGAz/zRuMByxnwxUbNLKcg9jqqtPJKA/jnQiTEckhU9U8rpE
	/Yt2OADmaeqnD+WQX8nSATJgMbpaV6ONxNdTFtm7jt8wsPiHa+eXjzkVvUNy4vpEZbP4l8r/C+8KS
	hNpqYuYUNoRUqVM3jULA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyhHH-0006Qp-1X; Tue, 26 Feb 2019 18:16:27 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyhHC-0006NZ-Gd
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:16:24 +0000
Received: by mail-lj1-x244.google.com with SMTP id d24so11359725ljc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/UJL3WHB7z/fbFjJ/n643NRlax/UYjmj1twPDxFm7IQ=;
 b=pDMJq9rlTJGNzJbUrAgRadZd1i9JfPUKBkgy/CYT8Btt3EQ4WI3saJGwAnHiA45HB2
 s6QFE9eibnWg3fU07tHAsyDiCbOD3lbu/oZKs0n0QtOFkFcSl2XVlRE8FcG4pZOcb5dU
 edRGBCtUPsGjcW1GiPVP4hfP5+NPdyEubTtOWGxZBnKZOi1Cq18SmN0I1hlokc1Uj1yZ
 6rYRFO7iGaM+Om4otWP/NEW9YB5ovCfY/Y5364Rg+86HvDaA5TYm5XKm4HqaPb/GQpc4
 KujgTF+RhK55SUTgrGvNzdI9T0giWXbM+l89YPxal7/BrJAMfyJy0JWyqZOU6Dd3UWiq
 +ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/UJL3WHB7z/fbFjJ/n643NRlax/UYjmj1twPDxFm7IQ=;
 b=jhZmKzT+p14YFs6hBdz2JwLffShnwdW6gtzVvcS4yU9E5ljBFcPTIwx4Gh6L4W2hDI
 E5d51laVzrOYM/YoIXY9CKQqG66/pZ880mn98FBGbKTz28jtgzg+A1C2qO80ysZDUEfw
 ggekEMePdH4yvfDL8VwrUXbMr5NvudoLIOvDP1K0qVHh7RDvVPDvMO1CvIkFLbpMUfaJ
 n9FEXwpJuknyaMYUQ60rsyJsjSGs8cMwgo0181Pi1FiNCeUONv3ZtFW0mAehF6bXJymV
 fc884hDOoP4TnCviKJEViXooCFCajBOO4iECFxN5cpb3bi9OZnRSRlxNtxtLbJjHlQzr
 kw5Q==
X-Gm-Message-State: AHQUAuau0k1IA+RlaAsjMLBlgcqMT6s2KCVJtmunyvqDIh21GyuWd2BV
 Qb/0jiqAUv60eV6D1V0VFUNaBye+El8=
X-Google-Smtp-Source: AHgI3IY9uK5LiCjh9SHSXWq3ui2dEtdmkQ3jUddEDAi8J11Tjlz3dgx8MinroYkkUkeTQCzSZcqZ7A==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr14481627ljj.30.1551204979431; 
 Tue, 26 Feb 2019 10:16:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.110])
 by smtp.gmail.com with ESMTPSA id v1sm1025511lfg.13.2019.02.26.10.16.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 10:16:18 -0800 (PST)
Subject: Re: [RFC PATCH 3/5] mtd: Add support for Hyperbus memory devices
To: "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)"
 <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Marek Vasut
 <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Rob Herring <robh+dt@kernel.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-4-vigneshr@ti.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <7e79fff7-2565-28f7-7b2b-bb3098f1a928@cogentembedded.com>
Date: Tue, 26 Feb 2019 21:16:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-4-vigneshr@ti.com>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_101622_705703_B617BF95 
X-CRM114-Status: GOOD (  30.73  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 tudor.ambarus@microchip.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> Cypress HyperBus is Low Signal Count, High Performance Double Data Rate Bus
> interface between a host system master and one or more slave interfaces.
> HyperBus is used to connect microprocessor, microcontroller, or ASIC
> devices with random access NOR flash memory(called HyperFlash) or
> self refresh DRAM(called HyperRAM).
> 
> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> signal and either Single-ended clock(3.0V parts) or Differential clock
> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> At bus level, it follows a separate protocol described in HyperBus
> specification[1].
> 
> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
> its equivalent to x16 parallel NOR flash wrt bits per clk. But Hyperbus
> operates at >166MHz frequencies.
> HyperRAM provides direct random read/write access to flash memory
> array.
> 
> But, Hyperbus memory controllers seem to abstract implementation details
> and expose a simple MMIO interface to access connected flash.
> 
> Add support for registering HyperFlash devices with MTD framework. MTD
> maps framework along with CFI chip support framework are used to support
> communicate with flash.
> 
> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller(HBMC) drivers call hb_register_device() to register a
> single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
> 
> Some HBMC masters need calibration/training sequence[3] to be carried
> out, in order for DLL inside the controller to lock, by reading a known
> string/pattern. This is done by repeatedly reading CFI Query
> Identification String. Calibration needs to be done before try to detect
> flash as part of CFI flash probe.
> 
> HyperRAM is not supported atm.
> 
> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
> 
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
[...]
> diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
> new file mode 100644
> index 000000000000..0aa11458c424
> --- /dev/null
> +++ b/include/linux/mtd/hyperbus.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#ifndef __LINUX_MTD_HYPERBUS_H__
> +#define __LINUX_MTD_HYPERBUS_H__
> +
> +#include <linux/mtd/map.h>
> +
> +enum hb_memtype {
> +	HYPERFLASH,
> +	HYPERRAM,
> +};
> +
> +/**
> + * struct hb_device - struct representing Hyperbus slave device
> + * @map: map_info struct for accessing MMIO Hyperbus flash memory
> + * @dev: device pointer of Hyperbus Controller

   I think we need a separate structure for the HyperBus controller, not just
for the slave devices...

> + * @np:	pointer to Hyperbus slave device node
> + * @mtd: pointer to MTD struct
> + * @ops: pointer to custom Hyperbus ops
> + * @memtype: type of memory device: Hyperflash or HyperRAM
> + * @needs_calib: flag to indicate whether calibration sequence is needed
> + * @registered: flag to indicate whether device is registered with MTD core
> + */
> +
> +struct hb_device {
> +	struct map_info map;
> +	struct device *dev;
> +	struct device_node *np;
> +	struct mtd_info *mtd;
> +	struct hb_ops *ops;
> +	enum hb_memtype memtype;
> +	bool needs_calib;
> +	bool registered;
> +};
> +
> +/**
> + * struct hb_ops - struct representing custom Hyperbus operations
> + * @read16: read 16 bit of data, usually from register/ID-CFI space
> + * @write16: write 16 bit of data, usually to register/ID-CFI space
> + * copy_from: copy data from flash memory
> + * copy_to: copy data to flash_memory
> + */
> +
> +struct hb_ops {
> +	u16 (*read16)(struct hb_device *hbdev, unsigned long addr);
> +	void (*write16)(struct hb_device *hbdev, unsigned long addr, u16 val);
> +
> +	void (*copy_from)(struct hb_device *hbdev, void *to,
> +			  unsigned long from, ssize_t len);
> +	void (*copy_to)(struct hb_device *dev, unsigned long to,
> +			const void *from, ssize_t len);

   ... else these methods won't fly if you need to "massage" the controller
registers inside them...

> +};
[...]

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
