From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 24 Feb 2015 22:54:31 +0100
Subject: Ask for help. ARM:mvebu (CM-A510),
 add sound support using TLV320AIC23 audio-codec
In-Reply-To: <54ECEA1D.6090306@gmail.com>
References: <54EB8D34.7040003@gmail.com> <54EC3956.4070505@gmail.com>
 <54ECEA1D.6090306@gmail.com>
Message-ID: <54ECF317.10603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.02.2015 22:16, Gabriel Dobato wrote:
>> Looking at sound/soc/codecs/tlv320aic23.c:
>>
>> static const struct snd_soc_dapm_route tlv320aic23_intercon[] = {
>>     /* Output Mixer */
>>     {"Output Mixer", "Line Bypass Switch", "Line Input"},
>>     {"Output Mixer", "Playback Switch", "DAC"},
>>     {"Output Mixer", "Mic Sidetone Switch", "Mic Input"},
>>
>>     /* Outputs */
>>     {"RHPOUT", NULL, "Output Mixer"},
>>     {"LHPOUT", NULL, "Output Mixer"},
>>     {"LOUT", NULL, "Output Mixer"},
>>     {"ROUT", NULL, "Output Mixer"},
>>
>>     /* Inputs */
>>     {"Line Input", "NULL", "LLINEIN"},
>>     {"Line Input", "NULL", "RLINEIN"},
>>
>>     {"Mic Input", "NULL", "MICIN"},
>>
>>     /* input mux */
>>     {"Capture Source", "Line", "Line Input"},
>>     {"Capture Source", "Mic", "Mic Input"},
>>     {"ADC", NULL, "Capture Source"},
>>
>> };
>>
>> The lines with the failing routes really look suspicious, i.e.
>> there is strings "NULL" where I'd expect plain NULL.
>>
> You were right, as always :) , I have changed them and now errors are
> not reported. Now, in the boot trace I find:

Mind to send a proper patch fixing the above? Make sure you run
./scripts/checkpatch.pl and ./scripts/get_maintainer.pl on the
patch. It should give you an idea of proper code style and what
people/lists to send it to. I am sure, google will help you with
how to prepare proper kernel patches, too.

> but after rootfs is up, this msg appears in dmesg:
>
> platform sound: Driver asoc-simple-card requests probe deferral

This is, as always, a missing dependency of simple-card node.

Either you are missing drivers for Dove audio (kirkwood-i2s) or
one of the drivers involved in your simple-card fails.

Look for errors in your dmesg output - also please name the
kernel version you are working with. There have been some changes
in clk handling that break a bunch of drivers in 4.0-rc1.

Sebastian
