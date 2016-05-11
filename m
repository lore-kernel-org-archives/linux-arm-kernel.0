From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 11 May 2016 11:46:10 +0900
Subject: [RFC PATCH 12/21] reset: uniphier: add core support for UniPhier
 reset driver
In-Reply-To: <1462888497.9155.9.camel@pengutronix.de>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
 <1462873862-30940-13-git-send-email-yamada.masahiro@socionext.com>
 <1462888497.9155.9.camel@pengutronix.de>
Message-ID: <CAK7LNASpxbW81A7YGQuAqmBdBty4BC6Z8sko8YepXOPnVqSjAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,


2016-05-10 22:54 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Dienstag, den 10.05.2016, 18:50 +0900 schrieb Masahiro Yamada:
> [...]
>> +static int uniphier_reset_update(struct reset_controller_dev *rcdev,
>> +                              unsigned long id, bool assert)
>> +{
>> +     struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
>> +     const struct uniphier_reset_data *p;
>> +     bool handled = false;
>> +
>> +     for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
>> +             unsigned int val;
>> +             int ret;
>> +
>> +             if (p->id != id)
>> +                     continue;
>> +
>> +             val = p->deassert_val;
>> +             if (assert)
>> +                     val = ~val;
>> +
>> +             ret = regmap_write_bits(priv->regmap, p->reg, p->mask, val);
>
> What is the difference between mask and deassert_val? Couldn't you just
> assign
>         val = assert ? 0 : p->mask;
> ?


I need to handle both active-high resets and active-low resets.

I thought two ways to do that.


[1] Have mask and a flag indicating active-low/active-high,
    like follows:

     if (flag & UNIPHIER_RST_ACTIVE_LOW)
          assert = !assert;
     val = assert ? 0 : p->mask;

[2] Have mask and deassert_val as in this patch




[1] cannot manage a case where one register contains
active-low bits and active-high bits mixed in it.



For example, let's say reset bits are BIT(1) and BIT(0).

[2] can solve this case as follows:

(a) If both bit1 and bit0 are active-high.
     .mask = BIT(1) | BIT(0);
     .deassert_val = 0;

(b) If bit1 is active-high and bit0 is active-low
     .mask = BIT(1) | BIT(0);
     .deassert_val =  BIT(0);

(c) If bit1 is active-low and bit0 is active-high
     .mask = BIT(1) | BIT(0);
     .deassert_val =  BIT(1);

(d) If both bit1 and bit0 are active-low
     .mask = BIT(1) | BIT(0);
     .deassert_val = BIT(1) | BIT(0);


I have not been hit by such a complicated case though.




>> +static const struct reset_control_ops uniphier_reset_ops = {
>> +     .assert = uniphier_reset_assert,
>> +     .deassert = uniphier_reset_deassert,
>> +     .status = uniphier_reset_status,
>> +};
>> +
>> +int uniphier_reset_probe(struct platform_device *pdev,
>> +                      const struct uniphier_reset_data *data)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct uniphier_reset_priv *priv;
>> +     const struct uniphier_reset_data *p;
>> +     struct regmap *regmap;
>> +     unsigned int nr_resets = 0;
>> +
>> +     /* parent should be MFD and syscon node */
>> +     regmap = syscon_node_to_regmap(dev->parent->of_node);
>> +     if (IS_ERR(regmap)) {
>> +             dev_err(dev, "failed to get regmap\n");
>
> syscon_node_to_regmap can return different error codes. It might be
> helpful to use
>         dev_err(dev, "failed to get regmap: %d\n", PTR_ERR(regmap));
> here.


OK. Will do.


-- 
Best Regards
Masahiro Yamada
