From: liu.h.jason@gmail.com (Jason Liu)
Date: Tue, 13 Sep 2011 14:31:30 +0800
Subject: [[PATCH v2] mtd: check parts pointer before using it
In-Reply-To: <1314185188-6151-1-git-send-email-jason.hui@linaro.org>
References: <1314185188-6151-1-git-send-email-jason.hui@linaro.org>
Message-ID: <CAB4PhKd_=KjNGJ+3TL5tqPqoetcD28oaWC55UqNRqFGZ7gmYHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Artem,

2011/8/24 Jason Liu <jason.hui@linaro.org>:
> The code has the check for parts but it called after kmemdup,
> kmemdup(parts, sizeof(*parts) * nr_parts,...)
> if (!parts)
> ? ? ? ?return -ENOMEM
>
> In fact, we need check parts before safely using it.
> and we also need check the real_parts to make sure kmemdup
> allocation sucessfully.
>
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> ---
> V2: Fix one error condition check and add real_parts check too.
> ---
> This patch is based on git://git.infradead.org/users/dedekind/l2-mtd-2.6.git
> ---
> ?drivers/mtd/mtdcore.c | ? ?7 ++++---
> ?1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 09bdbac..b01993e 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -465,12 +465,13 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char **types,
> ? ? ? ?struct mtd_partition *real_parts;
>
> ? ? ? ?err = parse_mtd_partitions(mtd, types, &real_parts, parser_data);
> - ? ? ? if (err <= 0 && nr_parts) {
> + ? ? ? if (err <= 0 && nr_parts && parts) {
> ? ? ? ? ? ? ? ?real_parts = kmemdup(parts, sizeof(*parts) * nr_parts,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? GFP_KERNEL);
> - ? ? ? ? ? ? ? err = nr_parts;
> - ? ? ? ? ? ? ? if (!parts)
> + ? ? ? ? ? ? ? if (!real_parts)
> ? ? ? ? ? ? ? ? ? ? ? ?err = -ENOMEM;
> + ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? ? ? ? ? err = nr_parts;
> ? ? ? ?}
>
> ? ? ? ?if (err > 0) {
> --
> 1.7.4.1

Ping, any comments about it? Thanks,

Jason

>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
