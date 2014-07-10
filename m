From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Thu, 10 Jul 2014 18:40:42 -0400
Subject: [linux-sunxi] Re: GSoC 2014 #0 status report - Improving
 Allwinner SoC support
In-Reply-To: <20140710203906.GA3745@lukather>
References: <53BE0B4F.1090001@elopez.com.ar> <20140710203906.GA3745@lukather>
Message-ID: <CAKON4Ow8m07sLXnnm3n6HNh3sg0nU6VDAZ0urZ0r2_6nT7UnHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 4:39 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Jul 10, 2014 at 12:41:03AM -0300, Emilio L?pez wrote:
>> Hi everyone,
>>
>> As some of you may know, I'm currently participating in Google
>> Summer of Code under the Linux Foundation, working on a proposal
>> titled "Improve Allwinner SoCs support on mainline Linux". There is
>> a great quantity of devices out there that are powered by Allwinner
>> processors, including but not limited to the various Cubieboards,
>> OLinuXinos, STBs, Tablets and ?Mini PCs?. However, to date, support
>> on mainline Linux is not yet feature complete. My proposal on
>> particular focuses on DMA and analog audio on the earlier SoCs, and
>> improved A23 support.
>>
>> The idea here is to make a weekly status report of the project. As
>> we are starting mid-program, this one will be a bit different and
>> I'll outline what has been worked on so far since the beginning.
>>
>> To date, I have been mainly working on the DMA driver for sun4i,
>> sun5i and sun7i. Despite having completely different drivers on SDK
>> kernels, the hardware block looks and behaves the same, so we are
>> using a single driver for these three SoC families. I have sent a
>> series of patches[1] as well as a follow-up v2[2], and I will keep
>> iterating over it until it's accepted. I have also sent two trivial
>> patches[3][4] as a side-effect.
>
> Yep, thanks a lot for that good work.
>
> Hopefully, it will be merged rather soon, as it looks quite nice
> already.
>
>> The main challenges while writing this driver can be summarized as a
>> lack of documentation. First of all, it took me a bit to get to know
>> DMAEngine. As there is not much documentation on it, most of my
>> learning took place by reading pre-existing drivers and consulting
>> with my mentor. Secondly, as the Allwinner documentation is mostly a
>> register list with bitfield details, I also had to read the SDK
>> drivers and do some trial and error testing to discover magic values
>> and understand others.
>
> I feel your pain :)
>
>> Lately, I have also been working on the audio part, now that I have
>> a working DMA driver. After implementing cyclic DMA transfers and
>> some clock code, and armed with a Buildroot image with mpg123 and an
>> OpenBSD release track[5] in mp3 format, I've been trying to get some
>> sound out of my Cubietruck's headphone jack, but without much
>> success so far. I have verified my userspace stack and hardware by
>> running these same binaries on top of the linux-sunxi 3.4 kernel,
>> and it worked fine. I have since then been dumping relevant
>> registers with devmem and comparing them, resolving issues as I see
>> them - hopefully this will yield some audible results.
>
> What have you been working on? A new driver from scratch, tried to
> take Allwinner's code and then cleant it up, or used the recently
> published driver Jon made?
>
>> Interestingly enough, Allwinner themselves do not seem to be using
>> cyclic DMA transfers on their driver[6]. I hope this is not a sign
>> of a hardware bug that's not documented.
>
> So they just implement a cyclic-like behaviour in software?

>From what I can tell the Allwinner hardware will just cycle on a
single buffer.  Cyclic DMA for the kernel needs to cycle on the
equivalent of a scatter/gather list (in most cases the buffers are
sequential periodic splits of a single buffer).  And as each segment
completes it needs to signal the DMA subsystem.  Allwinner chips don't
support hardware scatter gather but that isn't a major problem.

I have this kind of working in my version of the DMA driver. But I'd
rather be working on audio code than DMA so I will switch as soon as
there is a better option. My goal is to get I2S going and the on-chip
codec is just a stepping stone.

I do think the DMA driver needs to be modified so that as the promise
completes the next promise is programmed into the channel inside the
ISR instead of dropping back to the tasklet.  There is a hard
real-time deadline on when that FIFO will empty. With 192K audio that
deadline is around 50us.  All of the other DMA drivers I have looked
at program in the next segment from the ISR.


>
>> To give some closure to this status report, I'd like to thank Maxime
>> for his mentoring so far, Ezequiel for letting me pick his brain,
>> and the Linux Foundation and Google for giving me this opportunity,
>> as well as everyone on the kernel and sunxi communities who have
>> come forward to review and test patches. You can expect a new report
>> soon, in about a week's time or less.
>
> Keep up the good work.
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



-- 
Jon Smirl
jonsmirl at gmail.com
