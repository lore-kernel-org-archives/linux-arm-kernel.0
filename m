From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 31 Oct 2013 13:04:51 +0100
Subject: [PATCH] ARM: imx6q: add missing sentinel to divider table
In-Reply-To: <1383220548-8622-1-git-send-email-LW@KARO-electronics.de>
References: <1383220548-8622-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20131031130451.15e90077@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Lothar Wa?mann wrote:
> The clk_enet_ref_table[] is missing a final empty entry as end of list
> marker. Also make the existing markers more obvious.
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/mach-imx/clk-imx6q.c |    5 +++--
>
There is something else that looks suspicious in this file:
The video_div_table[] has four entries:
|	{ .val = 0, .div = 1, },
|	{ .val = 1, .div = 2, },
|	{ .val = 2, .div = 1, },
|	{ .val = 3, .div = 4, },

But the code that sets the dividers to '1' as a workaround for the TO1.0
chip revision only two dividers are modified, one of which is already
'1':
|if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0) {
|	post_div_table[1].div = 1;
|	post_div_table[2].div = 1;
|	video_div_table[1].div = 1;
|	video_div_table[2].div = 1;
	                ^
This probably should be '3' instead?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
