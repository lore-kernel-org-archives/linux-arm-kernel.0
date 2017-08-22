From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Aug 2017 21:32:53 +0200
Subject: [GIT PULL 1/6] Broadcom soc changes for 4.14
In-Reply-To: <843914385.20451.1503420633158@email.1und1.de>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
 <20170817183748.1450-2-f.fainelli@gmail.com>
 <cc4d171e-47cf-3045-738c-929807454297@gmail.com>
 <843914385.20451.1503420633158@email.1und1.de>
Message-ID: <CAK8P3a18JqcBBJ36a6w9hHwZtMtoWYHy2E1iVdJGk6WBtn+gPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 6:50 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Florian Fainelli <f.fainelli@gmail.com> hat am 22. August 2017 um 00:16 geschrieben:
>> On 08/17/2017 11:37 AM, Florian Fainelli wrote:
>>
>> 10:12 < arnd> that would also get rid of the branch dependency as an
>> added bonus, but avoiding the boot breakage is more important of course
>
> i already had a discussion with Eric about the case the dts changes are missing and i wasn't able see a boot breakage ("only" a SMP breakage which is still a regression).

Yes, that's what I meant.

>> 10:13 < arnd> Stefan Wahren did the patch, but he's either not on this
>> channel, or I don't know his nick
>>
>> 10:30 < arnd> on a related note, I see that the match table for the
>> machine descriptor doesn't list bcm2837, and the bcm2837.dtsi file
>> doesn't list itself as compatible with bcm2836, so that would have to be
>>    added too to make it actually work
>>
>
> sorry i don't have much time today and i'm not sure how to implement the smp_init.
>
> Here is my draft (untested) which has a linker error (arch/arm/mach-bcm/board_bcm2835.o:(.arch.info.init+0x34): Undefined reference on `bcm2836_smp_ops). Does it goes in the right direction?

Looks good to me.

>  DT_MACHINE_START(BCM2835, "BCM2835")
> -       .dt_compat = bcm2835_compat
> +       .dt_compat = bcm2835_compat,
> +       .smp = smp_ops(bcm2836_smp_ops),
> +       .smp_init = smp_init_ops(bcm2836_smp_init_ops),

One of the two should actually be sufficient here. Setting the .smp pointer
is shorter so if that works, we can leave out the init function completely.

       Arnd
