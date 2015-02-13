From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 13 Feb 2015 22:22:02 +0900
Subject: [PATCH 02/13] clk: mediatek: Add initial common clock support for
 Mediatek SoCs.
In-Reply-To: <20150213120613.GZ12209@pengutronix.de>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-3-git-send-email-s.hauer@pengutronix.de>
 <CAAFQd5APGYRSQzriBBB=-vDyMhQZe7k9zDPgxLwzcV2C6f9DJQ@mail.gmail.com>
 <20150213120613.GZ12209@pengutronix.de>
Message-ID: <CAAFQd5BxYNjsVpJnS+t=kZdXSdBTpgJii=T_qadRmMEzrR=dng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, Feb 13, 2015 at 9:06 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Hi Tomasz,
>
>> > +static void mtk_cg_disable(struct clk_hw *hw)
>> > +{
>> > +       mtk_cg_set_bit(hw);
>> > +}
>> > +
>> > +static int mtk_cg_enable_inv(struct clk_hw *hw)
>> > +{
>> > +       mtk_cg_set_bit(hw);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static void mtk_cg_disable_inv(struct clk_hw *hw)
>> > +{
>> > +       mtk_cg_clr_bit(hw);
>> > +}
>>
>> Instead of duplicating the ops, couldn't you add a flag or something
>> to mtk_clk_gate struct and then act appropriately in the ops? Also,
>> see below.
>
> I prefer duplicating the ops. It makes the functions simpler without
> ifs.

I meant something else. Compared to ifs I'd prefer duplicated ops too.

is_enabled()
{
    status = regmap_read() ^ (inverted << shift);
    return status & BIT(shift);
}

However I missed the fact that writing uses set and clear registers,
which effectively means that this approach can't really be used for
writing, so I'm okay with keeping this as is.

>
>> > diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
>> > new file mode 100644
>> > index 0000000..a44dcbf
>> > --- /dev/null
>> > +++ b/drivers/clk/mediatek/clk-gate.h
>> > @@ -0,0 +1,49 @@
>> > +/*
>> > + * Copyright (c) 2014 MediaTek Inc.
>> > + * Author: James Liao <jamesjj.liao@mediatek.com>
>>
>> Might not be necessary, but maybe the other people (all or some of
>> them) from signed-off-by should be added to this and other copyright
>> statements?
>
> I rather do not want to update these copyrights frequently. Otherwise we
> would see a lot of patches with an extra hunk changing the copyrights.
> I'm glad we left that behind and look at the git history instead.
> The above is the original author. I don't want to remove him, but I also
> do not want to add every other person who touched that file.

Alright. I just wanted to make sure that this is desired state.

>
> The other stuff will be fixed in the next round. Thanks for reviewing.

You're welcome. Looking forward for next revision.

Best regards,
Tomasz
