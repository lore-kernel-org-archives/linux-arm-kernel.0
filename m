From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 09 May 2014 17:43:21 +0530
Subject: [RFC PATCH v2 1/2] mfd: syscon: Support early initialization
In-Reply-To: <fa3178534fcf4488fc45a9a24e44b2588acb38c6.1392807832.git.michal.simek@xilinx.com>
References: <cover.1392807832.git.michal.simek@xilinx.com>
 <fa3178534fcf4488fc45a9a24e44b2588acb38c6.1392807832.git.michal.simek@xilinx.com>
Message-ID: <536CC661.7000706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/19/2014 04:34 PM, Michal Simek wrote:
> Some platforms need to get system controller ready as soon as
> possible. The patch provides early_syscon_initialization which
> create early mapping for all syscon compatible devices in
> early_syscon_probe. Regmap is get via
> syscon_early_regmap_lookup_by_phandle()
> 
> Regular device probes attach device to regmap via
> regmap_attach_dev().
> 
> For early syscon initialization is necessary to extend struct
> syscon and provide remove function which unmap all early init
> structures.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com> ---
> 

I don't have V3 in my mailbox, hence replying to this thread. The
content is applicable to V3.

[...]
> @@ -95,6 +98,24 @@ struct regmap
> *syscon_regmap_lookup_by_pdevname(const char *s) } 
> EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_pdevname);
> 
> +struct regmap *syscon_early_regmap_lookup_by_phandle(struct
> device_node *np, +						     const char *property) +{ +	struct
> device_node *syscon_np; +	struct syscon *syscon; + +	syscon_np =
> of_parse_phandle(np, property, 0); +	if (!syscon_np) +		return
> ERR_PTR(-ENODEV); + +	syscon = syscon_np->data; + +
> of_node_put(syscon_np); + +	return syscon->regmap;

This fails while derefencing syscon if if early_syscon_init() has not
yet been not yet been called. Something like this would be helpful.

struct regmap *regmap = ERR_PTR(-ENODEV);

syscon = syscon_np->data;
if (syscon)
	regmap = syscon->regmap;

return regmap;


- -- 
Tushar Behera
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTbMZMAAoJELqclMPPkq4NoZEH/j/vTBLu0VmKm01jZqJUUC59
siD+DvRclRcdRGCzsf7iN9Zjw2g+abDtEBynBNdC6swTJJUwDyMtkcguiHn/ytPN
B/5bli3rKpRkDlg9i/Cfgqd2KmYh1U6Q2LJ3+pyRAQqe0zm+bI5+fp/cn1PGLBIW
1R2rexJO98GhGO/Yhh62FD366rB15bgApC2+XjYb2Wcka3f8VY47gqkxnAwxZzvU
ovG/rqXEuGW7H3o/+BLDtmQREEjKg20ggRo2FEj0WozhTo6Sn2YUJg70DKioguu0
eteP+X4DsShluJfxq9/51bfFutlXPPYZIbLIZxwyiFSJiAIR8hjLO/Ed/GicybQ=
=HCI5
-----END PGP SIGNATURE-----
