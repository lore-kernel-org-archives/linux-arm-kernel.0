From: tiny.windzz@gmail.com (Frank Lee)
Date: Mon, 26 Nov 2018 22:42:37 +0800
Subject: [PATCH v2] soc: bcm: brcmstb: Don't leak device tree node
 reference
In-Reply-To: <20181124145223.29208-1-tiny.windzz@gmail.com>
References: <20181124145223.29208-1-tiny.windzz@gmail.com>
Message-ID: <CAEExFWut2Vu0e+j1U8_1PS683DtMMi7FVD6X=LfwwE63DT7Syg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2018 at 10:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> of_find_node_by_path() acquires a reference to the node returned by it
> and that reference needs to be dropped by its caller. soc_is_brcmstb()
> doesn't do that, so fix it.
>
> [treding: slightly rewrite to avoid inline comparison]
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2:
> -update changelog
> -slightly rewrite to avoid inline comparison
> ---
>  drivers/soc/bcm/brcmstb/common.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
> index 14185451901d..bf9123f727e8 100644
> --- a/drivers/soc/bcm/brcmstb/common.c
> +++ b/drivers/soc/bcm/brcmstb/common.c
> @@ -31,13 +31,17 @@ static const struct of_device_id brcmstb_machine_match[] = {
>
>  bool soc_is_brcmstb(void)
>  {
> +       const struct of_device_id *match;
>         struct device_node *root;
>
>         root = of_find_node_by_path("/");
>         if (!root)
>                 return false;
>
> -       return of_match_node(brcmstb_machine_match, root) != NULL;
> +       match = of_match_node(brcmstb_machine_match, root);
> +       of_node_put(root);
> +
> +       return match != NULL;
>  }
>
>  u32 brcmstb_get_family_id(void)
> --
> 2.17.0
>
Hi Florian:

How about this ?

MBR,
Yangtao
