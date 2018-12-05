Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A4CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB61D206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qN4OVLJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB61D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VlZd/aMatTG1LM8UmnvilTY25nqhQWMyP/ZSrJ4KbO4=; b=qN4OVLJfYScBq9
	OosVKp1qUCQVzspC1FIQCVUqiZVFx+E6ShSx9+EM4sDYcQYqcUV6025QnpuotSGPAZRb8x0mheOge
	InoknajXCZSscXs8Y4MV0wawE3U9I5+fvSpmMqOjxW/14ZN5/hN8G5GFSNktKvOEipY853J8F//ia
	1cTm3ZlL2XfkRwFMIiXOLq5ZHymc/jEKlBctkkrhWokZO7Lash+0OfYYbmIoagbOF4p8AaS+3Z4Un
	FED+peul6GvfHr+Q8CuRyV3pSr6k1wzoLWFkUlT9ZgtbHAzrdi0kQPBfvn/yMkzvXQwPEgFIGXYl+
	ZD37GApEM0O1mMnUKN8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUShc-0005fe-G5; Wed, 05 Dec 2018 08:38:40 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUSgk-0004pI-R7
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 08:37:49 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9825F20E23; Wed,  5 Dec 2018 09:37:35 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 42F6C207BD;
 Wed,  5 Dec 2018 09:37:25 +0100 (CET)
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/22] drm/sun4i: Support for linear and tiled YUV formats
 with the frontend
Date: Wed,  5 Dec 2018 09:36:41 +0100
Message-Id: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_003747_264743_7C80FF27 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-sunxi@googlegroups.com,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series implements support for YUV formats using the display engine
frontend in the sun4i DRM driver, with various fixes along the way.
Scaling is supported for every format handled by the frontend.

The tiling mode used by the VPU on Allwinner platforms is also supported
by this series and a dedicated fourcc modifier is introduced, along with
a specific ioctl for allocating tiled buffers.

New common fourcc helpers are also introduced in this series, especially
related to YUV formats.

This was tested on the A33 and A20 platforms and all supported features
work properly on both. Framebuffer offsets and source positions are not
supported at this point.

Changes since v3:
* Made the BT.601 CSC coefficients common;
* Moved the tiling mode comment next to the associated macro;
* Added collected Acked-by tags.

Changes since v2:
* Removed DRM format helpers taking the format fourcc;
* Passed the DRM format info structure when needed instead of iterating
  through the list;
* Removed the sun4i-specific ioctl for allocating tiled buffers, which
  will be rebranded as a generic one in an upcoming patch;
* Improved comment for X1 tiled offset and simplified its calculation;
* Corrected author email and added SoB where needed;
* Rebased on latest drm-misc next.

Changes since v1:
* Extended source selected cleanup to both YUV and video channels;
* Split and reworded comment about backend scaling;
* Sorted newly-introduced lists alphabetically;
* Simplified functions to check if a format is supported;
* Reworked frontend selection logic as discussed;
* Made YUV helpers common, with fourcc and drm_info fashions;
* Changed the CREATE_TILED ioctl flags to match the CREATE_DUMB ioctl;
* Reworked YUV dimensions calculations to use drm_format_info;
* Dropped MB32 part in modifier to match V4L2 definition name;
* Improved the description of the tiling modifier;
* Avoided splitting CSC coefficients to avoid introducing a new module;
* Fixed building the driver as modules;
* Various code simplifications and cleanups;
* Split commits into logical changes.

Maxime Ripard (5):
  drm/sun4i: Move access control before setting the register as
    documented
  drm/sun4i: frontend: Add a quirk structure
  drm/sun4i: Set the coef_rdy bit right after the coef have been set
  drm/sun4i: Make COEF_RDY conditional
  drm/sun4i: frontend: Move the FIR filter phases to our quirks

Paul Kocialkowski (17):
  drm/fourcc: Add format info helpers for checking YUV planes
    disposition
  drm/fourcc: Add format info helpers for checking YUV sub-sampling
  drm/sun4i: backend: Use explicit fourcc helpers for packed YUV422
    check
  drm/sun4i: frontend: Pass DRM format info to input format helpers
  drm/sun4i: frontend: Determine input format based on colorspace
  drm/sun4i: Move the BT.601 CSC coefficients to the frontend
  drm/sun4i: frontend: Configure and enable YUV to RGB CSC when needed
  drm/sun4i: frontend: Add support for packed YUV422 input formats
  drm/sun4i: frontend: Add support for semi-planar YUV input formats
  drm/sun4i: frontend: Add support for planar YUV input formats
  drm/fourcc: Add definitions for Allwinner vendor and VPU tiled format
  drm/sun4i: frontend: Add support for tiled YUV input mode
    configuration
  drm/sun4i: Add buffer stride and offset configuration for tiling mode
  drm/sun4i: frontend: Add and use helper for checking tiling support
  drm/sun4i: layer: Add tiled modifier support and helper
  drm/sun4i: drv: Allow framebuffer modifiers in mode config
  drm/sun4i: frontend: Add A20-specific device-tree compatible and
    quirks

 drivers/gpu/drm/sun4i/sun4i_backend.c  |  25 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c      |   1 +
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 346 ++++++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  52 ++++
 drivers/gpu/drm/sun4i/sun4i_layer.c    |  28 +-
 include/drm/drm_fourcc.h               | 117 +++++++++
 include/uapi/drm/drm_fourcc.h          |  16 ++
 7 files changed, 530 insertions(+), 55 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
