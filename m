From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 21 Feb 2013 10:36:41 +0000
Subject: arm64 defconfig breakage (gpio) in next-20130218
In-Reply-To: <1634805.kh17mYrJe5@wuerfel>
References: <20130218111410.GA10572@e106331-lin.cambridge.arm.com>
 <20130221093104.GB23442@S2101-09.ap.freescale.net>
 <1634805.kh17mYrJe5@wuerfel>
Message-ID: <CACxGe6tVk4na2yLi-6r1fTv5QqzgePbo6K+ZtEt-VOy25DQxVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 10:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 21 February 2013 17:31:07 Shawn Guo wrote:
>> >
>> > I've bisected this down to 0fa2fd9a0d: "Merge branch 'linusw/devel' of
>> > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git into
>> > gpio/next". Both parent commits build fine.
>> >
>> > I've played around a bit, and selecting ARCH_REQUIRE_GPIOLIB in the arm64
>> > Kconfig fixes the issue, but I'm unfamilar with gpio{,lib} and I'm not sure
>> > that's the best/correct way of solving this.
>>
>> Kconfig GENERIC_GPIO is designed as an option defined at architecture
>> level and select by platform who knows how gpio driver/API is
>> implemented.  The following change should fix the error.
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index f532ce5..aca4a25 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -93,7 +93,7 @@ config IOMMU_HELPER
>>         def_bool SWIOTLB
>>
>>  config GENERIC_GPIO
>> -       def_bool y
>> +       bool
>>
>>  source "init/Kconfig"
>
> But we have no arm64 platforms that would pick GENERIC_GPIO, it's expected
> to come from GPIOLIB anyway. I think the right fix is this:
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ab4aa54..3fab0db 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>         select ARCH_WANT_FRAME_POINTERS
> +       select ARCH_WANT_OPTIONAL_GPIOLIB
>         select ARM_AMBA
>         select ARM_ARCH_TIMER
>         select CLONE_BACKWARDS
> @@ -92,9 +93,6 @@ config SWIOTLB
>  config IOMMU_HELPER
>         def_bool SWIOTLB
>
> -config GENERIC_GPIO
> -       def_bool y
> -
>  source "init/Kconfig"
>
>  source "kernel/Kconfig.freezer"

I've not asked Linus to pull the GPIO tree yet because of this issue.
Can someone please test this on aarch64 and send me a properly
formatted patch?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
