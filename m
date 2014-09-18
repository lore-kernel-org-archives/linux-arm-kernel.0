From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 18 Sep 2014 22:03:57 +0200
Subject: [PATCH v2 1/2] bcma: register bcma as device tree driver
In-Reply-To: <1410904582-6519-1-git-send-email-hauke@hauke-m.de>
References: <1410904582-6519-1-git-send-email-hauke@hauke-m.de>
Message-ID: <CACna6rw0-g+v6u3Yxhnmy1NT0mhj-s4re5R3z0dbBV-tMvky6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 September 2014 23:56, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> +The cores on the AXI bus are auto detected by bcma. bcma automatically
> +detects the cores

I'm far from being an English expert, but above is kind of pleonasm to me ;)


> and the memory ranges they are using and they get
> +registered afterwards. Automatic detection of the IRQ number is not
> +possible on BCM47xx/BCM53xx ARM and MIPS SoCs.

Should we replace "not possible" with something like "not reliable"?
After the last info we got from Arend.


> +#ifdef CONFIG_BCMA_HOST_SOC
> +/* host_pci.c */

s/pci/soc/


> +#ifdef CONFIG_OF
> +extern int __init bcma_host_soc_register_driver(void);
> +extern void __exit bcma_host_soc_unregister_driver(void);
> +#else
> +static inline int __init bcma_host_soc_register_driver(void)
> +{
> +       return 0;
> +}
> +static inline void __exit bcma_host_soc_unregister_driver(void)
> +{
> +}
> +#endif /* CONFIG_OF */
> +#endif /* CONFIG_BCMA_HOST_SOC */

OK, so you just made bcma_host_soc_(un)register_driver calls safe above.


> diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
> index c421403..e5d578c 100644
> --- a/drivers/bcma/main.c
> +++ b/drivers/bcma/main.c
> @@ -528,6 +528,13 @@ static int __init bcma_modinit(void)
>         if (err)
>                 return err;
>
> +#ifdef CONFIG_BCMA_HOST_SOC
> +       err = bcma_host_soc_register_driver();
> +       if (err) {
> +               pr_err("SoC host initialization failed\n");
> +               err = 0;
> +       }
> +#endif

And above you check for CONFIG_ anyway.

-- 
Rafa?
