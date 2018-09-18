From: bp@alien8.de (Borislav Petkov)
Date: Tue, 18 Sep 2018 09:55:22 +0200
Subject: [PATCH v7 2/7] edac: synps: Add platform specific structures for
 ddrc controller
In-Reply-To: <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180918075522.GC22202@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 07:55:00PM +0530, Manish Narani wrote:
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
> +	if (!(p_data->get_eccstate(baseaddr))) {

>From last review round:

"Too many parentheses:

        if (!p_data->...

is enough."

So I'm going to stop reviewing this patchset until you go through the
old review round again and make sure you've incorporated *all* review
feedback and haven't forgotten some, like the one above.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
