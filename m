From: nicolas.dechesne@linaro.org (Nicolas Dechesne)
Date: Thu, 2 Apr 2015 21:47:44 +0200
Subject: [GIT PULL] qcom SoC changes for v4.1
In-Reply-To: <551D9BF6.2070502@codeaurora.org>
References: <alpine.DEB.2.02.1503161601450.30317@galak-ubuntu.qualcomm.com>
 <CAP71WjzKSRRSVLcwpZTaQOYp2uziP7=J=E=3bHAzCjui-ZqbYQ@mail.gmail.com>
 <42F2C5A0-5231-4D4B-95EE-7BC173A14768@codeaurora.org>
 <551D9BF6.2070502@codeaurora.org>
Message-ID: <CAP71WjxbvUZ6p_+=pCNWN5huBcChKy0h8GD+tMM0YeCrZGonMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 2, 2015 at 9:43 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> What about this patch squashed on top? Just guessing but I suspect we
> don't care about cell-index if we're not doing the tcsr stuff. Also, I
> imagine we could get rid of cell-index entirely if we matched against
> the address of the gsbi instead.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>
> ----8<-----
>
> diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
> index 09c669e70d63..ac7d71b6527d 100644
> --- a/drivers/soc/qcom/qcom_gsbi.c
> +++ b/drivers/soc/qcom/qcom_gsbi.c
> @@ -139,7 +139,7 @@ static int gsbi_probe(struct platform_device *pdev)
>         void __iomem *base;
>         struct gsbi_info *gsbi;
>         int i;
> -       u32 mask, gsbi_num;
> +       u32 mask, gsbi_num = 0;
>         const struct crci_config *config = NULL;
>
>         gsbi = devm_kzalloc(&pdev->dev, sizeof(*gsbi), GFP_KERNEL);
> @@ -166,16 +166,19 @@ static int gsbi_probe(struct platform_device *pdev)
>
>                         of_node_put(tcsr_node);
>                 }
> -       }
>
> -       if (of_property_read_u32(node, "cell-index", &gsbi_num)) {
> -               dev_err(&pdev->dev, "missing cell-index\n");
> -               return -EINVAL;
> -       }
> +               if (config) {
> +                       if (of_property_read_u32(node, "cell-index", &gsbi_num)) {
> +                               dev_err(&pdev->dev, "missing cell-index\n");
> +                               return -EINVAL;
> +                       }
> +
> +                       if (gsbi_num < 1 || gsbi_num > MAX_GSBI) {
> +                               dev_err(&pdev->dev, "invalid cell-index\n");
> +                               return -EINVAL;
> +                       }
> +               }
>
> -       if (gsbi_num < 1 || gsbi_num > MAX_GSBI) {
> -               dev_err(&pdev->dev, "invalid cell-index\n");
> -               return -EINVAL;
>         }
>
>         if (of_property_read_u32(node, "qcom,mode", &gsbi->mode)) {


I think it would work, i cannot test right now, i can do it tomorrow
if you need it, but that's pretty much how i tested earlier today (i
had commented out the 2 statements you are putting moving here in the
new if statement.

I did also test with the associated DT patches, and it worked as well.
