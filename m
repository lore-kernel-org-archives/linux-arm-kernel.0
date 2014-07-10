From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Thu, 10 Jul 2014 00:41:03 -0300
Subject: GSoC 2014 #0 status report - Improving Allwinner SoC support
Message-ID: <53BE0B4F.1090001@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

As some of you may know, I'm currently participating in Google Summer of 
Code under the Linux Foundation, working on a proposal titled "Improve 
Allwinner SoCs support on mainline Linux". There is a great quantity of 
devices out there that are powered by Allwinner processors, including 
but not limited to the various Cubieboards, OLinuXinos, STBs, Tablets 
and ?Mini PCs?. However, to date, support on mainline Linux is not yet 
feature complete. My proposal on particular focuses on DMA and analog 
audio on the earlier SoCs, and improved A23 support.

The idea here is to make a weekly status report of the project. As we 
are starting mid-program, this one will be a bit different and I'll 
outline what has been worked on so far since the beginning.

To date, I have been mainly working on the DMA driver for sun4i, sun5i 
and sun7i. Despite having completely different drivers on SDK kernels, 
the hardware block looks and behaves the same, so we are using a single 
driver for these three SoC families. I have sent a series of patches[1] 
as well as a follow-up v2[2], and I will keep iterating over it until 
it's accepted. I have also sent two trivial patches[3][4] as a side-effect.

The main challenges while writing this driver can be summarized as a 
lack of documentation. First of all, it took me a bit to get to know 
DMAEngine. As there is not much documentation on it, most of my learning 
took place by reading pre-existing drivers and consulting with my 
mentor. Secondly, as the Allwinner documentation is mostly a register 
list with bitfield details, I also had to read the SDK drivers and do 
some trial and error testing to discover magic values and understand others.

Lately, I have also been working on the audio part, now that I have a 
working DMA driver. After implementing cyclic DMA transfers and some 
clock code, and armed with a Buildroot image with mpg123 and an OpenBSD 
release track[5] in mp3 format, I've been trying to get some sound out 
of my Cubietruck's headphone jack, but without much success so far. I 
have verified my userspace stack and hardware by running these same 
binaries on top of the linux-sunxi 3.4 kernel, and it worked fine. I 
have since then been dumping relevant registers with devmem and 
comparing them, resolving issues as I see them - hopefully this will 
yield some audible results.

Interestingly enough, Allwinner themselves do not seem to be using 
cyclic DMA transfers on their driver[6]. I hope this is not a sign of a 
hardware bug that's not documented.

To give some closure to this status report, I'd like to thank Maxime for 
his mentoring so far, Ezequiel for letting me pick his brain, and the 
Linux Foundation and Google for giving me this opportunity, as well as 
everyone on the kernel and sunxi communities who have come forward to 
review and test patches. You can expect a new report soon, in about a 
week's time or less.

Emilio

[1] http://www.spinics.net/lists/dmaengine/msg01148.html
[2] http://www.spinics.net/lists/arm-kernel/msg344766.html
[3] https://lkml.org/lkml/2014/5/11/166
[4] https://lkml.org/lkml/2014/7/1/486
[5] http://www.openbsd.org/lyrics.html, maybe I should consider using 
some other song for better luck
[6] 
https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/sound/soc/sunxi/sunxi-codec.c#L1137
