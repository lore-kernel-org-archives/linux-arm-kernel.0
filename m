From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 27 Feb 2013 08:32:13 +0200
Subject: [REPOST PATCH 1/2] clk: add table lookup to mux
In-Reply-To: <1361545358-22721-2-git-send-email-pdeschrijver@nvidia.com>
References: <1361545358-22721-1-git-send-email-pdeschrijver@nvidia.com>
 <1361545358-22721-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130227083213.aa234eea89272b09d6551f78@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Feb 2013 16:02:28 +0100
Peter De Schrijver <pdeschrijver@nvidia.com> wrote:

> Add a table lookup feature to the mux clock. Also allow arbitrary masks
> instead of the width. This will be used by some clocks on Tegra114.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
....
> @@ -42,7 +43,17 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
>  	 * val = 0x4 really means "bit 2, index starts at bit 0"
>  	 */
....
> +	if (mux->table) {
> +		int i;
> +
> +		for (i = 0; i < num_parents; i++)
> +			if (mux->table[i] == val)
> +				return i;
> +		if (i == num_parents)
> +			return -EINVAL;
> +	}

Can't we just return after for-loop without checking i == num_parents as below?

+		for (i = 0; i < num_parents; i++) {
+			if (mux->table[i] == val)
+				return i;
+		}
+
+		return -EINVAL;
