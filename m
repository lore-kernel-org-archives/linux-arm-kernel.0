From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 28 Nov 2012 19:40:59 +0530
Subject: [RFC 1/2] ARM: S3C24XX: add devicetree support for interrupts
In-Reply-To: <201211271724.55938.heiko@sntech.de>
References: <201211250145.21226.heiko@sntech.de>
 <201211261704.09273.heiko@sntech.de>
 <CAJuYYwTre+cU0mgJExON2-+1fREyL3LgdqJ4NbC8zG+03yxptA@mail.gmail.com>
 <201211271724.55938.heiko@sntech.de>
Message-ID: <CAJuYYwSJ+mz0FHZ+DPO-mLjretKiwojn2B1o3tDF-rt5-yVQkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 27 November 2012 21:54, Heiko St?bner <heiko@sntech.de> wrote:

[...]

>
>
> Because of the mails from yesterday I took another look at my code, after
> letting it sit for the previous days and I found more optimization
> possiblities.
>
> It should be possible to trim the irqtypes down to level,edge and eint types
> and do the gathering of the other informations in the code. This would make
> the list more os-agnostic.
> The list itself does describe the interconnections between the controllers, so
> I think it's not false per se, just the multitude of probably redundant types
> used should probably go down.

Ok.

>
> The other option could be to really change to individual initializers for the
> different implementations and have all the data in the code instead of the dt.
> For this I've compared all the different implementations and it seems this
> would lead to at least handlers for s3c2410, s3c2440, s3c2442, s3c2412 and
> s3c2443. For the time being they will be in the code in any case, because of
> all the non-dt boards

I did feel that it this could have been handled with dt + some kernel
code for all s3c24xx soc's but probably I am under estimating the
effort here. If it helps, the dt code need not be intermixed with
non-dt code and there can be runtime check on whether to take dt and
non-dt path.

>
> If anyone is interested, the comparison can be found on [0].
>
>
> Btw. do you know if it would have bad effects to register (but not use) for
> example the cam interrupt-handler on a machine that does not have it. (The
> additional cam, cf and spi1 interrupts are the only things differing between
> the s3c2443 and s3c2416 SoCs).

I am not aware of any bad effects of this (if those interrupts are
never enabled). But logically, it might be better not to do this. Is
this something that cannot be handled by checking the machine
compatible value.

>
>

[...]

>
> I'v seen the combiner code as well, but from the code itself I've not managed
> to understand the combiner this well yet. And Exynos datasheets, to get a
> textual description of the combiner, are not this easy to come by ;-) .

Yes, I understand. Basically interrupt combiner combines upto 8
interrupts into one interrupt that is delivered to combiner's
interrupt parent, which is the gic interrupt controller in case of
exynos. There are 16 to 32 interrupt combiners in a soc. Combiner has
the basic mask, pend and unmask registers.

Thanks,
Thomas.

[...]
