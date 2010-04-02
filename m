From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 2 Apr 2010 12:40:30 +0800
Subject: [PATCH 4/4] ASoC: enable wm8753 in aspenite
In-Reply-To: <20100401182124.GB26650@opensource.wolfsonmicro.com>
References: <s2g771cded01003310548udc9ff8b8u35736bd95038f92c@mail.gmail.com>
	<20100401182124.GB26650@opensource.wolfsonmicro.com>
Message-ID: <l2u771cded01004012140pa41dac0egc067ce7a1cbeed0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 2, 2010 at 2:21 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Mar 31, 2010 at 08:48:58AM -0400, Haojian Zhuang wrote:
>
>> +/* Seek the index of MCLK configuration table */
>> +static int pxa168_seek_mclk_conf(int rate, int format, int channel)
>> +{
>> + ? ? int i;
>> +
>> + ? ? for (i = 0; i < ARRAY_SIZE(mclk_conf); i++) {
>> + ? ? ? ? ? ? if ((mclk_conf[i].rate == rate)
>> + ? ? ? ? ? ? ? ? ? ? && (mclk_conf[i].format == format)
>> + ? ? ? ? ? ? ? ? ? ? && (mclk_conf[i].channel == channel))
>> + ? ? ? ? ? ? ? ? ? ? return i;
>> + ? ? }
>> + ? ? return -EINVAL;
>> +}
>
>> +/* Get the MCLK frequency */
>> +static int pxa168_get_mclk(int i)
>> +{
>> + ? ? if ((i < 0) || (i >= ARRAY_SIZE(mclk_conf)))
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? return mclk_conf[i].mclk;
>> +}
>
> This stuff probably shouldn't be in the machine driver since pretty much
> all machine drivers are going to want exactly the same code - it should
> be in the library code. ?Probably best to have them take hw_params
> rather than require the machine driver to decode the format, rate and
> channel since that'll save a bit of per driver boiler plate if they
> don't otherwise need that information.
>
> As I said last time ideally machine drivers shouldn't have to see this
> at all, of course.
>
This functions is used to get the sysclk. It's the parameter that is
used in hw_params() of machine driver since we need set codec and cpu
sysclock. But hw_params() of machine driver is invoked before
hw_params() of cpu_dai.

That's the main reason. If hw_params() of cpu_dai is invoked before
machine driver. This issue won't exist.
