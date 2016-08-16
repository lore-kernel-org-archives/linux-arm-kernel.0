From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 16 Aug 2016 13:06:03 -0700
Subject: [PATCH 17/34] clk: maxgen: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <665a9824-b0c5-9eb3-d4b6-4821204d5db0@osg.samsung.com>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-18-stephen.boyd@linaro.org>
 <CABxcv=mWdwPrGRrP7ay=2FBxzoew6yBdfjZNvgFeDGACnQZdcQ@mail.gmail.com>
 <665a9824-b0c5-9eb3-d4b6-4821204d5db0@osg.samsung.com>
Message-ID: <CAJOFmgzfvUza7DQeMsd0bD_e=+P5=WGT8kOkV7H5CCwVq4Z0RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 11:55 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> On 06/07/2016 02:50 PM, Javier Martinez Canillas wrote:
>> Hello Stephen,
>>
>> On Wed, Jun 1, 2016 at 7:15 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
>>> Now that we have clk_hw based provider APIs to register clks, we
>>> can get rid of struct clk pointers while registering clks in
>>> these drivers, allowing us to move closer to a clear split of
>>> consumer and provider clk APIs.
>>>
>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>
>> This email address doesn't exist anymore, you can use
>> javier at osg.samsung.com instead.
>>
>>> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
>>> ---
>>>
>>> See commit 58657d189a2f and it's children for details on this
>>> new registration API.
>>>
>>
>> I tried this patch on top of linux-next and my Peach Pi Chromebook
>> (that has a max77802 chip) failed to boot. Following is the relevant
>> parts from the boot log:
>>
>
> It seems the mailer did a mess with the line wrapping so here's another attempt:
>

Thanks! Found the problem too.

----8<-----
diff --git a/drivers/clk/clk-max-gen.c b/drivers/clk/clk-max-gen.c
index 4bb53fcf8639..5e8bac190698 100644
--- a/drivers/clk/clk-max-gen.c
+++ b/drivers/clk/clk-max-gen.c
@@ -169,7 +169,7 @@ int max_gen_clk_probe(struct platform_device
*pdev, struct regmap *regmap,

        if (dev->of_node) {
                ret = of_clk_add_hw_provider(dev->of_node, of_clk_max_gen_get,
-                                            max_gen_clks);
+                                            max_gen_data);
                if (ret) {
                        dev_err(dev, "failed to register OF clock provider\n");
                        return ret;
