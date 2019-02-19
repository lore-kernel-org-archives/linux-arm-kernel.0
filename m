Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E7AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:27:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574E5217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iKRHKNcK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="i2Lr6wPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574E5217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eVtysnL1fYJvz1p5nJs1vjn07hRDBGJ79Ob6Cbl7ViE=; b=iKRHKNcKW1NSHj
	Zg8zlgrtSqpYbF352dqlu04/t6z/Onrm/MCoKhqRDdDIO1eVx3PzR7dgthM6A7VGE087ZQVxU4mpS
	S0W9CxrwJu3hL2eqwAhoQngUtOYM7ewf98kxVHGKCBsPS1W4QX8cmNvxaWUi/UnIqWfUQq7eGO/3B
	/QmdECqaxIsGeqi1p844TjG9QhGSHgKyQ8Udh9R4GEpP/fWCJMEn+6Q6+2uV/82VhClY1/0aOkJVA
	cUUgMkDzvKD7Ib3y4KbVqN00wmV0y3+ZlY9q9pTOMdcVY6u9abgvGpiQ8MvVXZjFMupzDEhhiYeV3
	3ie6kmg3muCvFHixrs/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvuBO-0002k5-Ue; Tue, 19 Feb 2019 01:26:50 +0000
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvuBL-0002jl-IW
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 01:26:49 +0000
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x1J1QYD9004986
 for <linux-arm-kernel@lists.infradead.org>; Tue, 19 Feb 2019 10:26:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x1J1QYD9004986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550539595;
 bh=Syvc8CYUnyJsga+YWR2VemKzeLLMgqDIsdamLYpWt6Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=i2Lr6wPRQ8hi+A49Jo7CgGnfNEUofXKy/F430HjcnO/PKC+waSYXzrL/VLzFgZfc5
 AVBAlH2sZUiKBq/ToftG/4boCMCPrz9wrnxF5/kCYP2FyG1lyrcoBV/WhoGQKnBpTa
 Jcq7qIbgmh0Lb0tZPib1f4HZ7Ay1CndCGyHgh2nFOSBUGhZl42wEoxyk7gMkT9yXL1
 RD7w6OQuCOpRBUJwMaw8DVD+MJmCz0Yjioc1eL0nZCua3CqJKGvfTTVtP+4d+ZI/Wf
 6jiWZUfYhWpDBeTMfZhjoGzpOXeAfNMJfxpahNPaDNpLK0VtRdYRCz7CzwI5lMJOSq
 IZFsf4K0bKY7Q==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id j8so6420249uae.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 17:26:34 -0800 (PST)
X-Gm-Message-State: AHQUAuaHHOX+6EbOg2QRoVSHHiHz8Q57Cvn9LeUP68s7yv417KakPyqz
 SwrVIBOQIRCFooMVaJ+CUtiJpbktQJe6c3oIFJ0=
X-Google-Smtp-Source: AHgI3IZas5ygeL45f0Nha89sjRomBSU9T2uUd8P0L/EZiHQFjvc53s26SFm8p//v0TaUto4qUriOFaV6W60kzhImkk0=
X-Received: by 2002:ab0:c07:: with SMTP id a7mr2581963uak.55.1550539593750;
 Mon, 18 Feb 2019 17:26:33 -0800 (PST)
MIME-Version: 1.0
References: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 19 Feb 2019 10:25:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTX4_phfcXRXUKGp_V0k_q_RKjL6A3Kz=Hxyqj6VXW+Q@mail.gmail.com>
Message-ID: <CAK7LNARTX4_phfcXRXUKGp_V0k_q_RKjL6A3Kz=Hxyqj6VXW+Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_172647_825833_58AD5F9C 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 9:26 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This adds a DT binding documentation for the M10V and its evaluation
> board.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt



I added uniphier SoC/board binding into

Documentation/devicetree/bindings/arm/socionext/uniphier.txt


You can milbeaut.txt to the socionext directory as well.




> new file mode 100644
> index 0000000..9fd053a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/milbeaut.txt
> @@ -0,0 +1,6 @@
> +Milbeaut platforms device tree bindings
> +---------------------------------------
> +
> +- Milbeaut M10V Evaluation Board
> +    Required root node properties:
> +      - compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
