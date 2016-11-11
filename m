From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Nov 2016 21:57:05 +0800
Subject: [PATCH v3 2/3] pinctrl: sunxi: Add support for fetching pinconf
 settings from hardware
In-Reply-To: <20161111135159.zqjqjjn7azg4gkzx@lukather>
References: <20161111095036.11803-1-wens@csie.org>
 <20161111095036.11803-3-wens@csie.org>
 <20161111135159.zqjqjjn7azg4gkzx@lukather>
Message-ID: <CAGb2v669W-mVDxV112r99b-g6bniRJt-wV8pTRRLAbJ2ZRyMUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 9:51 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Nov 11, 2016 at 05:50:35PM +0800, Chen-Yu Tsai wrote:
>> The sunxi pinctrl driver only caches whatever pinconf setting was last
>> set on a given pingroup. This is not particularly helpful, nor is it
>> correct.
>>
>> Fix this by actually reading the hardware registers and returning
>> the correct results or error codes. Also filter out unsupported
>> pinconf settings. Since this driver has a peculiar setup of 1 pin
>> per group, we can support both pin and pingroup pinconf setting
>> read back with the same code. The sunxi_pconf_reg helper and code
>> structure is inspired by pinctrl-msm.
>>
>> With this done we can also claim to support generic pinconf, by
>> setting .is_generic = true in pinconf_ops.
>>
>> Also remove the cached config value. The behavior of this was never
>> correct, as it only cached 1 setting instead of all of them. Since
>> we can now read back settings directly from the hardware, it is no
>> longer required.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 86 +++++++++++++++++++++++++++++++++--
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 -
>>  2 files changed, 81 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index e04edda8629d..ed71bff39869 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -438,15 +438,91 @@ static const struct pinctrl_ops sunxi_pctrl_ops = {
>>       .get_group_pins         = sunxi_pctrl_get_group_pins,
>>  };
>>
>> +static int sunxi_pconf_reg(unsigned pin, enum pin_config_param param,
>
> Sorry, this went unnoticed in your previous version, but checkpatch
> reports:
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>
> For this one and the next function.

I know, but the function pointer definition in pinconf.h says
'unsigned', not 'unsigned int'.

Having a mismatch between the two is even more confusing...

ChenYu

>
> Once fixed,
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
