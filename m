From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 6 Nov 2014 10:09:27 +0800
Subject: [PATCH 1/6] clk: sunxi: Add support for sun9i a80 usb clocks and
 resets
In-Reply-To: <20141105100912.GD27686@lukather>
References: <1415074039-16590-1-git-send-email-wens@csie.org>
 <1415074039-16590-2-git-send-email-wens@csie.org>
 <20141104165733.GI26729@lukather>
 <CAGb2v65VojZVEijdjXYGkMud7dMFzMzagfN=_4S3msZygu3YPQ@mail.gmail.com>
 <20141105100912.GD27686@lukather>
Message-ID: <CAGb2v64RT4PKTji2KfDTFfc8b_kiTk0Vh49nEE9ZJukum7h2_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 5, 2014 at 6:09 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Nov 05, 2014 at 06:02:35PM +0800, Chen-Yu Tsai wrote:
>> >> +static void __init sunxi_usb_clk_setup(struct device_node *node,
>> >> +                                    const struct usb_clk_data *data,
>> >> +                                    spinlock_t *lock)
>> >> +{
>> >> +     struct clk_onecell_data *clk_data;
>> >> +     struct usb_reset_data *reset_data;
>> >> +     const char *clk_parent;
>> >> +     const char *clk_name;
>> >> +     void __iomem *reg;
>> >> +     int qty;
>> >> +     int i = 0;
>> >> +     int j = 0;
>> >> +
>> >> +     reg = of_iomap(node, 0);
>> >
>> > of_io_request_and_map?
>>
>> OK. About that, any recommended naming style for the 3rd argument?
>> Maybe the driver name "clk_sun9i_usb"? Or just a generic name like
>> "usb_clk"?
>>
>> I'm asking now as we'll likely be changing the existing drivers to
>> use it as well.
>
> I don't really have a preference. Maybe the DT node name would be both
> the easier and better solution.

Using of_node_full_name() then.

> [...]
>
>> >> +static void __init sun9i_a80_usb_mod_setup(struct device_node *node)
>> >> +{
>> >> +     /* AHB1 gate must be enabled to access registers */
>> >> +     struct clk *ahb = of_clk_get(node, 0);
>> >> +
>> >> +     WARN_ON(IS_ERR(ahb));
>> >> +     clk_prepare_enable(ahb);
>> >
>> > Hmmmm. That look off.
>> >
>> > Why do you need the clock to be enabled all the time? Isn't the CCF
>> > already taking care of enabling the parent clock whenever it needs to
>> > access any register?
>>
>> There are also resets in the same block. That and I couldn't get it
>> working without enabling the clock beforehand.
>
> Ah, right.
>
> What happens if you just enable and disable the clocks in the
> reset_assert and reset_deassert right before and after accessing the
> registers?

That doesn't work either. I forgot to mention that most of the clock
gates have the peripheral pll as their parent, not the ahb clock gate.

Since most of the clocks are special clocks @ 12M, 48M, or 480M, which
on previous SoCs were driven by PLL6 or another special PLL, it seems
to make sense to assume the same on A80 and set them this way.

ChenYu
