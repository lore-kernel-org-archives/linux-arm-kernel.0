From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 29 Nov 2013 15:59:02 +0100
Subject: [PATCH 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when unload
 module
In-Reply-To: <52969A50.3030601@atmel.com>
References: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
 <CACQ1gAh3W3vyTpFv8CkbO8hFJtU_SDjVuh2pRSFWCbUZPmidsw@mail.gmail.com>
 <52954739.1090501@atmel.com> <5295C4CB.2060003@gmail.com>
 <52969A50.3030601@atmel.com>
Message-ID: <5298ABB6.3030303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 28/11/2013 02:20, Bo Shen wrote:
> Hi Richard,
> 
> On 11/27/2013 06:09 PM, Richard Genoud wrote:
> 
> [Snip]
> 
>> dma dma0chan4: prep_dma_cyclic: TO DEVICE buf at 0x27950000 - 8 (65536/8192)
>> dma dma0chan4: scanned 1 descriptors on freelist
>> dma dma0chan4: scanned 1 descriptors on freelist
>> dma dma0chan4: scanned 1 descriptors on freelist
>> dma dma0chan4: scanned 1 descriptors on freelist
>> dma dma0chan4: scanned 1 descriptors on freelist
>> dma dma0chan4: scanned 1 descriptors on freelist
>> dma dma0chan4: scanned 1 descriptors on freelist
>> dma dma0chan4: scanned 1 descriptors on freelist
>> dma dma0chan4: tx_submit: started 2
>> dma dma0chan4:   channel 4 : imr = 0xff00ff, chsr = 0xff0000
>> dma dma0chan4:   channel: s0x27b3eb20 d0xf0010024
>> ctrl0x91000590:0x20200010 cfg0x100022dd l0x27981d10
>> dma dma0chan4:   channel 4 : imr = 0xff00ff, chsr = 0xff0010
>> dma dma0chan4:   channel: s0x27950010 d0xf0010024
>> ctrl0x11000008:0x20200010 cfg0x100022dd l0x27a58344
>> dma dma0chan4: issue_pending
>> [ blocks here forever (or at least a looooong time) ]
> 
> How can I reproduce this issue? Please help provide detail information
> about your operation.
> 
> On my side, I just do:
> --->8---
> while true;
> do
>     insmod snd-soc-atmel-pcm-dma.ko && insmod snd-soc-atmel_ssc_dai.ko
> && insmod snd-soc-wm8731.ko && insmod snd-soc-sam9x5-wm8731.ko;
>     amixer cset numid=14,iface=MIXER,name='Output Mixer HiFi Playback
> Switch' on;
>     aplay sample.wav;
>     rmmod snd-soc-sam9x5-wm8731.ko && rmmod snd-soc-wm8731.ko && rmmod
> snd-soc-atmel_ssc_dai.ko && rmmod snd-soc-atmel-pcm-dma.ko;
> done
> ---8<---
> 
> It works well on my side on at91sam9g35ek board, based on v3.13-rc1
Ok, it's working with your script.

I was doing:
modprobe snd-soc-wm8731
modprobe snd-soc-sam9x5-wm8731
amixer cset numid=14,iface=MIXER,name='Output Mixer HiFi Playback Switch' on
aplay sample.wav # works ok
rmmod snd-soc-sam9x5-wm8731
insmod /lib/modules/3.13.0-rc1/kernel/sound/soc/atmel/snd-soc-sam9x5-wm8731.ko
amixer cset numid=14,iface=MIXER,name='Output Mixer HiFi Playback Switch' on
aplay sample.wav # error
aplay: pcm_write:1737: write error: Input/output error

=> I wasn't unloading snd-soc-wm8731


Thanks for your time !

Richard.
