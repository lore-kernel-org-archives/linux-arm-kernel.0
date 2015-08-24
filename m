From: keescook@chromium.org (Kees Cook)
Date: Mon, 24 Aug 2015 11:06:52 -0700
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <CAGXu5jJ8KOoVkx99rrajEEx77Z6zO4TzCXaXkB74zv9QQFuJFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 6:30 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Aug 18, 2015 at 02:42:44PM -0700, Jeffrey Vander Stoep wrote:
>> List poison pointer values point to memory that is mappable by
>> userspace. i.e. LIST_POISON1 = 0x00100100 and LIST_POISON2 =
>> 0x00200200. This means poison values can be valid pointers controlled
>> by userspace and can be used to exploit the kernel as demonstrated in
>> a recent blackhat talk:
>> https://www.blackhat.com/docs/us-15/materials/us-15-Xu-Ah-Universal-Android-Rooting-Is-Back-wp.pdf
>>
>> Can these poison values be moved to an area not mappable by userspace
>> on 32 bit ARM?
>
> As was discussed privately before your message, both Catalin and myself
> agreed that this is not possible, and I proposed alternatives which were
> feasible.
>
> I have now implemented the domain access alternative which I mentioned
> during that discussion, which is suitable for all non-LPAE setups, which
> has the effect of blocking almost all implicit kernel accesses to
> userspace, thereby substantially reducing the possibility for an attack
> similar to that given in the above paper.

What's the right solution for LPAE setups?

-Kees

>
> It should be said that with the following patches applied, it won't stop
> the original bug being used to crash the system (that's already been
> fixed) but it will prevent userspace being able to mask the crash, and
> therefore prevent such use-after-free bugs being used to gain privileges.
>
> This approach also covers low-vector CPUs as well, with one caveat: the
> lower 1MB of userspace will remain accessible to the kernel due to the
> need for the vectors to remain visible.  Doing otherwise crashes the
> machine on the first exception event.  So here, we offer a "best efforts"
> implementation rather than something which completely blocks userspace
> access from kernel space.
>
> This is not a simple fix - it's quite involved, and it changes a fair
> number of places in the kernel.  It needs time to be proven before any
> thought can be given to backporting these changes to stable kernels.
> It would be good to get some testing of these changes.
>
>  arch/arm/Kconfig                            | 15 +++++
>  arch/arm/include/asm/domain.h               | 45 +++++++++++----
>  arch/arm/include/asm/futex.h                | 19 ++++++-
>  arch/arm/include/asm/pgtable-2level-hwdef.h |  1 +
>  arch/arm/include/asm/thread_info.h          |  3 -
>  arch/arm/include/asm/uaccess.h              | 85 +++++++++++++++++++++++++++--
>  arch/arm/kernel/armksyms.c                  |  6 +-
>  arch/arm/kernel/entry-armv.S                | 27 ++++++---
>  arch/arm/kernel/entry-common.S              |  2 +
>  arch/arm/kernel/entry-header.S              | 42 ++++++++++++++
>  arch/arm/kernel/head.S                      |  5 +-
>  arch/arm/kernel/process.c                   | 37 ++++++++++---
>  arch/arm/kernel/traps.c                     |  1 -
>  arch/arm/lib/clear_user.S                   |  6 +-
>  arch/arm/lib/copy_from_user.S               |  6 +-
>  arch/arm/lib/copy_to_user.S                 |  6 +-
>  arch/arm/lib/uaccess_with_memcpy.c          |  4 +-
>  arch/arm/mm/mmu.c                           |  4 +-
>  arch/arm/mm/pgd.c                           | 10 ++++
>  19 files changed, 267 insertions(+), 57 deletions(-)
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Kees Cook
Chrome OS Security
