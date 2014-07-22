From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 22 Jul 2014 18:22:15 +0800
Subject: [linux-sunxi] GSoC 2014 #1 status report - Improving Allwinner
 SoC support
In-Reply-To: <CAGb2v67YZVnY1869uau_R7MGKGW2EeS2P0qtN0TX_0Uan-aRNw@mail.gmail.com>
References: <53BE0B4F.1090001@elopez.com.ar> <53CAC9ED.9080302@elopez.com.ar>
 <CAGb2v67YZVnY1869uau_R7MGKGW2EeS2P0qtN0TX_0Uan-aRNw@mail.gmail.com>
Message-ID: <CAGb2v679RqNj4FhT=T5Wx64My6ckDD0Eeq_5aVPh6zz9ei8+rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 12:18 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi Emilio,
>
> On Sun, Jul 20, 2014 at 3:41 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
>> Hi everyone,
>>
>> Here's this week's update on my GSoC project; if you missed the first issue
>> or you want a refresher of what this is about, you can read it on the list
>> archives[0]
>>
>> A couple of days after the last report, and with the help of Jon Smirl, I
>> got the hardware working on mainline Linux, first on only 16 bit stereo
>> mode, then mono as well, and later on, also on 24 bit mode. The first thing
>> I had to do was rework the cyclic DMA code to make it perform decently and
>> avoid underruns. The rest took a bit of playing with values and reading the
>> Allwinner documentation. There is one unresolved issue with 24 bit audio
>> still - for some reason, the volume is really low compared to the same track
>> played on 16 bit. Unfortunately the SDK driver doesn't support 24 bit, so
>> it's hard to compare with anything else.
>
> So I have not experimented on this, it's just a hunch:
> Could it be that the 24bit audio samples you're sending to the audio codec
> is aligned incorrectly? So the sample is actually seen as down-shifted by
> 8 bits, resulting in the low volume?

So the user manual says that 24 bit samples should be right justified,
or in the most significant bytes. The way to do it in ASoC is to declare
support 32 bit, instead of 24 bit, audio, and also set .sig_bits to 24.

See: http://www.spinics.net/lists/alsa-devel/msg40846.html

This makes ALSA send 32bit data, and the hardware will drop the lower 8
bits. S24_LE denotes 24bit in the lower bits, and thus we cannot use it.

However, there is something puzzling about the FIFO modes. The manual
says that with TX FIFO modes 00/10, 16 bit audio should take the most
significant 2 bytes of the FIFO as the audio sample to convert. However
the DMA engine looks like it's writing the least significant 2 bytes.
I know the code as it is now works, but still I think we should get
this straightened out.

As a side note, the code still needs some cleaning up. I see some
duplicate codec/dais.

> I'll grab your tree and test 24bit tomorrow. (Good thing I have 24 bit
> music files.) :)

I now have my CubieTruck singing nicely with 24 bit music. Either the
player or ALSA will extend the 24 bits to 32 bits. The only downside
is you cannot specify S24_LE when streaming directly to the hardware
device.


Cheers
ChenYu

>> Aside from the audio stuff, I worked a bit on the DMA driver, after
>> realizing memcpy could be optimized a fair bit. By using proper alignment
>> and choosing the best bus width and as big a burst as possible, I was able
>> to go from a totally unscientifically measured ~3MB/s to ~13MB/s on a single
>> thread, single channel, 1000 iterations dmatest run with noverify=0. I will
>> be sending a v3 with these new changes as well as addressing comments I
>> received in the next few days.
>
> This still seems quite slow? I think there was a discussion about this
> on IRC, you included? Any followups there?
>
>> To round up on this week's developments, I also worked on the audio clock
>> representation, involving PLL2, the codec clock gate and "module 1" clocks
>> (AC97, SPDIF, IIS) to enable Jon to work on IIS. Patches for these clocks
>> will be out in the list soon as well.
>
> Thanks! I look forward to them.
>
>
> Cheers
> ChenYu
>
>> You can expect the next status report in about a week's time.
>>
>> Cheers!
>>
>> Emilio
>>
>> [0]
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/271150.html
