From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 6 Jun 2014 23:06:51 +0530
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
Message-ID: <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

The first change in the kernel (clearing an iRAM location) is needed
because of an unnecessary change that we are carrying in the Chrome
U-boot. There is no reason for us to have the workaround in the
mainline kernel. Rather, we should remove the check from our u-boot.
However AFAIR a clean-up patch that I had posted internally was not
accepted as we had frozen the SPL at the time.

The second change is to enable snoops for boot cluster. Internally, we
were disabling the snoops for both the clusters at power off and
enabling it in power_up_setup and power_up. However, I dropped the
approach due to problems pointed out by Nicolas here
http://www.spinics.net/lists/arm-kernel/msg324091.html related to
cpuidle. Hence, we turn it on at the u-boot.

Regards,
Abhilash

On Fri, Jun 6, 2014 at 10:47 PM, Doug Anderson <dianders@google.com> wrote:
> Tushar,
>
> On Thu, Jun 5, 2014 at 9:38 PM, Tushar Behera <trblinux@gmail.com> wrote:
>> On 06/06/2014 06:38 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> When I try to boot linuxnext on my exynos5420-peach-pit chromebook I
>>> have problems bringing up extra CPUs:
>>>
>>> 1. They don't come up
>>>
>>
>> [ ... ]
>>
>>> [    1.125030] CPU1: failed to boot: -38
>>> [    2.130043] CPU2: failed to boot: -38
>>> [    3.135059] CPU3: failed to boot: -38
>>>
>>
>> With following config modifications over exynos_defconfig, I can see 4
>> big cores coming up.
>>
>> CONFIG_MCPM=y
>> CONFIG_EXYNOS5420_MCPM=y
>
> Thanks!  OK, that certainly changes the behavior for me!  ...but it
> doesn't work.
>
> I also got a response from some folks that I pinged off-list.
> Apparently our U-Boot doesn't set things up like the upstream kernel
> expects (ugh!), so to get things booting you need the magic commands
> in U-Boot:
>
> mw.l 02073028 0  # Clear EXYNOS_START_FLAG
> mw.l 10d25000 3  # Enable CCI from U-Boot
>
> Once you do that then all 8 CPUs can come up!
>
>
> Can someone at Samsung come up with a reasonable solution about how we
> should solve this in a way that everyone can be happy with?  I haven't
> really been involved with MCPM stuff, so I'm not sure why what landed
> upstream is different than what we have in our kernel.
>
> I guess worst case we can require that anyone running an upstream
> kernel simply needs a "fixed" U-Boot, but that's always a bit of a
> hassle.  We might have to go there eventually anyway given that our L2
> cache timings in U-Boot are wrong (again!) and it's unlikely that
> upstream will take some weird hack in the kernel to fix them...
>
> -Doug
>
>
> P.S. We also really need to do something about the configs.  There are
> no exynos configs upstream that have any useful set of options (that I
> know of).  ...and useful options don't seem to get selected
> automatically...
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
