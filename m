From: dobatog@gmail.com (Gabriel Dobato)
Date: Tue, 24 Feb 2015 22:16:13 +0100
Subject: Ask for help. ARM:mvebu (CM-A510),
 add sound support using TLV320AIC23 audio-codec
In-Reply-To: <54EC3956.4070505@gmail.com>
References: <54EB8D34.7040003@gmail.com> <54EC3956.4070505@gmail.com>
Message-ID: <54ECEA1D.6090306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think that the lack of space in all three input routings can make a
> difference. Please let know if adding it helps.
>
> Best regards,
> Marcin

Marcin,

Thank you for your answer!. It seems that space does not matter (I have 
checked it), but yes, it is necessary to be careful with this kind of 
things..


On 24/02/15 09:41, Sebastian Hesselbarth wrote:
> The full node looks like:
> opt_audio: audio at 1a {
>      compatible = "ti,tlv320aic23";
>      reg = <0x1a>;
>      #sound-dai-cells= <0>;
>      status = "okay";
> };

Yes, sorry. And regarding to audio0, the full node looks like:

                         audio0: audio-controller at b0000 {
                                 compatible = "marvell,dove-audio";
                                 reg = <0xb0000 0x2210>;
                                 interrupts = <19>, <20>;
                                 clocks = <&gate_clk 12>;
                                 clock-names = "internal";
                                 #sound-dai-cells= <1>;
                                 status = "okay";
                         };

> Looking at sound/soc/codecs/tlv320aic23.c:
>
> static const struct snd_soc_dapm_route tlv320aic23_intercon[] = {
>     /* Output Mixer */
>     {"Output Mixer", "Line Bypass Switch", "Line Input"},
>     {"Output Mixer", "Playback Switch", "DAC"},
>     {"Output Mixer", "Mic Sidetone Switch", "Mic Input"},
>
>     /* Outputs */
>     {"RHPOUT", NULL, "Output Mixer"},
>     {"LHPOUT", NULL, "Output Mixer"},
>     {"LOUT", NULL, "Output Mixer"},
>     {"ROUT", NULL, "Output Mixer"},
>
>     /* Inputs */
>     {"Line Input", "NULL", "LLINEIN"},
>     {"Line Input", "NULL", "RLINEIN"},
>
>     {"Mic Input", "NULL", "MICIN"},
>
>     /* input mux */
>     {"Capture Source", "Line", "Line Input"},
>     {"Capture Source", "Mic", "Mic Input"},
>     {"ADC", NULL, "Capture Source"},
>
> };
>
> The lines with the failing routes really look suspicious, i.e.
> there is strings "NULL" where I'd expect plain NULL.
>
> What happens if you amend the three lines and replace the "NULL"
> with NULL?
>
> Sebastian

Sebastian,

You were right, as always :) , I have changed them and now errors are 
not reported. Now, in the boot trace I find:

...
asoc-simple-card sound: tlv320aic23-hifi <-> i2s mapping ok
...

...
ALSA device list:
   #0: OnboardTLV320AIC23B
...

but after rootfs is up, this msg appears in dmesg:

platform sound: Driver asoc-simple-card requests probe deferral



In reference to the card, I get the following info:

root at 192:~#cat /proc/asound/cards
  0 [OnboardTLV320AI]: OnboardTLV320AI - OnboardTLV320AIC23B
                       OnboardTLV320AIC23B

root at 192:~# tree /proc/asound/card0/
/proc/asound/card0/
|-- id
|-- pcm0c
|   |-- info
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- status
|       `-- sw_params
`-- pcm0p
     |-- info
     `-- sub0
         |-- hw_params
         |-- info
         |-- status
         `-- sw_params

4 directories, 11 files



And if I try to reproduce some noise:

root at 192:~#  cat /dev/urandom | aplay
Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
set_sample_rate_control:Invalid rate 48000,48000 requested
tlv320aic23-codec 1-001a: ASoC: can't set tlv320aic23-hifi hw params: -22
aplay: set_params:1145: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 8000
PERIOD_TIME: (125333 125334)
PERIOD_SIZE: (1002 1003)
PERIOD_BYTES: (1002 1003)
PERIODS: (3 4)
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 4000
TICK_TIME: 0


Gabriel
