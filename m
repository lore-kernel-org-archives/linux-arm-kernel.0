From: bp@alien8.de (Borislav Petkov)
Date: Fri, 5 Oct 2018 18:53:51 +0200
Subject: [PATCH v8 05/10] edac: synps: Add platform specific structures
 for ddrc controller
In-Reply-To: <1538667328-9465-6-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
 <1538667328-9465-6-git-send-email-manish.narani@xilinx.com>
Message-ID: <20181005165351.GD10285@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 09:05:23PM +0530, Manish Narani wrote:
> Add platform specific structures, so that we can add different IP
> support later using quirks.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 91 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 26 deletions(-)

...

> @@ -423,6 +465,7 @@ static void edac_mc_init(struct mem_ctl_info *mci,
>   */
>  static int synps_edac_mc_probe(struct platform_device *pdev)
>  {
> +	const struct synps_platform_data *p_data;
>  	struct edac_mc_layer layers[2];
>  	struct synps_edac_priv *priv;
>  	struct mem_ctl_info *mci;
> @@ -435,7 +478,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	if (IS_ERR(baseaddr))
>  		return PTR_ERR(baseaddr);
>  
> -	if (!edac_get_eccstate(baseaddr)) {
> +	p_data = of_device_get_match_data(&pdev->dev);

That of_device_get_match_data()  does return NULL...

> +	if (!p_data->get_eccstate(baseaddr)) {

... I'm sure you can imagine what happens here if so.

Anyway, I've pushed what I've applied so far, here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-for-4.20-synps

Please add the error handling ontop of the top patch on that branch and
send the diff to me.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
