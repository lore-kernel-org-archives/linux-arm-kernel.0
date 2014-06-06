From: dianders@google.com (Doug Anderson)
Date: Fri, 6 Jun 2014 10:17:00 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <539145B4.5000200@gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
Message-ID: <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar,

On Thu, Jun 5, 2014 at 9:38 PM, Tushar Behera <trblinux@gmail.com> wrote:
> On 06/06/2014 06:38 AM, Doug Anderson wrote:
>> Hi,
>>
>> When I try to boot linuxnext on my exynos5420-peach-pit chromebook I
>> have problems bringing up extra CPUs:
>>
>> 1. They don't come up
>>
>
> [ ... ]
>
>> [    1.125030] CPU1: failed to boot: -38
>> [    2.130043] CPU2: failed to boot: -38
>> [    3.135059] CPU3: failed to boot: -38
>>
>
> With following config modifications over exynos_defconfig, I can see 4
> big cores coming up.
>
> CONFIG_MCPM=y
> CONFIG_EXYNOS5420_MCPM=y

Thanks!  OK, that certainly changes the behavior for me!  ...but it
doesn't work.

I also got a response from some folks that I pinged off-list.
Apparently our U-Boot doesn't set things up like the upstream kernel
expects (ugh!), so to get things booting you need the magic commands
in U-Boot:

mw.l 02073028 0  # Clear EXYNOS_START_FLAG
mw.l 10d25000 3  # Enable CCI from U-Boot

Once you do that then all 8 CPUs can come up!


Can someone at Samsung come up with a reasonable solution about how we
should solve this in a way that everyone can be happy with?  I haven't
really been involved with MCPM stuff, so I'm not sure why what landed
upstream is different than what we have in our kernel.

I guess worst case we can require that anyone running an upstream
kernel simply needs a "fixed" U-Boot, but that's always a bit of a
hassle.  We might have to go there eventually anyway given that our L2
cache timings in U-Boot are wrong (again!) and it's unlikely that
upstream will take some weird hack in the kernel to fix them...

-Doug


P.S. We also really need to do something about the configs.  There are
no exynos configs upstream that have any useful set of options (that I
know of).  ...and useful options don't seem to get selected
automatically...
