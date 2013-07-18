From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Jul 2013 13:43:30 +0200
Subject: Audio issue on Kirkwood t5325: no sound
Message-ID: <20130718134330.5aea00c5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As part of some work around audio support on Marvell platforms, I've
taken the Kirkwood-based HP t5325 thin client device that Martin
Michlmayr kindly gave me and tried to use the audio part of it, with
kernel 3.11-rc1. (My plan is to write the Device Tree binding for this
audio driver, and then use it for Armada 370 based platforms).

My kernel configuration has the following options enabled:

CONFIG_SND_SOC=y
CONFIG_SND_KIRKWOOD_SOC=y
CONFIG_SND_KIRKWOOD_SOC_I2S=y
CONFIG_SND_KIRKWOOD_SOC_OPENRD=y
CONFIG_SND_KIRKWOOD_SOC_T5325=y
CONFIG_SND_SOC_I2C_AND_SPI=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_CS42L51=y

So both the Kirkwood audio driver is enabled, the t5325-specific
machine audio driver, and the ALC5623 codec. When booting, the system
says:

t5325-audio t5325-audio:  alc5621-hifi <-> kirkwood-i2s mapping ok
[...]
ALSA device list:
  #0: t5325

I can actually use aplay to play a sound, it plays fine, except that
nothing goes out on the headphone jack, as if it was muted:

# aplay sensation.wav 
Playing WAVE 'sensation.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
#

I've unmuted all volume controls, and pushed all of them to the max
value, as can be seen from the following amixer output:

# amixer 
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Speaker Mix AUXI2SPK',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Speaker Mix DAC2SPK',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Speaker Mix LI2SPK',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Speaker Mix MIC12SPK',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Speaker Mix MIC22SPK',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'SpeakerOut Mux',0
  Capabilities: enum
  Items: 'Vmid' 'HPOut Mix' 'Speaker Mix' 'Mono Mix'
  Item0: 'Vmid'
Simple mixer control 'SpeakerOut N Mux',0
  Capabilities: enum
  Items: 'RN/-R' 'RP/+R' 'LN/-R' 'Vmid'
  Item0: 'Vmid'
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [12.00dB]
  Front Right: Playback 31 [100%] [12.00dB]
Simple mixer control 'LineIn',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 31 [100%] [12.00dB]
  Front Right: Capture 31 [100%] [12.00dB]
Simple mixer control 'Mic 1 Boost',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 2
  Mono: 0 [0%] [0.00dB]
Simple mixer control 'Mic 2 Boost',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 2
  Mono: 0 [0%] [0.00dB]
Simple mixer control 'Mic1',0
  Capabilities: cvolume cvolume-joined
  Capture channels: Mono
  Limits: Capture 0 - 31
  Mono: Capture 23 [74%] [0.00dB]
Simple mixer control 'Mic2',0
  Capabilities: cvolume cvolume-joined
  Capture channels: Mono
  Limits: Capture 0 - 31
  Mono: Capture 23 [74%] [0.00dB]
Simple mixer control 'AuxI',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 23 [74%] [0.00dB]
  Front Right: Capture 23 [74%] [0.00dB]
Simple mixer control 'AuxOut Mux',0
  Capabilities: enum
  Items: 'Vmid' 'HPOut Mix' 'Speaker Mix' 'Mono Mix'
  Item0: 'Vmid'
Simple mixer control 'Auxout',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Mono Mix ADC2MONO_L',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mono Mix ADC2MONO_R',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mono Mix AUXI2MONO',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mono Mix DAC2MONO',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mono Mix LI2MONO',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mono Mix MIC12MONO',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mono Mix MIC22MONO',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'AB-D Amp Mux',0
  Capabilities: enum
  Items: 'AB Amp' 'D Amp'
  Item0: 'AB Amp'
Simple mixer control 'Digital Boost',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%] [18.00dB]
Simple mixer control 'HP Mix AUXI2HP',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HP Mix DAC2HP',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HP Mix LI2HP',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HP Mix MIC12HP',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HP Mix MIC22HP',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HPL Mix ADC2HP_L',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'HPR Mix ADC2HP_R',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Left Capture Mix HPMixerL',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Left Capture Mix Left AuxI',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Left Capture Mix LineInL',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Left Capture Mix Mic1',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Left Capture Mix Mic2',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Left Capture Mix MonoMixer',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Left Capture Mix SPKMixer',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Left Headphone Mux',0
  Capabilities: enum
  Items: 'Vmid' 'HP Left Mix'
  Item0: 'Vmid'
Simple mixer control 'Rec',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 11 [35%] [0.00dB]
  Front Right: Capture 11 [35%] [0.00dB]
Simple mixer control 'Right Capture Mix HPMixerR',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Right Capture Mix LineInR',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Right Capture Mix Mic1',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Right Capture Mix Mic2',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Right Capture Mix MonoMixer',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Right Capture Mix Right AuxI',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Right Capture Mix SPKMixer',0
  Capabilities: cswitch cswitch-joined
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'Right Headphone Mux',0
  Capabilities: enum
  Items: 'Vmid' 'HP Right Mix'
  Item0: 'Vmid'

There are no kernel errors in the log, nothing that looks suspicious.
Is there anything I've missed?

I've posted the complete kernel configuration at:
 http://free-electrons.com/~thomas/pub/kirkwood-audio-kernel.config

And the complete kernel log at:
 http://free-electrons.com/~thomas/pub/kirkwood-audio-kernel.log

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
