From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Tue, 26 Jul 2016 14:13:45 +0200
Subject: [PATCH 2/3] stmmac: change dma descriptors to __le32
In-Reply-To: <20160721182329.13478-3-michael.weiser@gmx.de>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-3-michael.weiser@gmx.de>
Message-ID: <e5229894-45fc-671e-641a-e41c7ab176d7@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/21/2016 8:23 PM, Michael Weiser wrote:
> The stmmac driver does not take into account the processor may be big
> endian when writing the DMA descriptors. This causes the ethernet
> interface not to be initialised correctly when running a big-endian
> kernel. Change the descriptors for DMA to use __le32 and ensure they are
> suitably swapped before writing. Tested successfully on the
> Cubieboard2.

Thx for the effort on big endian platform.
>
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: netdev at vger.kernel.org
> ---
...
>
> @@ -2880,14 +2876,17 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
>  			x = *(u64 *) ep;
>  			seq_printf(seq, "%d [0x%x]: 0x%x 0x%x 0x%x 0x%x\n",
>  				   i, (unsigned int)virt_to_phys(ep),
> -				   ep->basic.des0, ep->basic.des1,
> -				   ep->basic.des2, ep->basic.des3);
> -			ep++;
> +				   le32_to_cpu(ep->basic.des0),
> +				   le32_to_cpu(ep->basic.des1),
> +				   le32_to_cpu(ep->basic.des2),
> +				   le32_to_cpu(ep->basic.des3));
> +			ep++);


there is a build problem here.

Pls fix it.


Peppe
