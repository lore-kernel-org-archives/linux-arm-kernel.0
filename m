From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 26 Jan 2010 19:52:45 +0900
Subject: [PATCH 3/3] ARM: SMDK64XX: Enable AC97 device
In-Reply-To: <20100126101921.GE15759@rakim.wolfsonmicro.main>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-3-git-send-email-jassisinghbrar@gmail.com>
	<20100126101921.GE15759@rakim.wolfsonmicro.main>
Message-ID: <1b68c6791001260252t7f43cb97n710381508040f7d4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 7:19 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jan 26, 2010 at 02:51:41PM +0900, jassisinghbrar at gmail.com wrote:
>> From: Jassi Brar <jassi.brar@samsung.com>
>>
>> Implementing basic support for Playback/Capture by SMDK's AC97
>> controller with WM9713 codec, this patch adds the ALSA machine
>> driver for AC97 device.
>
> Might be better to split this into an arch/arm patch and a sound/soc
> patch - they don't appear to depend on each other so it'd ease merging.
ok, will do.

>> +static int smdk_hifi_hw_params(struct snd_pcm_substream *substream,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct snd_pcm_hw_params *params)
>> +{
>> + ? ? /* CAPTURE - Stereo LineIn
>> + ? ? ?* Currently there is no other way to change ACLink-In slots
>> + ? ? ?* of Wm9713, so we make do with this call.
>> + ? ? ?*/
>> + ? ? /* Slots-3,4*/
>> + ? ? soc_ac97_ops.write(NULL, 0x5c, 0);
>> +
>> + ? ? return 0;
>> +}
>
> This one needs a bit more explanation - why are you changing the AC97
> slot? ?Is this a general problem with the S3C AC97 controller? ?It'd
> also be better to use the symbolic register name rather than a number.
It is no problem.
wm9713 can be configured to place data in one of four possible pair of slots
3-4 or 6-9 or 7-8 or 10-11. This call ensures the selected pair is 3-4(standard
and compatible with Samsung AC97 controllers). Though we don't need to
explicitly set this if we drop mic dai_link.
