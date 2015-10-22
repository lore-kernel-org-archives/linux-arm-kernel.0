From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 22 Oct 2015 11:08:37 +0200
Subject: [PATCH 0/6] ARM: sunxi: Introduce Allwinner H3 support
In-Reply-To: <20151022095857.50e2330b@OPI2>
References: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
 <5627E515.6050505@redhat.com> <20151022095857.50e2330b@OPI2>
Message-ID: <5628A795.8000905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22-10-15 09:58, Jean-Francois Moine wrote:
> On Wed, 21 Oct 2015 21:18:45 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
>
>> Great to see that you've started working on this again. Last weekend I
>> ended up working on this too together with Reinder E.N. de Haan <reinder@mveas.com>
>> (added to the Cc).
>>
>> We took a slightly different approach for the gates clocks, see:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commits/sunxi-wip
>>
>> And specifically:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/80a1afe319d5d1a0c426d42e75d37f0c64e8ea0b
>>
>> Combined with:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/d508da5feb5048f6674d6b24b58ac9058fb9d877
>>
>> This deals with the per gate parents the same way the rockchip
>> clock code does, and it seems to be quite a bit less code then your solution.
>
> Here is a simpler patch:
>
> diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
> index 6ce9118..8fecaeab 100644
> --- a/drivers/clk/sunxi/clk-simple-gates.c
> +++ b/drivers/clk/sunxi/clk-simple-gates.c
> @@ -35,6 +35,7 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
>   	void __iomem *reg;
>   	const __be32 *p;
>   	int number, i = 0, j;
> +	bool parent_per_gate;
>   	u8 clk_bit;
>   	u32 index;
>
> @@ -43,6 +44,7 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
>   		return;
>
>   	clk_parent = of_clk_get_parent_name(node, 0);
> +	parent_per_gate = of_clk_get_parent_count(node) != 1;
>
>   	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
>   	if (!clk_data)
> @@ -58,6 +60,8 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
>   	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
>   		of_property_read_string_index(node, "clock-output-names",
>   					      i, &clk_name);
> +		if (parent_per_gate)
> +			clk_parent = of_clk_get_parent_name(node, i);
>
>   		clk_reg = reg + 4 * (index / 32);
>   		clk_bit = index % 32;
>
>

Yes good one, doing things that way indeed is better.

Regards,

Hans
