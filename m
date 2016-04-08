From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 8 Apr 2016 10:52:57 +0900
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
In-Reply-To: <20160408003328.GA14441@codeaurora.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
Message-ID: <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


2016-04-08 9:33 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 04/05, Masahiro Yamada wrote:
>> The clk_disable() in the common clock framework (drivers/clk/clk.c)
>> returns immediately if a given clk is NULL or an error pointer.  It
>> allows clock consumers to call clk_disable() without IS_ERR_OR_NULL
>> checking if drivers are only used with the common clock framework.
>>
>> Unfortunately, NULL/error checking is missing from some of non-common
>> clk_disable() implementations.  This prevents us from completely
>> dropping NULL/error checking from callers.  Let's make it tree-wide
>> consistent by adding IS_ERR_OR_NULL(clk) to all callees.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Greg Ungerer <gerg@uclinux.org>
>> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
>> ---
>>
>> Stephen,
>>
>> This patch has been unapplied for a long time.
>>
>> Please let me know if there is something wrong with this patch.
>>
>
> I'm mostly confused why we wouldn't want to encourage people to
> call clk_disable or unprepare on a clk that's an error pointer.
> Typically an error pointer should be dealt with, instead of
> silently ignored, so why wasn't it dealt with by passing it up
> the probe() path?
>


This makes our driver programming life easier.


For example, let's see drivers/tty/serial/8250/8250_of.c


The "clock-frequency" DT property takes precedence over "clocks" property.
So, it is valid to probe the driver with a NULL pointer for info->clk.


        if (of_property_read_u32(np, "clock-frequency", &clk)) {

                /* Get clk rate through clk driver if present */
                info->clk = devm_clk_get(&ofdev->dev, NULL);
                if (IS_ERR(info->clk)) {
                        dev_warn(&ofdev->dev,
                                "clk or clock-frequency not defined\n");
                        return PTR_ERR(info->clk);
                }

                ret = clk_prepare_enable(info->clk);
                if (ret < 0)
                        return ret;

                clk = clk_get_rate(info->clk);
        }


As a result, we need to make sure the clk pointer is valid
before calling clk_disable_unprepare().


If we could support pointer checking in callees, we would be able to
clean-up lots of clock consumers.



-- 
Best Regards
Masahiro Yamada
