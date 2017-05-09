From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 9 May 2017 20:14:35 +0800
Subject: [PATCH V2 1/3] clk: add clk_bulk_get accessories
In-Reply-To: <CAMuHMdVDOor0E2cjEKO+=Pm+1MGO4BibGTdULPvPKd390fTxuw@mail.gmail.com>
References: <1494252233-21074-1-git-send-email-aisheng.dong@nxp.com>
 <1494252233-21074-2-git-send-email-aisheng.dong@nxp.com>
 <CAMuHMdVDOor0E2cjEKO+=Pm+1MGO4BibGTdULPvPKd390fTxuw@mail.gmail.com>
Message-ID: <CAA+hA=TaC2Mdekz1KSPpOGiFY1vKRd+CqLXGd1yb7iRP_j_tnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Mon, May 8, 2017 at 11:08 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Dong,
>
> On Mon, May 8, 2017 at 4:03 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
>> --- /dev/null
>> +++ b/drivers/clk/clk-bulk.c
>> @@ -0,0 +1,165 @@
>
>> +int __must_check clk_bulk_get(struct device *dev, int num_clks,
>> +                             struct clk_bulk_data *clks)
>> +{
>> +       int ret;
>> +       int i;
>> +
>> +       for (i = 0; i < num_clks; i++)
>> +               clks[i].clk = NULL;
>> +
>> +       for (i = 0; i < num_clks; i++) {
>> +               clks[i].clk = clk_get(dev, clks[i].id);
>> +               if (IS_ERR(clks[i].clk)) {
>> +                       ret = PTR_ERR(clks[i].clk);
>> +                       dev_err(dev, "Failed to get clk '%s': %d\n",
>> +                               clks[i].id, ret);
>> +                       clks[i].clk = NULL;
>> +                       goto err;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +err:
>> +       while (--i >= 0)
>> +               clk_put(clks[i].clk);
>
> These are released in inverse order, which is good.
>
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(clk_bulk_get);
>> +
>> +void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < num_clks; i++) {
>> +               clk_put(clks[i].clk);
>> +               clks[i].clk = NULL;
>
> These aren't.
>
> Typically resources are released in the inverse order. Not doing so may
> cause subtle issues.
>
> I can't come up with an example. but I'm quite sure the real world will find
> one soon ;-)
>
> The same is true for enable vs. disable, and prepare vs. unprepare.
>

I thought of it before and was wondering whether it's necessary to do it
as i believe it may be wrong for drivers to reply on the clk_bulk API to
do some some magic ordering to make things run because the API does not
guarantee it.

But i do agree with you that it might be a common sense to release resource
in inverse order, just harmless to do it!
So i will make it in V3 if no objection from Maintainer later.

Thanks for your suggestion!

Regards
Dong Aisheng

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
