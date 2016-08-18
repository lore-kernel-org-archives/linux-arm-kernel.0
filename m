From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 18 Aug 2016 15:23:41 +0200
Subject: Merging code with arch condition into head.S
In-Reply-To: <CAKv+Gu8dP8oAq-ykejskw+AzX-7_h_Ws6sFdXO+40MiGM14ccA@mail.gmail.com>
References: <CACna6rxhhD5kfa1oJzqp2dQxBhjaUzdTkNPMcm-+iNvQHD8yzA@mail.gmail.com>
 <CAKv+Gu8dP8oAq-ykejskw+AzX-7_h_Ws6sFdXO+40MiGM14ccA@mail.gmail.com>
Message-ID: <CACna6rw1eTiqijo24SiGAYi_XeEGWb-C1L5diYUzpyA3o7e+qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 August 2016 at 12:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 18 August 2016 at 12:35, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>> I'd like to ask for help with writing my arcm/arm/boot/compressed/head-foo.S.
>>
>> There is probably a bug in bootloader on *a lot* market-available
>> devices that needs a very early fix executed during decompression. If
>> we don't implement it, Broadcom Northstar devices hang in 25% of tries
>> and BCM53573 devices don't boot at all.
>>
>
> Could you elaborate on the nature of the fix?

I'm not ARM expert and I don't have any Broadcom datasheets, so I have
a very little view of the issue. It seems that to make booting
reliable, I have to clear 2 following bits in the SCTLR register:
#define CR_M (1 << 0) /* MMU enable */
#define CR_C (1 << 2) /* Dcache enable */
and then invalidate the cache.

Old OpenWrt implementation that comes with its own
v7_all_dcache_invalidate ENTRY:
http://git.openwrt.org/?p=15.05/openwrt.git;a=blob;f=target/linux/bcm53xx/patches-3.18/300-ARM-BCM5301X-Disable-MMU-and-Dcache-for-decompression.patch;hb=HEAD

Newer implementation that re-uses part of existing
__armv7_mmu_cache_flush ENTRY:
https://git.lede-project.org/?p=source.git;a=blob;f=target/linux/bcm53xx/patches-4.4/300-ARM-BCM5301X-Disable-MMU-and-Dcache-for-decompression.patch;h=62bda2e8303ec7361226984253f31d52a8ec80c2;hb=HEAD

The problem I recently discovered is that this new implementation
(without independent v7_all_dcache_invalidate) works on Northstar but
doesn't work on BCM53573. These are details anyway, I hope you got
some overview of the situation.


>> The problem is ARCH_BCM_5301X is used with ARCH_MULTI_V7, so we really
>> shouldn't merge some extra code into head.S and execute it
>> unconditionally. I'd like to ask if you can suggest some idea for a
>> sane architecture check.
>>
>> Ideally I'd read it from DT, but I don't think I can read machine
>> "compatible" from ASM. As alternative I could try reading SoC chip ID
>> from ChipCommon component which Broadcom always maps at 0x18000000.
>> Would that be safe enough? Could reading from such offset do any harm
>> on other devices?
>>
>
> Yes.

Is "Yes." an answer to the last question? Also: yes, it could harm
other devices?


>> Maybe you have some better ideas?
>>
>> I was looking for similar solutions in the kernel, but I found none.
>> There are e.g. head-sa1100.S and head-sharpsl.S but they seem to be
>> used on architectures that don't use ARCH_MULTI_V7.
>>
>
> Generally, it is not the kernel's job to fix broken bootloaders,
> especially not in generic kernels. What kind of bootloader does this
> bug exist in?

It's CFE bootloader developed by Broadcom. You can find some sources
of it in some GPL packages, but those are usually vendor & device
specific. Whenever you flash a new image on your Broadcom-based home
router, the process doesn't involve bootloader, you just flash kernel
& userspace on some predefined flash partition.. So in this situation
I'm trying to find an upstream-able solution for many users who for
sure won't be able to recompile & reflash their CFE bootloaders.

-- 
Rafa?
