From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 16 Feb 2016 09:45:57 +0000
Subject: [PATCH 1/3] clk: sunxi: improve mux_clk error handling and
 reporting
In-Reply-To: <CAGb2v65hxNiY8XAL=yBbV4qazscJd+six432CKWAm+GfM6bd2Q@mail.gmail.com>
References: <1455289913-29514-1-git-send-email-andre.przywara@arm.com>
 <1455289913-29514-2-git-send-email-andre.przywara@arm.com>
 <CAGb2v65hxNiY8XAL=yBbV4qazscJd+six432CKWAm+GfM6bd2Q@mail.gmail.com>
Message-ID: <56C2EFD5.5080604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On 13/02/16 02:44, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Feb 12, 2016 at 11:11 PM, Andre Przywara <andre.przywara@arm.com> wrote:
>> We now catch and report a failing ioremap, also a failure in the final
>> step of the clock registration is now handled and reported.
>> Also warnings are turned into errors.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  drivers/clk/sunxi/clk-sunxi.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index 49ce283..361f396 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> @@ -690,11 +690,15 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
>>         int i;
>>
>>         reg = of_iomap(node, 0);
>> +       if (!reg) {
>> +               pr_err("Could not map registers for mux-clk: %s\n", node->name);
> 
> of_node_full_name(node->name) is better. node->name is almost always "clk",
> which is useless. (Unless someone goes through the dts files to replace all
> of them.)

Good point. I both fixed the code here as well as amended the node names
in the A64 DT.

> 
>> +               return NULL;
>> +       }
>>
>>         i = of_clk_parent_fill(node, parents, SUNXI_MAX_PARENTS);
>>         if (of_property_read_string(node, "clock-output-names", &clk_name)) {
>> -               pr_warn("%s: could not read clock-output-names for \"%s\"\n",
>> -                       __func__, clk_name);
>> +               pr_err("%s: could not read clock-output-names for \"%s\"\n",
>> +                      __func__, clk_name);
> 
> Same here. clk_name defaults to node->name. If you could, please replace it.

Really? Isn't clk_name directly from the DT clock-output-names strings here?

>>                 goto out_unmap;
>>         }
>>
>> @@ -704,14 +708,17 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
>>                                0, &clk_lock);
>>
>>         if (IS_ERR(clk)) {
>> -               pr_warn("%s: failed to register mux clock %s: %ld\n", __func__,
>> -                       clk_name, PTR_ERR(clk));
>> +               pr_err("%s: failed to register mux clock %s: %ld\n", __func__,
>> +                      clk_name, PTR_ERR(clk));
>>                 goto out_unmap;
>>         }
>>
>> -       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +       if (!of_clk_add_provider(node, of_clk_src_simple_get, clk))
>> +               return clk;
>> +
>> +       pr_err("%s: failed to add clock provider for %s\n", __func__, clk_name);
>>
>> -       return clk;
> 
> I'd have all the error path in ifs, and have the normal return path
> here for consistency.
> But I guess this works as well.

Yeah, I wanted to skip that single goto ;-)
But I changed it now as you said and it indeed looks more reasonable.

I took the freedom of applying the comments to the other patches too.

Will send out a v2 in a minute.

Thanks for looking!
Andre.

> 
> Thanks!
> ChenYu
> 
>> +       clk_unregister_divider(clk);
>>
>>  out_unmap:
>>         iounmap(reg);
>> --
>> 2.6.4
>>
> 
