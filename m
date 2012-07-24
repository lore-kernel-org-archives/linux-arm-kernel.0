From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 24 Jul 2012 15:46:38 +0300
Subject: [alsa-devel] [PATCH 0/4] ASoC: fix saif record unwork issue
In-Reply-To: <1342776027-31758-1-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
Message-ID: <500E992E.6090900@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recording does not work.

On 07/20/2012 12:20 PM, Dong Aisheng wrote:
> This patch series mainly fixes the saif record unwork issue.
> The root cause consists of:
> 1) clk_prepare and clk_enable un-balanced
> 2) missed setting a proper initial clock rate for saif in dt
> 3) sgtl5000 dapm widget kcontrol does not work
>     So can not test record on mx28evk.
> 4) missed setting clkmux mode for saif in dt
>
> With this patch series it can fix sgtl5000 widget kcontrol unwork
> and saif record unwork issue.
>
> BTW, just let people konw, i still met a few overruns during record,
> that's another issue and will be fixed in separte patches later.
>
> Patch based on sound-2.6/for-3.6.

I see two different issues.


1. Recorded audio file is totally silent. Hexdump shows zeros.

2. Recording/playback after first recording gives following error 
"mxs-saif 80042000.saif: error: busy".


Please look at following logs.

Lauri




$ uname -a
Linux mx28evk 3.5.0-00004-g5b5b6fa #9 Tue Jul 24 15:21:25 EEST 2012 
armv5tejl GNU/Linux

$ arecord --version
arecord: version 1.0.25 by Jaroslav Kysela <perex@perex.cz>

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0

$ arecord -f cd test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Stereo
^CAborted by signal Interrupt...

$ hexdump -C test.wav
00000000  52 49 46 46 24 e0 0f 00  57 41 56 45 66 6d 74 20 
|RIFF$...WAVEfmt |
00000010  10 00 00 00 01 00 02 00  44 ac 00 00 10 b1 02 00 
|........D.......|
00000020  04 00 10 00 64 61 74 61  00 e0 0f 00 00 00 00 00 
|....data........|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
*
00100020

$ arecord -f cd test.wav
Recording WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Stereo
[   90.610000] mxs-saif 80042000.saif: error: busy
[   90.620000] asoc: machine hw_params failed: -16
arecord: set_params:1145: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 8
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: 0

$ aplay test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
[   98.300000] mxs-saif 80042000.saif: error: busy
[   98.310000] asoc: machine hw_params failed: -16
aplay: set_params:1145: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 8
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: 0

$ amixer
Simple mixer control 'Headphone',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 122 [96%] [9.50dB]
   Front Right: Playback 122 [96%] [9.50dB]
Simple mixer control 'Headphone Mux',0
   Capabilities: enum
   Items: 'DAC' 'LINE_IN'
   Item0: 'LINE_IN'
Simple mixer control 'Headphone Playback ZC',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'PCM',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 192
   Mono:
   Front Left: Playback 173 [90%]
   Front Right: Playback 173 [90%]
Simple mixer control 'Mic',0
   Capabilities: volume volume-joined penum
   Playback channels: Mono
   Capture channels: Mono
   Limits: 0 - 4
   Mono: 2 [50%] [30.00dB]
Simple mixer control 'Capture',0
   Capabilities: cvolume penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 15
   Front Left: Capture 14 [93%]
   Front Right: Capture 14 [93%]
Simple mixer control 'Capture Attenuate Switch (-6dB)',0
   Capabilities: volume volume-joined penum
   Playback channels: Mono
   Capture channels: Mono
   Limits: 0 - 2
   Mono: 2 [100%]
Simple mixer control 'Capture Mux',0
   Capabilities: enum
   Items: 'MIC_IN' 'LINE_IN'
   Item0: 'LINE_IN'
Simple mixer control 'Capture ZC',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
