From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 11 Aug 2014 19:38:03 +0200
Subject: [RESEND PATCH 1/1] ARM: exynos_defconfig: Enable SBS battery
 support
In-Reply-To: <87990175.pWuoYNXuLf@amdc1032>
References: <1407755198-17568-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=XfvzKJO-enwH95hi_mGT6AhXq-R9WHjvhRrDdNtdmazA@mail.gmail.com>
 <53E8EDE5.4000807@collabora.co.uk> <87990175.pWuoYNXuLf@amdc1032>
Message-ID: <53E8FF7B.8020301@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bartlomiej,

On 08/11/2014 07:28 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, August 11, 2014 06:23:01 PM Javier Martinez Canillas wrote:
>> Hello,
>> 
>> On 08/11/2014 05:59 PM, Doug Anderson wrote:
>> > Bartlomiej,
>> > 
>> > On Mon, Aug 11, 2014 at 8:42 AM, Bartlomiej Zolnierkiewicz
>> > <b.zolnierkie@samsung.com> wrote:
>> >>
>> >> Hi,
>> >>
>> >> On Monday, August 11, 2014 02:52:27 PM Javier Martinez Canillas wrote:
>> >>> Hello Bartlomiej,
>> >>>
>> >>> On 08/11/2014 02:40 PM, Bartlomiej Zolnierkiewicz wrote:
>> >>> >> index fc7d168..c390bb9 100644
>> >>> >> --- a/arch/arm/configs/exynos_defconfig
>> >>> >> +++ b/arch/arm/configs/exynos_defconfig
>> >>> >> @@ -77,6 +77,7 @@ CONFIG_SPI_S3C64XX=y
>> >>> >>  CONFIG_I2C_S3C2410=y
>> >>> >>  CONFIG_DEBUG_GPIO=y
>> >>> >>  CONFIG_POWER_SUPPLY=y
>> >>> >> +CONFIG_BATTERY_SBS=m
>> >>> >
>> >>> > Why not make it "=y"?
>> >>> >
>> >>> > Rationale:
>> >>> > - currently no hardware related option uses "=m" in exynos_defconfig
>> >>> > - it would match the SBS option usage in multi_v7_defconfig
>> >>> >
>> >>> >>  CONFIG_CHARGER_TPS65090=y
>> >>> >>  # CONFIG_HWMON is not set
>> >>> >>  CONFIG_THERMAL=y
>> >>> >
>> >>>
>> >>> I know but personally I think this should be changed. The idea of having a multi
>> >>> platform kernel is to build a single kernel image that can be used to boot
>> >>> different platforms. Not all platforms have a SBS-compliant battery so this
>> >>> support shouldn't be built in the kernel image IMHO.
>> >>>
>> >>> This also matches to what real users will do since distributions most likely
>> >>> will have a minimal kernel and every possible hardware support will be enabled
>> >>> as a loadable kernel module. This is what distros do for other platforms too.
>> >>>
>> >>> If someone has a different use case and wants a kernel image that is optimized
>> >>> for a particular platform then she has to create its own defconfig anyways.
>> >>
>> >> Distributions usually use their own configs anyway and the current most
>> >> popular use case for exynos_defconfig (not multi_v7_defconfig) seems to
>> >> be to build kernel image alone and use it without any modules:
>> >>
>> >> $ grep "=m" arch/arm/configs/exynos_defconfig
>> >> CONFIG_DM_CRYPT=m
>> >>
>> >> $ grep "=m" .config
>> >> CONFIG_NET_IP_TUNNEL=m
>> >> CONFIG_INET_TUNNEL=m
>> >> CONFIG_IPV6=m
>> >> CONFIG_INET6_XFRM_MODE_TRANSPORT=m
>> >> CONFIG_INET6_XFRM_MODE_TUNNEL=m
>> >> CONFIG_INET6_XFRM_MODE_BEET=m
>> >> CONFIG_IPV6_SIT=m
>> >> CONFIG_DM_CRYPT=m
>> >> CONFIG_CRYPTO_RNG=m
>> >> CONFIG_CRYPTO_ANSI_CPRNG=m
>> >>
>> >> What I'm trying to say is that there is a high probability that people
>> >> will continue to use just the kernel image for exynos_defconfig and
>> >> will therefore miss SBS battery support altogether (which is only 3.6
>> >> kB of code more in the kernel image so there is no much gain in making
>> >> it modular currently).
>> > 
>> > I'm not against making it =y for exynos_defconfig.  I do pretty
>> > strongly agree that the multi_v7 version should be =m eventually,
>> > though.  We'd need to do everything we can to make that kernel
>> > smaller.
>> >
>> 
>> Same for me. I don't have such a strong opinion about this so if you think that
>> I should re-spin to change to =m, I will.
>> 
>> I do think that we should try to keep the delta between exynos_defconfig and
>> multi_v7_defconfig as small as possible and eventually even get rid of
>> exynos_defconfig. Since building everything as built-in and having a config
> 
> I completely agree.  I proposed exynos_defconfig removal as soon as
> Exynos gained multiplatform support (and before exynos_defconfig
> started getting out-of-sync with multi_v7_defconfig).  There were
> arguments that it is still useful in some cases.  I think that if
> it would be possible to go from a modular multi_v7_defconfig to
> a modular/built-in single platform config (using a script?) all
> such use cases will be covered.
> 
>> targeted to a single platform is not aligned with the effort to have support for
>> multi platforms kernels.
> 
> Currently even for multi_v7_defconfig "=m" seems to be an exception
> from the general rule:
> 
> $ grep "=m" arch/arm/configs/multi_v7_defconfig 
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_IPCOMP=m
> CONFIG_IPV6_MIP6=m
> CONFIG_IPV6_TUNNEL=m
> CONFIG_CFG80211=m
> CONFIG_MAC80211=m
> CONFIG_BRCMFMAC=m
> CONFIG_RT2X00=m
> CONFIG_RT2800USB=m
> 
> $ wc -l arch/arm/configs/multi_v7_defconfig 
> 405 arch/arm/configs/multi_v7_defconfig
> 

Again, I think this is more of a consequence of people adding the config they
use (which as you said in most cases is just built everything in the kernel to
avoid copying modules) than something that was made on purpose.

> so I would vote for CONFIG_BATTERY_SBS=y for both configs.  Especially
> since it results in only 3.6 kB bigger kernel image (0.05% kernel size
> increase for kernel image built with exynos_defconfig, probably a lot
> less for multi_v7_defconfig one).
> 

I'll repost with =y for exynos_defconfig but I really think that for
multi_v7_defconfig we should have everything as a module if possible. It's just
3.6 kB but if every single platform do the same the kernel will be quite bloated
for little gain.

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 

Best regards,
Javier
