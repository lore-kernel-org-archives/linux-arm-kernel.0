From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 May 2017 22:33:14 +0200
Subject: [PATCH v4 6/7] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class
 cpus
In-Reply-To: <20170523200142.GD22219@n2100.armlinux.org.uk>
References: <1493029017-31382-1-git-send-email-vladimir.murzin@arm.com>
 <1493029017-31382-7-git-send-email-vladimir.murzin@arm.com>
 <20170523200142.GD22219@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a0tbaAHerjitDBJ9gz1SCFkAwKhfzjgMHiB5ESakQs7-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 10:01 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Apr 24, 2017 at 11:16:56AM +0100, Vladimir Murzin wrote:
>> Now, we have dedicated non-cacheable region for consistent DMA
>> operations. However, that region can still be marked as bufferable by
>> MPU, so it'd be safer to have barriers by default.
>
> What do you actually want here?  Your patch doesn't quite make sense,
> the commit description seems to indicate that you require this option
> to be set for V7M, but the patch says otherwise.
>
>>  config ARM_DMA_MEM_BUFFERABLE
>> -     bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
>> -     default y if CPU_V6 || CPU_V6K || CPU_V7
>> +     bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K || CPU_V7M) && !CPU_V7
>
> This "if" conditional conditionalises the visibility of the option,
> it doesn't conditionalise the value.
>
>> +     default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
>
> Taking both of these changes together what you end up with is an option
> presented to the user for "Use non-cacheable memory for DMA" which
> they can choose to disable.
>
> If you require this option to be set, that's incorrect - your modification
> to the default line is correct, but the first line is not.  To achieve
> that, you want the if condition to evaluate false for V7M, thereby hiding
> the option from the user.  In that case, the default value will always be
> assigned to the option.

I had the opposite comment in the previous version ;-)
https://lkml.org/lkml/2017/4/19/185

I think the current patch is correct, but the description could still be
clarified: On some of the beefier ARMv7-M machines (with DMA
and write buffers) we want this enabled, while those that didn't
need it until now also won't need it in the future.

        Arnd
