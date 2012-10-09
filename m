From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 9 Oct 2012 06:42:01 +0200
Subject: [PATCH v2] video: imxfb: Do not crash on reboot
In-Reply-To: <1349735038-19196-1-git-send-email-festevam@gmail.com>
References: <1349735038-19196-1-git-send-email-festevam@gmail.com>
Message-ID: <20121009044201.GA4640@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Oct 08, 2012 at 07:23:58PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Issuing a "reboot" command after the LCD times out causes the following
> warnings:

[snip]

> @@ -513,47 +514,53 @@ static void imxfb_exit_backlight(struct imxfb_info 
> *fbi)
>  
>  static void imxfb_enable_controller(struct imxfb_info *fbi)
>  {
> -	pr_debug("Enabling LCD controller\n");
> +	if (!fbi->enabled) {
> +		pr_debug("Enabling LCD controller\n");

Won't it be simpler to just do:

    if (fbi->enabled)
        return;

instead of adding another nesting level to the whole routine?

>  static void imxfb_disable_controller(struct imxfb_info *fbi)
>  {
> -	pr_debug("Disabling LCD controller\n");
> +	if (fbi->enabled) {
> +		pr_debug("Disabling LCD controller\n");

ditto (with inverted logic).

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
