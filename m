From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 6 Mar 2014 07:58:43 +0100
Subject: [PATCHv8][ 4/7] staging: imx-drm: Use de-active and
 pixelclk-active display-timings.
In-Reply-To: <1393437097-25129-4-git-send-email-denis@eukrea.com>
References: <1393437097-25129-1-git-send-email-denis@eukrea.com>
 <1393437097-25129-4-git-send-email-denis@eukrea.com>
Message-ID: <20140306075843.55e51951@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Denis Carikli wrote:
> If de-active and/or pixelclk-active properties were set in the
> display-timings DT node, they were not used.
> 
> Instead the data-enable and the pixel data clock polarity
> were hardcoded.
> 
> This change is needed for making the eukrea-cpuimx51
>   QVGA display work.
> 
I just tried this patch on our hardware and found that the pixelclock
polarity is inverse to what the documentation says.

Your patch sets the 'clk_pol' variable in positive logic, while it is
interpreted in negative logic when converted to the final register
value in drivers/staging/imx-drm/ipu-v3/ipu-di.c:

	if (!(sig->clk_pol))
		di_gen |= DI_GEN_POLARITY_DISP_CLK;

IMO this should be
	if (sig->clk_pol)
		di_gen |= DI_GEN_POLARITY_DISP_CLK;

Did you actually measure the resulting clock signal and LCD data?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
