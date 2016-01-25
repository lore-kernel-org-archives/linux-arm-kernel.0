From: rbthomas@pobox.com (Rick Thomas)
Date: Sun, 24 Jan 2016 19:26:43 -0800
Subject: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
In-Reply-To: <20160124214020.GA28667@jirafa.cyrius.com>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
 <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi>
 <20160124173701.GU3880@lunn.ch>
 <411C1DFA-3E76-42B0-866C-7C3C0D990039@pobox.com>
 <20160124214020.GA28667@jirafa.cyrius.com>
Message-ID: <8E11A1EE-D73B-462E-A493-39571A17F2C3@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jan 24, 2016, at 1:40 PM, Martin Michlmayr <tbm@cyrius.com> wrote:

> * Rick Thomas <rbthomas@pobox.com> [2016-01-24 12:56]:
>>> It would be good to have a Tested-by: from Rick.
>>> 
>> If someone will make a .deb I can download, I'll be happy to install
>> it and test it.  Please be explicit in describing what and how you
>> want tested.
> 
> Check your email. :)
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 


Got it.

Looks like mmc works with that kernel.  I was able to mount /dev/mmcblk0p1 and read files from it.

Sound we have some progress:

> root at base:~# ls -l /dev/snd
> total 0
> drwxr-xr-x 2 root root       60 Jan 24 18:23 by-path
> crw-rw---- 1 root audio 116,  2 Jan 24 18:23 controlC0
> crw-rw---- 1 root audio 116,  4 Jan 24 18:23 pcmC0D0c
> crw-rw---- 1 root audio 116,  3 Jan 24 18:23 pcmC0D0p
> crw-rw---- 1 root audio 116,  1 Jan 24 18:23 seq
> crw-rw---- 1 root audio 116, 33 Jan 24 18:23 timer
> root at base:~# cat /proc/asound/devices 
>   2: [ 0]   : control
>   3: [ 0- 0]: digital audio playback
>   4: [ 0- 0]: digital audio capture
>  33:        : timer
> root at base:~# cat /proc/asound/cards   
>  0 [i2scs42l51hifi ]: i2s-cs42l51-hif - i2s-cs42l51-hifi
>                       i2s-cs42l51-hifi

Full of hope, I did "aptitude install mp321" which went without any visible problems.

Then hooked up a pair of earphones to the "speaker" plug on the Client and ran

> root at base:~# mpg321 -v /tmp/Jersey.mp3 
> High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
> Version 0.3.2-1 (2012/03/25). Written and copyrights by Joe Drew,
> now maintained by Nanakos Chrysostomos and others.
> Uses code from various people. See 'README' for more!
> THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
> Title	: The Jersey Bounce              Artist : Zazuzaz                       
> Album	: An Evening with ZaZuZaz        Year	 : 2000
> Comment : Amazon.com Song ID: 201809221  Genre : Jazz                          
> 
> Directory: /tmp
> Playing MPEG stream from Jersey.mp3 ...
> MPEG 1.0, Layer: III, Freq: 44100, mode: Joint-Stereo, modext: 0, BPF : 2560
> Channels: 2, copyright: No, original: Yes, CRC: No, emphasis: 0.
> Bitrate: 128 Kbits/s, Extension value: 0
> Audio: 1:1 conversion, rate: 44100, encoding: signed 16 bit, channels: 2
> ALSA lib pcm.c:2267:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front
> ^C                                                                            
> [0:20] Decoding of Jersey.mp3 finished.

So it seemed to be running OK...  But there was no sound in the earphones.  I also tried adding option "-g 50" to set the gain explicitly.  Still no sound.

Is there a hardware jumper I need to set to activate sound on the OpenRD Client board?

Do I need to install another package? For example, "aptitude search '~i alsa'" gives no output, indicating, I believe, that there are no installed packages with "alsa" in their name.

The message:
> ALSA lib pcm.c:2267:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front
seems suspicious.

Any thoughts?
Rick
