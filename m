From: jcm@redhat.com (Jon Masters)
Date: Fri, 13 Mar 2015 00:44:43 -0400
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <20141205111455.GC28339@e104818-lin.cambridge.arm.com>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <CAOesGMhv+0_SZb2eSiwCGaD77hd=a6EhMp6tVvcrZoBnrHKQjA@mail.gmail.com>
 <20141205111455.GC28339@e104818-lin.cambridge.arm.com>
Message-ID: <55026B3B.8050507@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2014 06:14 AM, Catalin Marinas wrote:
> On Thu, Dec 04, 2014 at 09:15:12PM +0000, Olof Johansson wrote:
>> On Thu, Dec 4, 2014 at 7:46 AM, Alexander Graf <agraf@suse.de> wrote:
>>> With binutils 2.25 the default alignment for 32bit arm sections changed to
>>> have everything 64k aligned. Armv7 binaries built with this binutils version
>>> run successfully on an arm64 system.
>>>
>>> Since effectively there is now the chance to run armv7 code on arm64 even
>>> with 64k page size, it doesn't make sense to block people from enabling
>>> CONFIG_COMPAT on those configurations.
>>>
>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>> ---
>>>  arch/arm64/Kconfig | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 9532f8d..3cf4f238 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -409,7 +409,6 @@ source "fs/Kconfig.binfmt"
>>>
>>>  config COMPAT
>>>         bool "Kernel support for 32-bit EL0"
>>> -       depends on !ARM64_64K_PAGES
>>>         select COMPAT_BINFMT_ELF
>>>         select HAVE_UID16
>>>         select OLD_SIGSUSPEND3
>>
>> This is hardly "compat". Sure, it's great to have a new binutils that
>> has larger alignment, but practically not a single existing binary
>> will work today if someone tries to do this.
>>
>> So, it seems very premature to take this off. At the very least
>> document it like Will requested, and make it depend on !ARM_64K_PAGES
>> || EXPERT.
> 
> That would work for me. We need to be clear that most existing 32-bit
> binaries will fail.

Agreed. Btw we intend to ensure that a future Fedora mass rebuild
incorporates this change in alignment on 32-bit to allow 32-bit Fedora
userspace to exist inside a (32-bit personality) chroot on AArch64. This
will allow us to migrate to 64-bit native builders both for 32 and
64-bit in advance of the eventual plan for KVM based build guests.

Jon.
