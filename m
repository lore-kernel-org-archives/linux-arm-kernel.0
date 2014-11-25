From: amstan@chromium.org (Alexandru Stan)
Date: Tue, 25 Nov 2014 13:11:43 -0800
Subject: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc for
 vqmmc
In-Reply-To: <CAD=FV=U9Hh-OR2aGh6Q9YAwnP8AuAbQtogD=7wQxgg9XvoWTMw@mail.gmail.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
 <1415678573-6093-1-git-send-email-addy.ke@rock-chips.com>
 <CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>
 <CAD=FV=VQHZ6YmcoeAb1OEVLYRrYBnc_dM5Kjt1TZX_CQJC=EfA@mail.gmail.com>
 <5464152E.7040209@rock-chips.com>
 <CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
 <CAD=FV=Ve1TY4+8quq1=18A1YOFvOWuFGrBmHLwMCwdWBSqzxOw@mail.gmail.com>
 <CAD=FV=UJT5zBkcj2a03Y_RWxad9+Pu83G_z79Xzzn74V=eRqww@mail.gmail.com>
 <CAPDyKFqt4rrwi940KAPyPONpjixK1730QmHEsN27V97jyHH+Qw@mail.gmail.com>
 <5473EB8B.3000803@rock-chips.com>
 <CAD=FV=U9Hh-OR2aGh6Q9YAwnP8AuAbQtogD=7wQxgg9XvoWTMw@mail.gmail.com>
Message-ID: <CAHNYxRwT8YeR-AUa-BVPraufLWZtEaeLdNjGBs77CfkMWVCNqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From what I understand... High speed SD cards have 1.8V regulators
inside them(sourced by vmmc (what we power the SD card with)). So in
terms of the SD card IO pins they will either use exactly vmmc or
1.8V. It doesn't make sense for vqmmc (the voltage we use to power the
AP block connected to the SD cards) to be anything but exactly equal
to vmmc or 1.8V. If vqmmc differs from vmmc(or 1.8V, depending on
mode) by more than a little (~100-200mV), both up or down, you start
getting leaks into the input protection diodes of the pins(either the
AP or the SD card) which is a pretty BAD thing (you're essentially
powering the sd card through the IO pins, or the SD card is powering
the IO block on the AP).

Alexandru Stan (amstan)

On Mon, Nov 24, 2014 at 9:36 PM, Doug Anderson <dianders@chromium.org> wrote:
> Addy,
>
> On Mon, Nov 24, 2014 at 6:38 PM, Addy <addy.ke@rock-chips.com> wrote:
>>> In worst case scenario, VDD = 3.6V and VIO = 2.7V. That gives as the
>>> factor of 0.75, thus we are inside spec but without margins.
>>
>> * From eMMC4.5 spec:
>>   1. (VDDF)vcc: Supply voltage for flash memory,  which is  2.7v -- 3.3v
>>   2. (VDD)vccq: Supply voltage for memory controller, which is  1.7v --
>> 1.95v  and 2,7v -- 3.6v
>>
>> * And from RK3288 datasheet:
>>   Digtial GPIO Power(SDMMC0_VDD --> vccq) is 3.0v -- 3.6v and 1.62v - 1.98v
>>
>> So I think:
>> 3.3v:  (2.7v < vccq < 3.6v)   &&  (3.0v < vccq < 3.6v)  ==> (3.0v < vccq <
>> 3.6v)
>> 1.8v:  (1.7v < vccq < 1.95v)  && (1.62v < vccq < 1.98v) ==> (1.7v < vccq <
>> 1.95v)
>>
>> and (2.7v < vcc < 3.3v)
>>
>> * And according to our hardware engineer:
>>   All of supply voltage must have +/- 10% cushion.
>>
>> * And we have found in some worse card that there is 200mv voltage collapse
>> when these card is insert.
>>
>> So I think the best resolution is that vcc and vccq is configurable int dt
>> table.
>
> Ah, interesting.  ...so what we really need to be able to do is to say
> that the regulator we for vqmmc have supports the ranges 3.0V - 3.3V
> and 1.7V - 1.95V but not anything in between 1.95V ad 3.0V.  I have no
> idea how to express that in the regulator framework.
>
> Technically you could take the IO Voltage Domains code (responsible
> for choosing the 1.8V range or the 3.3V range) and have it communicate
> the requirements to the regulator framework if you could figure out
> how to communicate them.
>
>
> ...of course if you implemented my suggestion of keeping vqmmc as the
> highest voltage <= vmmc then maybe the whole point is moot and we
> don't have to figure it out.  Just make sure that vmmc never goes
> below 3.0V.
>
>
> -Doug
