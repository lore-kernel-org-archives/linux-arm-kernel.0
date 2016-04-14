From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 14 Apr 2016 10:49:43 +0900
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
In-Reply-To: <20160414003341.GH14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
 <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
 <20160414003341.GH14441@codeaurora.org>
Message-ID: <CAK7LNARbzRLq_NGWJ8CFBBf6w4cVGCNh45fo6JO=+F7FACBSxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


2016-04-14 9:33 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 04/08, Masahiro Yamada wrote:
>>
>>
>> This makes our driver programming life easier.
>>
>>
>> For example, let's see drivers/tty/serial/8250/8250_of.c
>>
>>
>> The "clock-frequency" DT property takes precedence over "clocks" property.
>> So, it is valid to probe the driver with a NULL pointer for info->clk.
>>
>>
>>         if (of_property_read_u32(np, "clock-frequency", &clk)) {
>>
>>                 /* Get clk rate through clk driver if present */
>>                 info->clk = devm_clk_get(&ofdev->dev, NULL);
>>                 if (IS_ERR(info->clk)) {
>>                         dev_warn(&ofdev->dev,
>>                                 "clk or clock-frequency not defined\n");
>>                         return PTR_ERR(info->clk);
>>                 }
>>
>>                 ret = clk_prepare_enable(info->clk);
>>                 if (ret < 0)
>>                         return ret;
>>
>>                 clk = clk_get_rate(info->clk);
>>         }
>>
>>
>> As a result, we need to make sure the clk pointer is valid
>> before calling clk_disable_unprepare().
>>
>>
>> If we could support pointer checking in callees, we would be able to
>> clean-up lots of clock consumers.
>>
>>
>
> I'm not sure if you meant to use that example for the error
> pointer case? It bails out if clk_get() returns an error pointer.
>
> I'm all for a no-op in clk_disable()/unprepare() when the pointer
> is NULL. But when it's an error pointer the driver should be
> handling it and bail out before it would ever call enable/prepare
> on it or disable/unprepare.



Let me explain my original idea.

We do various initialization in a probe method,
so we (OK, I) sometimes want to split init code
into some helper function(s) like this:


static int foo_clk_init(struct platform_device *pdev,
                        struct foo_priv *priv)
{
        int ret;

        priv->clk = devm_clk_get(&pdev->dev, NULL);     /* case 1 */
        if (IS_ERR(priv->clk)) {
                 dev_err(&pdev->dev, "falied to get clk\n");
                 return PTR_ERR(priv->clk);
        }

        ret = clk_prepare_enable(priv->clk);          /* case 2 */
        if (ret < 0) {
                 dev_err(&pdev->dev, "falied to enable clk\n");
                 return ret;
        }

        priv->clk_rate = clk_get_rate(priv->clk);    /* case 3 */
        if (!priv->clk_rate) {
                  dev_err(&pdev->dev, "clk rate should not be zero\n");
                  return -EINVAL;
        }


        [ do something ]

        return 0;
}


static int foo_probe(struct platform_device *pdev)
{
        [memory allocation, OF parse, various init.... ]

        ret = foo_clk_init(pdev, priv);
        if (ret < 0)
                goto err;

        ret = foo_blahblah_init(pdev, priv)          /* case 4 */
        ir (ret < 0)
                goto err;

        [  more initialization ... ]

        return 0;
err:
        clk_disable_unprepare(priv->clk);

        return ret;
}


There are some failure paths in this example.

 [1] If case 1 fails, priv->clk contains an error pointer.
     We should not do clk_disable_unprepare().
 [2] If case 2 fails, priv->clk contains a valid pointer,
     but we should not do clk_disable_unprepare().
 [3] If case 3 fails, priv->clk contains a valid pointer,
     and we should do clk_disable_unprepare().
 [4] If case 4 fails, priv->clk contains a valid pointer,
     and we should do clk_disable_unprepare().


My difficulty is that [1]-[3] are contained in one helper function.
(A real example is drivers/i2c/busses/i2c-uniphier.c)


If foo_clk_init() fails for reason [1],
I want clk_disable_unprepare() to just return.
(This is my original intention of this patch.)

If foo_clk_init() fails for reason [3],
I want clk_disable_unprepare() to do its job.


OK, now I notice another problem in my code;
if foo_clk_init() fails for reason [2],
clk_disable() WARN's due to zero enable_count.

if (WARN_ON(core->enable_count == 0))
         return;



Perhaps, I got screwed up by splitting clock init stuff
into a helper function.



-- 
Best Regards
Masahiro Yamada
