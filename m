From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 18 Aug 2010 23:23:10 +0800
Subject: [alsa-devel] [PATCH 1/3] ASoC: add 88pm860x codec driver
In-Reply-To: <20100818144027.GB4588@rakim.wolfsonmicro.main>
References: <AANLkTimBPhvukwqDGY8iORhY+wg8OnHi9+eOedJB2E8k@mail.gmail.com>
	<20100818141914.GC15536@sirena.org.uk>
	<AANLkTi=2FboP+xhSHjgyoM6LfmKw1khV62gTVrkxxUHF@mail.gmail.com>
	<20100818144027.GB4588@rakim.wolfsonmicro.main>
Message-ID: <AANLkTikc+=-3Zt+iaD+UatWR-fgv4zL=xkhQH=_0Z4m8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 18, 2010 at 10:40 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 18, 2010 at 10:33:19PM +0800, Haojian Zhuang wrote:
>> On Wed, Aug 18, 2010 at 10:19 PM, Mark Brown
>
>> >
>> > I still can't follow what this automute variable is supposed to be
>> > doing. ?In both the PMU and the PMD cases you set automute, and the fact
>> > that you forcibly clear it when you apply the change means that it
>> > doesn't look like it's doing anything I'd recognise as automute,
>> > suggesting that the variable is misnamed. ?It's very difficult to follow
>> > what all this is supposed to be doing.
>
>> Mute while DAC is enabled and PGA is updated. It's the purpose of
>> anti-pop by silicon.
>
> This behaviour is entirely non-obvious from the code. ?Please improve
> the documentation within the code so that someone reading the code can
> tell what it's supposed to do. ?This will allow the code to be reviewed,
> it certainly seems buggy in relation to the DAI mute operation at the
> minute.
>
I'll add comments.

>> > As I said last time what I'd expect to see is a user visible mute
>> > control which sets a variable in the driver which is then updated in the
>> > chip only while the DAC is powered. ?The other option is to tie the
>> > control to the DAC power, in which case things should be handleable in
>> > the widget event without the variable.
>
>> Why should I move the work to invoking amixer by user? Why shouldn't
>> it be taken by driver automatically?
>
> Either of my suggestions would leave the workaround transparent to the
> user. ?The first suggestion will provide additional control to the user
> but will still hide the workaround from them.
>
I'll use another way to implement digital mute. So there won't be any
confliction.

>> >> + ? ? switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> >> + ? ? case SND_SOC_DAIFMT_CBM_CFM:
>> >> + ? ? case SND_SOC_DAIFMT_CBM_CFS:
>> >> + ? ? ? ? ? ? if (pm860x->dir == PM860X_CLK_DIR_OUT) {
>> >> + ? ? ? ? ? ? ? ? ? ? inf |= PCM_INF2_MASTER;
>> >> + ? ? ? ? ? ? ? ? ? ? ret = 0;
>
>> > This is still setting the same register value for two different DAI
>> > formats. ?You need to fix this, and in the other set_fmt() function.
>
>> These two registers are EXACTLY same. Why do I need to define two same
>> bit macro?
>
> You need to validate the arguments you're being passed. ?If your driver
> reports that it successfully set _CFS and really it set the hardware
> into _CFM then the system isn't going to work as expected.
>
>> > You're also missing a default: case.
>
>> Please check the code. If it's default case, it'll return -EINVAL. I
>> didn't miss it.
>
> No, that's not the case. ?Your error handling strategy here is
> problematic - if any one of the parameters set is correct (eg, the
> format mask sets I2S) then ret will be reset to zero and you'll return
> success.
>
OK. I can change.

>> > One other thing you should do is split the jack configuration for
>> > headphone and microphone - a system may have two physical jacks, one for
>> > each, so you should allow the user to configure the detection onto
>> > separate jacks if they want to.
>
>> Up to now, I can't split it to two different jacks. Since there's some
>> issue on mic detection.
>
> You can do this in software even if the individual board designs you're
> using don't have any separation.
>
In my system, there's only one physical jacks. It's four phased plug
(mic,left,right,gnd). So I needn't split them into two different
jacks.
