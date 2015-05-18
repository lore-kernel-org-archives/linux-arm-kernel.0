From: jenskuske@gmail.com (Jens Kuske)
Date: Mon, 18 May 2015 11:15:42 +0200
Subject: [PATCH v2 03/10] clk: sunxi: Let divs clocks read the base factor
 clock name from devicetree
In-Reply-To: <CAGb2v64y8+bdya3N=gK-YEie3A9nVM5nuxRZTVPXYSaN6WzPoQ@mail.gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>	<1431707940-19372-4-git-send-email-jenskuske@gmail.com>
 <CAGb2v64y8+bdya3N=gK-YEie3A9nVM5nuxRZTVPXYSaN6WzPoQ@mail.gmail.com>
Message-ID: <5559ADBE.7060506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/16/15 04:10, Chen-Yu Tsai wrote:
> 2015?5?16? ??12:39? "Jens Kuske" <jenskuske@gmail.com>???
[..]
>> @@ -1141,6 +1133,7 @@ static void __init sunxi_divs_clk_setup(struct
> device_node *node,
>>         struct clk_gate *gate = NULL;
>>         struct clk_fixed_factor *fix_factor;
>>         struct clk_divider *divider;
>> +       struct factors_data factors = *data->factors;

Isn't this a copy?

>>         void __iomem *reg;
>>         int ndivs = SUNXI_DIVS_MAX_QTY, i = 0;
>>         int flags, clkflags;
>> @@ -1149,8 +1142,17 @@ static void __init sunxi_divs_clk_setup(struct
> device_node *node,
>>         if (data->ndivs)
>>                 ndivs = data->ndivs;
>>
>> +       /* Try to find a name for base factor clock */
>> +       for (i = 0; i < ndivs; i++) {
>> +               if (data->div[i].self) {
>> +                       of_property_read_string_index(node,
> "clock-output-names",
>> +                                                     i, &factors.name);
> 
> Please excuse the bad formatting.
> I'm at the airport without my laptop.
> 
> This will not work. All the static factors_data structs are const.
> You should make a copy of it, maybe on the stack,
> update the .name field, and pass that to sunxi_factors_clk_setup().
> 

If I didn't miss anything, or misunderstood what you want to copy, this
should be working fine.

Jens
