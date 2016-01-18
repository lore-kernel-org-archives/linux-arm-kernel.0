From: dvyukov@google.com (Dmitry Vyukov)
Date: Mon, 18 Jan 2016 20:44:11 +0100
Subject: [PATCH v2] kernel: add kcov code coverage
In-Reply-To: <20160118141352.GM21067@leverpostej>
References: <1452689318-107172-1-git-send-email-dvyukov@google.com>
 <CAPAsAGx_0pVjtKA2RwwpStRG2-L+5X6W14QbrQaMYhdg30EeAQ@mail.gmail.com>
 <CACT4Y+bHjfkrZ4jWZf+j6FKnj2GQv1t94Y9LJm4=WFyb8C0J8w@mail.gmail.com>
 <CAPAsAGzjX2OJ7SRt4gM1VqEEm5=xERUtfcEDi05o5bwOTdNhpQ@mail.gmail.com>
 <CACT4Y+YvL_L9a2dBfoXQ0AKpKmnypfObtt7k97j_i2Qiu=wnQg@mail.gmail.com>
 <20160118141352.GM21067@leverpostej>
Message-ID: <CACT4Y+ZdtKTM8Nrko_oweTDYF+SF7+A78-UG8YeoqEcreWRVwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 3:13 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jan 15, 2016 at 03:07:59PM +0100, Dmitry Vyukov wrote:
>> On Fri, Jan 15, 2016 at 2:05 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>> > 2016-01-14 17:30 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>> >> On Thu, Jan 14, 2016 at 11:50 AM, Andrey Ryabinin
>> >> <ryabinin.a.a@gmail.com> wrote:
>> >>> 2016-01-13 15:48 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>> >>>
>> >>>> +       /* Read number of PCs collected. */
>> >>>> +       n = __atomic_load_n(&cover[0], __ATOMIC_RELAXED);
>> >>>> +       /* PCs are shorten to uint32_t, so we need to restore the upper part. */
>> >>>> +       for (i = 0; i < n; i++)
>> >>>> +               printf("0xffffffff%0lx\n", (unsigned long)cover[i + 1]);
>> >>
>> >> Thanks for the review!
>> >> Mailed v3 with fixes.
>> >> Comments inline.
>> >>
>> >>> This works only for x86-64.
>> >>> Probably there is no simple way to make this arch-independent with
>> >>> 32-bit values.
>> >>
>> >> We probably could add an ioctl that returns base of the stripped PCs.
>> >
>> > You forgot about modules. With stripped PCs you'll start mixing
>> > kernel's and module's PC (if distance between module and kernel > 4G).
>>
>> It's just that on x86 text and modules are within 4GB.
>>
>> I've checked that on arm64 it also seems to be the case:
>>
>>  48  * The module space lives between the addresses given by TASK_SIZE
>>  49  * and PAGE_OFFSET - it must be within 128MB of the kernel text.
>>  50  */
>>  54 #define MODULES_END             (PAGE_OFFSET)
>>  55 #define MODULES_VADDR           (MODULES_END - SZ_64M)
>
> This won't necessarily remain true. With kASLR [1,2] the modules and
> kernel might be located anywhere in the vmalloc area, independently.
> Using PLTs removes the +/-128MB restriction, so they may be placed
> anywhere in the vmalloc area.
>
> On my defconfig kernel (4KiB, 39-bit VA) today, that area is ~246GiB wide:
>
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vmalloc : 0xffffff8000000000 - 0xffffffbdbfff0000   (   246 GB)
> [    0.000000]     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
> [    0.000000]               0xffffffbdc2000000 - 0xffffffbde8000000   (   608 MB actual)
> [    0.000000]     fixed   : 0xffffffbffa7fd000 - 0xffffffbffac00000   (  4108 KB)
> [    0.000000]     PCI I/O : 0xffffffbffae00000 - 0xffffffbffbe00000   (    16 MB)
> [    0.000000]     modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
> [    0.000000]     memory  : 0xffffffc000000000 - 0xffffffc980000000   ( 38912 MB)
> [    0.000000]       .init : 0xffffffc000a00000 - 0xffffffc000a9c000   (   624 KB)
> [    0.000000]       .text : 0xffffffc000080000 - 0xffffffc000a00000   (  9728 KB)
> [    0.000000]       .data : 0xffffffc000a9c000 - 0xffffffc000b17a00   (   495 KB)
>
> Kernels can be built with a 48-bit VA (and potentially larger in future
> with ARMv8.2-A or later [3]). The vmalloc area (and hence the maximum
> distances between modules and kernel) will increase grow with the VA
> range.
>
> Thanks,
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398527.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398534.html
> [3] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution


Thanks, Mark.

I've got several comments regarding the 4-byte compressed PCs. We've
also discussed this internally.
As the result in v4 I made it possible to export both compressed
4-byte PCs and full 8-byte PCs.
Now init ioctl accepts the following struct and kernel can say whether
it will export 4- or 8-byte PCs:

struct kcov_init_trace {
        unsigned long        flags; /* In: reserved, must be 0. */
        unsigned long        size; /* In: trace buffer size. */
        unsigned long        version;  /* Out: trace format, currently 1. */
        /*
         * Output.
         * pc_size can be 4 or 8. If pc_size = 4 on a 64-bit arch,
         * returned PCs are compressed by subtracting pc_base and then
         * truncating to 4 bytes.
         */
        unsigned long        pc_size;
        unsigned long        pc_base;
};

So for KASLR or other archs we can just export full 8-byte PCs.

Regarding KASLR and dynamically loaded modules. I've looked at my
use-case and concluded
that most of the time I can work with "non-stable" PCs within a single
VM. Whenever I need to
store PCs persistently or send to another machine, I think I can
"canonicalize" PCs using
/proc/modules and /proc/kallsyms to something like (module hash,
module offset). So kernel does
not need to do this during coverage collection.
