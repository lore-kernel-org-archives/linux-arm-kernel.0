From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Tue, 03 Feb 2015 19:47:15 -0300
Subject: [linux-sunxi] Re: [PATCH v4] dma: sun4i: Add support for the
 DMA engine on sun[457]i SoCs
In-Reply-To: <54D12D25.5000408@elopez.com.ar>
References: <1422745124-22103-1-git-send-email-emilio@elopez.com.ar>	<1422745124-22103-2-git-send-email-emilio@elopez.com.ar>	<1422785038.28275.34.camel@plaes.org>	<54D116D4.3030004@elopez.com.ar>
 <CAKON4Oydvex28FsYsHOr3Cv9othhUqu=xOEuLPMcisLPtc1imA@mail.gmail.com>
 <54D12D25.5000408@elopez.com.ar>
Message-ID: <54D14FF3.2030005@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 03/02/15 a las 17:18, Emilio L?pez escibi?:
> Hi,
>
> El 03/02/15 a las 16:39, jonsmirl at gmail.com escibi?:
>> Did you fix multiple simultaneous DMA transfers in this? And easy test
>> is to start jack audio. Jack will start simultaneous cyclic transfers
>> on both the ALSA input and output. Since cyclic transfers never end,
>> multiple simultaneous transfers has to work. Last time I tried it I
>> got an immediate GPF when the second cyclic transfer was started.
>
> I didn't get a chance to test with jack yet, but I don't see any reason
> why two cyclic transfers wouldn't work, assuming they're on different
> vchans.
>
> Were you by any chance booting off of NAND by the way? That caused a GPF
> because the bootloader left the hardware in a dirty state, but it should
> be fixed now.

A quick followup on this; I tried jack and found a bug on the way 
channels are terminated, it turns out sometimes IRQs can still trigger 
after the termination. Once I fixed that, I was able to get jack to 
produce a deafening tone with the following:

# jackd -dalsa --playback &
# jackdmp 1.9.10
Copyright 2001-2005 Paul Davis and others.
Copyright 2004-2014 Grame.
jackdmp comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK server starting in realtime mode with priority 10
self-connect-mode is "Don't restrict self connect requests"
creating alsa driver ... hw:0|-|1024|2|48000|0|0|nomon|swmeter|-|32bit
configuring for 48000Hz, period = 1024 frames (21.3 ms), buffer = 2 periods
ALSA: final selected sample format for playback: 32bit integer little-endian
ALSA: use 2 periods for playback
# jack_simple_client
