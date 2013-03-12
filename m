From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 12 Mar 2013 16:56:45 +0530
Subject: [PATCH 3/4] clk: samsung: always allocate the clk_table
In-Reply-To: <201303121150.35223.heiko@sntech.de>
References: <201303120042.09633.heiko@sntech.de>
 <201303120044.29499.heiko@sntech.de>
 <CAJuYYwT183EcZZ20P8D7AP34CwXfKYLzsmZdoJz1ny7XznzyAg@mail.gmail.com>
 <201303121150.35223.heiko@sntech.de>
Message-ID: <CAJuYYwQK2HUO4xkVbBTgpX+6X7CL3sYCVY6N02_UgXjwfURSTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 March 2013 16:20, Heiko St?bner <heiko@sntech.de> wrote:
> Am Dienstag, 12. M?rz 2013, 10:54:47 schrieb Thomas Abraham:
>> On 12 March 2013 05:14, Heiko St?bner <heiko@sntech.de> wrote:
>> > This is needed to allow looking up previous created clocks when
>> > adding separate aliases to them.
>> >
>> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> > ---
>> >
>> >  drivers/clk/samsung/clk.c |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
>> > index 1a5de69..7c943f8 100644
>> > --- a/drivers/clk/samsung/clk.c
>> > +++ b/drivers/clk/samsung/clk.c
>> > @@ -58,11 +58,11 @@ void __init samsung_clk_init(struct device_node *np,
>> > void __iomem *base,
>> >
>> >  {
>> >
>> >         reg_base = base;
>> >
>> > -#ifdef CONFIG_OF
>> >
>> >         clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
>> >         if (!clk_table)
>> >
>> >                 panic("could not allocate clock lookup table\n");
>>
>> This change is fine but one point that should be considered is that on
>> non-dt platforms, the memory allocation of clk_table cannot really be
>> justified just because few clocks require two or more aliases.
>
> hmm, at least on s3c24xx there are quite a lot of the clocks requiring more
> than one alias. Also the clk_table is allocated on all dt platforms so these
> platforms have to handle the (small) memory consumption in any case and non-dt
> platforms are supposed to die out in the not to distant future.
>
> I.e. I'm working on s3c24xx dt support, Tomasz is working on s3c64xx dt
> support, exynos5 already only has dt support and exynos4 will probably lose
> non-dt support at some point. And if someone converts the other s5p SoCs to
> the common clock framework they should already have the means to go to dt
> directly by then.
>
> So the non-dt common-clock path is merely a "short" intermediate step to
> support smooth transitions to dt making the memory argument in my opinion a
> moot point :-)
>
>
> Handling the aliases directly also requires adding quit a lot more
> {MUX/DIV/...}_*A aliases for all the necessary combinations.
>
> And in general I also find the readability of separate aliases a lot better -
> as shown in the s3c2443 clk driver in the second series. And the removal once
> we only support dt will be a lot cleaner too.

True, I agree on your comments.

For this patch,
Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>

>
>
> Heiko
>
>> Instead, the optional alias passed for divider/mux register functions
>> can actually be a list of alias names, the list being terminated by a
>> zero-length string. The clock register helper functions can then loop
>> through that list and register all the aliases.
>
>
>> > +#ifdef CONFIG_OF
>> >
>> >         clk_data.clks = clk_table;
>> >         clk_data.clk_num = nr_clks;
>> >         of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>> >
>> > --
>> > 1.7.2.3
>
