From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sat, 12 Jul 2014 01:17:00 -0300
Subject: GSoC 2014 #0 status report - Improving Allwinner SoC support
In-Reply-To: <20140710203906.GA3745@lukather>
References: <53BE0B4F.1090001@elopez.com.ar> <20140710203906.GA3745@lukather>
Message-ID: <53C0B6BC.80201@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 10/07/14 17:39, Maxime Ripard escribi?:
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

I've been working on top of Jon's codec patches. Seeing that the last 
series Jon published on his github produces some sound, I got a fresh 
copy of it today, and with some changes on DMAEngine, it's playing nicely.

As cyclic transactions are special (eg, they don't become empty) I 
rewrote the cyclic support Jon had, making it issue subsequent transfers
directly from the interrupt request, and minimizing the number of times 
this needs to be done. If we use the half done interrupt, we can get 
away with one hardware programming per two periods.

It's rather late now and I still need to clean up the code a bit, but 
I'll push a branch with these changes on my repo during the weekend.

>> Interestingly enough, Allwinner themselves do not seem to be using
>> cyclic DMA transfers on their driver[6]. I hope this is not a sign
>> of a hardware bug that's not documented.
>
> So they just implement a cyclic-like behaviour in software?

Yep, they have this code to cycle through the buffer

https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/sound/soc/sunxi/sunxi-codec.c#L648

Cheers!

Emilio
