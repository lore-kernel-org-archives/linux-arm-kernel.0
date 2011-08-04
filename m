From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 4 Aug 2011 15:57:28 +0530
Subject: [PATCH V2 18/20] dmaengine/amba-pl08x: Add support for sg len
	greater than one for slave transfers
In-Reply-To: <e404b8f659f6f06709d1adb0bdbe3624bd9a885a.1312190882.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
	<e404b8f659f6f06709d1adb0bdbe3624bd9a885a.1312190882.git.viresh.kumar@st.com>
Message-ID: <4E3A7410.6090108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2011 03:07 PM, Viresh KUMAR wrote:
> @@ -563,6 +565,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
>         u32 cctl, early_bytes = 0;
>         size_t max_bytes_per_lli, total_bytes = 0;

> +       list_for_each_entry(dsg, &txd->dsg_list, node) {
> +               cctl = txd->cctl;
> 
> -       /* We need to count this down to zero */
> -       bd.remainder = txd->len;
> +               bd.srcbus.addr = dsg->src_addr;
> +               bd.dstbus.addr = dsg->dst_addr;
> +               bd.remainder = dsg->len;
> +               bd.srcbus.buswidth = bd.srcbus.maxwidth;
> +               bd.dstbus.buswidth = bd.dstbus.maxwidth;
> 

> +               if (total_bytes != dsg->len) {
> +                       dev_err(&pl08x->adev->dev,
> +                               "%s size of encoded lli:s don't match total txd, transferred 0x%08zx from size 0x%08zx\n",
> +                               __func__, total_bytes, dsg->len);
> +                       return 0;
> +               }
>         }

Correction:

total_bytes must be reinitialized to zero inside list_for_each_entry loop.
As we are comparing it to dsg->len for every dsg.

Will fix this and send with V3.

-- 
viresh
