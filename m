From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 16:50:42 +0000
Subject: [PATCH V5 57/63] ST SPEAr3xx: Updating plgpio and emi source
	to make it compliant with single image strategy
In-Reply-To: <29f3e319e062a9f2f65ea9683fb9663f938dfa3b.1295499395.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<29f3e319e062a9f2f65ea9683fb9663f938dfa3b.1295499395.git.viresh.kumar@st.com>
Message-ID: <20110219165042.GN29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 12:56:35PM +0530, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Why aren't the plgpio bits of this in patch 16?

> +static u32 plgpio_enb, plgpio_wdata, plgpio_dir, plgpio_rdata, plgpio_ie,
> +	   plgpio_mis;

'int' or 'unsigned int' will do for these.  There's no pressing need for
these to be exactly 32-bit quantities.

>  static int __init plgpio_init(void)
>  {
> +	if (machine_is_spear310()) {
> +		plgpio_enb = SPEAR310_PLGPIO_ENB;
> +		plgpio_wdata = SPEAR310_PLGPIO_WDATA;
> +		plgpio_dir = SPEAR310_PLGPIO_DIR;
> +		plgpio_rdata = SPEAR310_PLGPIO_IE;
> +		plgpio_ie = SPEAR310_PLGPIO_RDATA;
> +		plgpio_mis = SPEAR310_PLGPIO_MIS;
> +	} else if (machine_is_spear320()) {
> +		plgpio_enb = SPEAR320_PLGPIO_ENB;
> +		plgpio_wdata = SPEAR320_PLGPIO_WDATA;
> +		plgpio_dir = SPEAR320_PLGPIO_DIR;
> +		plgpio_rdata = SPEAR320_PLGPIO_IE;
> +		plgpio_ie = SPEAR320_PLGPIO_RDATA;
> +		plgpio_mis = SPEAR320_PLGPIO_MIS;
> +	} else {
> +		return 0;

If it's not supported, then what about returning an error instead of
zero?

Can you supersede this patch and patch 16 in the patch system with a
single patch which adds PLGPIO support with no further updates.

You may also consider combining the EMI updates with the patch which
creates EMI support in the first place, which I think is patch 36.
