From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Thu, 10 Jul 2014 08:38:55 -0400
Subject: [linux-sunxi] GSoC 2014 #0 status report - Improving Allwinner
 SoC support
In-Reply-To: <CAKON4OxPG7sYoJQSLu62ptzJPo9vBHxWBb+-+Z9nZ2EVBeJPww@mail.gmail.com>
References: <53BE0B4F.1090001@elopez.com.ar>
 <CAKON4OxPG7sYoJQSLu62ptzJPo9vBHxWBb+-+Z9nZ2EVBeJPww@mail.gmail.com>
Message-ID: <CAKON4Ozcz0A2Rbc=mEoZBvUgx0A-DMz1qKN8pf7U4UNNUd5K9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 8:32 AM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> On Wed, Jul 9, 2014 at 11:41 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
>> Hi everyone,
>>
>> As some of you may know, I'm currently participating in Google Summer of
>> Code under the Linux Foundation, working on a proposal titled "Improve
>> Allwinner SoCs support on mainline Linux". There is a great quantity of
>> devices out there that are powered by Allwinner processors, including but
>> not limited to the various Cubieboards, OLinuXinos, STBs, Tablets and ?Mini
>> PCs?. However, to date, support on mainline Linux is not yet feature
>> complete. My proposal on particular focuses on DMA and analog audio on the
>> earlier SoCs, and improved A23 support.
>>
>> The idea here is to make a weekly status report of the project. As we are
>> starting mid-program, this one will be a bit different and I'll outline what
>> has been worked on so far since the beginning.
>>
>> To date, I have been mainly working on the DMA driver for sun4i, sun5i and
>> sun7i. Despite having completely different drivers on SDK kernels, the
>> hardware block looks and behaves the same, so we are using a single driver
>> for these three SoC families. I have sent a series of patches[1] as well as
>> a follow-up v2[2], and I will keep iterating over it until it's accepted. I
>> have also sent two trivial patches[3][4] as a side-effect.
>>
>> The main challenges while writing this driver can be summarized as a lack of
>> documentation. First of all, it took me a bit to get to know DMAEngine. As
>> there is not much documentation on it, most of my learning took place by
>> reading pre-existing drivers and consulting with my mentor. Secondly, as the
>> Allwinner documentation is mostly a register list with bitfield details, I
>> also had to read the SDK drivers and do some trial and error testing to
>> discover magic values and understand others.
>>
>> Lately, I have also been working on the audio part, now that I have a
>> working DMA driver. After implementing cyclic DMA transfers and some clock
>> code, and armed with a Buildroot image with mpg123 and an OpenBSD release
>> track[5] in mp3 format, I've been trying to get some sound out of my
>> Cubietruck's headphone jack, but without much success so far. I have
>> verified my userspace stack and hardware by running these same binaries on
>> top of the linux-sunxi 3.4 kernel, and it worked fine. I have since then
>> been dumping relevant registers with devmem and comparing them, resolving
>> issues as I see them - hopefully this will yield some audible results.
>>
>
> Check out the last commit in this branch. It is based on your current
> DMA branch.
> https://github.com/jonsmirl/lpc31xx/tree/linus
>
> I am getting noise out of the codec but it is not the right noise.
> Plus the cyclic transfer falls over when the buffer wraps. There is no
> need to use the CONT bit on the Allwinner DMA hardware to implement
> cyclic.
>
> The DMA interrupt routine should directly program in the next transfer
> in the promise chain when the previous one completes. Doing it from
> the tasklet opens a window where kernel task swap delays can cause DMA
> underrun.


This commit is my WIP code.
https://github.com/jonsmirl/lpc31xx/commit/dcbab1749af5fd82a65d72670a7a77f7ee734ba8

Where is yours? I don't see it in your repo.


>
>
>
>
>> Interestingly enough, Allwinner themselves do not seem to be using cyclic
>> DMA transfers on their driver[6]. I hope this is not a sign of a hardware
>> bug that's not documented.
>>
>> To give some closure to this status report, I'd like to thank Maxime for his
>> mentoring so far, Ezequiel for letting me pick his brain, and the Linux
>> Foundation and Google for giving me this opportunity, as well as everyone on
>> the kernel and sunxi communities who have come forward to review and test
>> patches. You can expect a new report soon, in about a week's time or less.
>>
>> Emilio
>>
>> [1] http://www.spinics.net/lists/dmaengine/msg01148.html
>> [2] http://www.spinics.net/lists/arm-kernel/msg344766.html
>> [3] https://lkml.org/lkml/2014/5/11/166
>> [4] https://lkml.org/lkml/2014/7/1/486
>> [5] http://www.openbsd.org/lyrics.html, maybe I should consider using some
>> other song for better luck
>> [6]
>> https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/sound/soc/sunxi/sunxi-codec.c#L1137
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
>
>
>
> --
> Jon Smirl
> jonsmirl at gmail.com



-- 
Jon Smirl
jonsmirl at gmail.com
