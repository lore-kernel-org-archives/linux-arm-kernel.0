From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 30 May 2012 15:47:26 +0800
Subject: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
Message-ID: <CAJuYYwQ-9hUxhrJpGwd6CvcEbwu_DbKt5+PvgExn4i2Rcw+yJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2012 15:28, Olof Johansson <olof@lixom.net> wrote:
> On Sun, May 20, 2012 at 2:21 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Fri, May 18, 2012 at 03:03:31PM +0530, Thomas Abraham wrote:
>>
>>> - ? ? s3c64xx_spi0_set_platdata(&s3c64xx_spi0_pdata, 0, 1);
>>> + ? ? s3c64xx_spi0_set_platdata("s3c6410-spi", NULL, 0, 1);
>>
>> ...
>>
>>> + ? ? pd.src_clk_nr = src_clk_nr;
>>> + ? ? pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
>>> + ? ? s3c64xx_device_spi0.name = dev_name;
>>
>> This looks *really* strange. ?Why do we need to pass in a name to set in
>> s3c64xx_device_spi0's name, why would we want to use a different name?
>> This dev_name also isn't equivalent to dev_name() which makes matters
>> more confusing than they need to be.
>>
>> There was similar code for the I2C controllers which caused some really
>> hard to debug brittleness.
>
> Looks like they use the name as the magic string to pick initialization data.
>
> I wonder if it makes more sense to keep the platform_data still
> around, and just fill it in with the table (from patch "spi: s3c64xx:
> move controller information into driver data") based on the OF
> compatible field for the device-tree probe case, instead of trying to
> overload and having to change the name in this way.

Ok. Thanks for your suggestion. So for now, the spi controller
configuration data will be left in platform data for non-dt platforms
and allow dt-platforms to have this data as part of the driver (and
picked up based on the compatible value).

Thanks,
Thomas.

>
>
> -Olof
