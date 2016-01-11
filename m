From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 11 Jan 2016 14:53:36 +0100
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <4412078.STjb1rKkbV@wuerfel>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <20160110115858.GV6588@sirena.org.uk>
 <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
 <4412078.STjb1rKkbV@wuerfel>
Message-ID: <A156F37A-76CF-4ECF-8C85-162A71877EC5@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 11.01.2016, at 14:38, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Sunday 10 January 2016 13:17:17 Martin Sperl wrote:
>> 
>> What you propose is a major change to the clock framework, so I would
>> hope that Eric (the original author of this clock-driver) would address
>> it.
>> 
>> Maybe someone has a better idea for a pattern to use to achieve 
>> the required while maintaining ?synchronization? between defines
>> inside the dt-binding and the driver.
> 
> It's funny to look at the register list:
> 
> #define CM_VPUCTL               0x008
> #define CM_VPUDIV               0x00c
> #define CM_SYSCTL               0x010
> #define CM_SYSDIV               0x014
> #define CM_PERIACTL             0x018
> #define CM_PERIADIV             0x01c
> #define CM_PERIICTL             0x020
> #define CM_PERIIDIV             0x024
> #define CM_H264CTL              0x028
> #define CM_H264DIV              0x02c
> 
> This one seems completely regular, there is always a pair of CTL and DIV
> registers, so I would have guessed that we could just take the index
> of that to completely avoid the need for the header file and just have
> a lookup table of each index.
> 
> I can see two possible ways forward:
> 
> a) deprecate the existing binding and write a new simpler driver to
>   replace it with one that does not need the header. We probably need
>   to keep both drivers around indefinitely though to deal with people
>   that have their own dtb files, so this is a bit awkward.
I was thinking about this as well, but am concerned about the dt-changes.

Also initialization order may be an issue, so I have avoided that.

> b) look at all the holes in the table and define new numbers for them
>   now, then remove the count as the driver can simply hardcode the
>   maximum number as it knows it will never change.
There are clocks for most of them - See my patch I sent some time ago.

Right now I have got a working version with the following patches:
817176d clk: bcm2835: add missing clocks
8f74701 clk: bcm2835: enable management of PCM clock
62a7d94 clk: bcm2835: move to a different initialization scheme.

There is one more thing that I would like to do before submitting those
as a patch-set: enable the fractual divider, because right now
we calculate the fractual divider value correctly, but we do not set
the flag to enable it, so we are actually running too fast most
of the times...
