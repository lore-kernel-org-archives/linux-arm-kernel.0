From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 26 Oct 2012 12:53:45 +0000
Subject: [RFC PATCH v3 05/16] ARM: edma: add AM33XX crossbar event support
In-Reply-To: <1350566815-409-6-git-send-email-mporter@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-6-git-send-email-mporter@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAB5BC7@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 18:56:44, Porter, Matt wrote:
> Adds support for the per-EDMA channel event mux. This is required
> for any peripherals using DMA crossbar mapped events.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/common/edma.c             |   63 +++++++++++++++++++++++++++++++++++-
>  include/linux/platform_data/edma.h |    1 +
>  2 files changed, 63 insertions(+), 1 deletion(-)
> 

..snip..
..snip..

> +
> +	for (i = 0; xbar_chans[i][0] != -1; i++) {
> +		shift = (xbar_chans[i][1] % 4) * 8;
> +		offset = xbar_chans[i][1] >> 2;
> +		offset <<= 2;
> +		mux = __raw_readl((void *)((u32)xbar + offset));
> +		mux &= (~(0xff << shift));
> +		mux |= (xbar_chans[i][0] << shift);
> +		__raw_writel(mux, (void *)((u32)xbar + offset));

This method of calculating Xbar Channel offset has a bug that
the code breaks with unaligned access trap error when requested 
channel to be mapped is odd.

This was fixed in Arago tree [1]. Kindly verify


> +	}
> +
> +	pdata->xbar_chans = xbar_chans;
> +
> +	return 0;
> +}
> +

..snip..
..snip..

[1]
http://arago-project.org/git/projects/?p=linux-am33x.git;a=commitdiff;
h=c08d3cb557adf71c79aeefb38888395455824e83

Regards, 
Gururaja
