From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 23 May 2017 03:51:11 -0700
Subject: [PATCH v2] arm64: kernel: restrict /dev/mem read() calls to
 linear region
In-Reply-To: <20170522174126.GJ1657@bivouac.eciton.net>
References: <20170519154200.14158-1-ard.biesheuvel@linaro.org>
 <20170522174126.GJ1657@bivouac.eciton.net>
Message-ID: <CAKv+Gu8vYP7xB5T_gFPvFQ6yiAprAMf5QfjqfhC8zbg4PwTMyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2017 at 10:41, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Fri, May 19, 2017 at 04:42:00PM +0100, Ard Biesheuvel wrote:
>> When running lscpu on an AArch64 system that has SMBIOS version 2.0
>> tables, it will segfault in the following way:
>>
>>   Unable to handle kernel paging request at virtual address ffff8000bfff0000
>>   pgd = ffff8000f9615000
>>   [ffff8000bfff0000] *pgd=0000000000000000
>>   Internal error: Oops: 96000007 [#1] PREEMPT SMP
>>   Modules linked in:
>>   CPU: 0 PID: 1284 Comm: lscpu Not tainted 4.11.0-rc3+ #103
>>   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>>   task: ffff8000fa78e800 task.stack: ffff8000f9780000
>>   PC is at __arch_copy_to_user+0x90/0x220
>>   LR is at read_mem+0xcc/0x140
>>
>> This is caused by the fact that lspci issues a read() on /dev/mem at the
>> offset where it expects to find the SMBIOS structure array. However, this
>> region is classified as EFI_RUNTIME_SERVICE_DATA (as per the UEFI spec),
>> and so it is omitted from the linear mapping.
>>
>> So let's restrict /dev/mem read/write access to those areas that are
>> covered by the linear region.
>
> So, I'm still of the opinion that /dev/mem simply should not be made
> available on systems where people care about accidentally hard-locking
> their systems from userland.
>
> To that extent, this workaround takes the pressure off people to
> configure their kernels properly.
>
> On the other hand, it probably removes 90% of the risk cases.
>

Sadly, no. This change only fixes a kernel bug where we access a
region using read()/write() that is known to be memory, but may have
been left unmapped. It does not affect /dev/mem uses involving mmap()
at all.

> I guess the solution depends on whether people think the remaining 10%
> matter.
>

I think there are two different aspects that we need to distinguish:
- on ARM, you cannot use /dev/mem to go looking for magic numbers in
memory to locate certain data structures left by the firmware,
- on ARM, you should [must] not use /dev/mem to map regions that are
already mapped with different attributes.

This fix is in neither category, it just fails read()s on /dev/mem
gracefully if they attempt to access NOMAP memory.

So the only moderately sane use case for /dev/mem on ARM is to do
cached accesses to DRAM regions that are covered by the linear
mapping. Interestingly, these are exactly the ones RESTRICT_DEVMEM
usually disallows IIRC, given that you may be poking into kernel
internals.

My vote would be to deprecate other /dev/mem uses on arm64, so that we
can start getting a handle on things before the cat is too far out of
the bag. (and you can't 'break' a x86 userspace this way on arm64 if
it was simply recompiled but pokes memory for legacy BIOS strings etc)
