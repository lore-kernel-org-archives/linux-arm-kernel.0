From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 26 Sep 2011 11:32:53 +0200 (CEST)
Subject: [PATCH v3 2/2] at91: add Atmel ISI and ov2640 support on
	sam9m10/sam9g45 board.
In-Reply-To: <4E804440.7030709@atmel.com>
References: <1316664661-11383-1-git-send-email-josh.wu@atmel.com>
	<1316664661-11383-2-git-send-email-josh.wu@atmel.com>
	<Pine.LNX.4.64.1109220911500.11164@axis700.grange>
	<20110924052609.GI29998@game.jcrosoft.org>
	<4E804440.7030709@atmel.com>
Message-ID: <Pine.LNX.4.64.1109261130270.9168@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas

On Mon, 26 Sep 2011, Nicolas Ferre wrote:

> Le 24/09/2011 07:26, Jean-Christophe PLAGNIOL-VILLARD :
> > On 09:35 Thu 22 Sep     , Guennadi Liakhovetski wrote:
> >> On Thu, 22 Sep 2011, Josh Wu wrote:
> >>
> >>> This patch
> >>> 1. add ISI_MCK parent setting code when add ISI device.
> >>> 2. add ov2640 support on board file.
> >>> 3. define isi_mck clock in sam9g45 chip file.
> >>>
> >>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>> ---
> >>>  arch/arm/mach-at91/at91sam9g45.c         |    3 +
> >>>  arch/arm/mach-at91/at91sam9g45_devices.c |  105 +++++++++++++++++++++++++++++-
> >>>  arch/arm/mach-at91/board-sam9m10g45ek.c  |   85 ++++++++++++++++++++++++-
> >>>  arch/arm/mach-at91/include/mach/board.h  |    3 +-
> >>
> >> Personally, I think, it would be better to separate this into two patches 
> >> at least: one for at91 core and one for the specific board, but that's up 
> >> to arch maintainers to decide.
> >>
> >> You also want to patch arch/arm/mach-at91/at91sam9263_devices.c, don't 
> >> you?
> > agreed
> 
> No, I am not sure. The IP is not the same between 9263 and 9g45/9m10. So
> this inclusion will not apply.

Sorry, that's not what I meant. This patch changes a function declaration:

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index ed544a0..276d63a 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -183,7 +183,8 @@ extern void __init at91_add_device_lcdc(struct 
atmel_lcdfb_info *data);
 extern void __init at91_add_device_ac97(struct ac97c_platform_data 
*data);
 
  /* ISI */
-extern void __init at91_add_device_isi(void);
+struct isi_platform_data;
+extern void __init at91_add_device_isi(struct isi_platform_data *data);
 
  /* Touchscreen Controller */
 struct at91_tsadcc_data {

but doesn't change that function implementation in at91sam9263_devices.c, 
which will break compilation, AFAICS.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
