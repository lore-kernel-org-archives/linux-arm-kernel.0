From: jenskuske@gmail.com (Jens Kuske)
Date: Sun, 1 Nov 2015 14:11:12 +0100
Subject: [PATCH v4 1/6] clk: sunxi: Let divs clocks read the base factor
 clock name from devicetree
In-Reply-To: <CAGb2v670cXEPcUFLtsCMFD+s6zUSt+wQg553QXCQHtDtRh9Xmg@mail.gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-2-git-send-email-jenskuske@gmail.com>
 <CAGb2v670cXEPcUFLtsCMFD+s6zUSt+wQg553QXCQHtDtRh9Xmg@mail.gmail.com>
Message-ID: <56360F70.3050400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/15 08:46, Chen-Yu Tsai wrote:
> On Wed, Oct 28, 2015 at 12:50 AM, Jens Kuske <jenskuske@gmail.com> wrote:
[..]
>> @@ -991,8 +985,30 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
>>         if (data->ndivs)
>>                 ndivs = data->ndivs;
>>
>> +       /* Try to find a name for base factor clock */
>> +       for (i = 0; i < ndivs; i++) {
>> +               if (data->div[i].self) {
>> +                       of_property_read_string_index(node, "clock-output-names",
>> +                                                     i, &factors.name);
>> +                       break;
>> +               }
>> +       }
>> +       /* If we don't have a .self clk use the first output-name up to '_' */
> 
> This actually only works for the sun4i divs clocks. sun6i-a31-pll6 uses a
> different naming convention. sun4i-a10-pll2 uses yet another, though that's
> not a divs clock. Maybe we should work on unifying them. Maxime?

All the divs clocks I could find either have a .self (handled by the
first case above) or follow this naming convention, so it should work.
But if we find a better way to clean up the divs without breaking
devicetree bindings (as far as I understood we must not break them, am I
right there?) I'd be happy with that too.

Jens


> 
> Other than these 2 bits of information, this patch looks good.
> 
> 
> Regards
> ChenYu
> 
>> +       if (factors.name == NULL) {
>> +               of_property_read_string_index(node, "clock-output-names",
>> +                                                     0, &clk_name);
>> +
>> +               for (i = 0; i < SUNXI_DIVS_BASE_NAME_MAX_LEN - 1 &&
>> +                                               clk_name[i] != '_' &&
>> +                                               clk_name[i] != '\0'; i++)
>> +                       base_name[i] = clk_name[i];
>> +
>> +               base_name[i] = '\0';
>> +               factors.name = base_name;
>> +       }
>> +
>>         /* Set up factor clock that we will be dividing */
>> -       pclk = sunxi_factors_clk_setup(node, data->factors);
>> +       pclk = sunxi_factors_clk_setup(node, &factors);
>>         parent = __clk_get_name(pclk);
>>
>>         reg = of_iomap(node, 0);
>> --
>> 2.6.2
>>
> 
