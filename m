From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Aug 2011 17:06:52 +0100
Subject: [PATCH 0/3] Fix Thumb-2 undef handling for mixed-arch kernels
In-Reply-To: <1313506694.2235.15.camel@computer2>
References: <1313504053-27873-1-git-send-email-dave.martin@linaro.org>
	<1313506694.2235.15.camel@computer2>
Message-ID: <CA+wbFdf-gXYX60JfuzpAARRUbgnk3St13CasEn2VtOcUJ_J6rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 3:58 PM, Tixy <tixy@yxit.co.uk> wrote:
> On Tue, 2011-08-16 at 15:14 +0100, Dave Martin wrote:
>> In kernels which support v6 and v7 platforms in a single binary
>> such as omap2plus_defconfig for example, undefined instruction
>> exceptions taken on Thumb instructions are not processed correctly,
>> because the kernel assumes at build-time that Thumb-2 won't be
>> supported in userspace.
>>
>> This series implements a workaround, by allowing the __und_usr
>> handler to check the CPU architecture at runtime, in affected
>> kernels.
>>
>> Changes since RFC:
>> ? * Renamed the global variable to __cpu_architecture and provided
>> ? ? cpu_architecture() as in inline function in <asm/system.h>.
>> ? ? This brings back the old API, but more efficiently.
>> ? * Dropped all the patches required to handle the reverted API
>> ? ? change.
>> ? * cpu_architecture is now declared __pure, which may lead to
>> ? ? slightly more efficient code in some cases.
>> ? * Added BUG_ON() to cpu_architecture() so that if
>> ? ? __cpu_architecture is not set early enough, it gets noticed.
>>
>> Thanks to Tixy and Nicolas Pitre for their helpful feedback which
>> helped slim down this series.
>>
>> Dave Martin (3):
>> ? ARM: Make cpu_alignment into a global variable
>> ? ARM: entry: Remove unnecessary masking when decoding Thumb-2
>> ? ? instructions
>> ? ARM: entry: Fix Thumb-2 undef handling for multi-CPU kernels
>>
>> ?arch/arm/include/asm/system.h | ? 11 +++++++++-
>> ?arch/arm/kernel/entry-armv.S ?| ? 44 ++++++++++++++++++++++++++++++++++++----
>> ?arch/arm/kernel/setup.c ? ? ? | ? ?5 +++-
>> ?3 files changed, 53 insertions(+), 7 deletions(-)
>>
>
> Looks good to me.

Thanks for looking over it.

Is that a Reviewed-by, or will you go for an Ack?

Cheers
---Dave
