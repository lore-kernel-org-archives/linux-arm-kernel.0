From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Wed, 11 Jul 2018 21:06:27 +0530
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <cb5cf891-cf46-3afc-0c77-6667165caf7a@arm.com>
References: <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
 <3a05cd0e-466e-4fb6-a78a-4b363e21aaab@arm.com>
 <CACi5LpMJnFthKUJGfMWgDyMTM65oTtOvsRGCtMDjWP32qDptbQ@mail.gmail.com>
 <92ff5220-f863-4edc-bc9f-bd802d2efa9c@arm.com>
 <d5e01f4bedc649ff8a2ee17b17c1c33d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619085541.GB13984@arm.com>
 <6860c284f1c74faa95edd6cf866ec80d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619094045.GD13984@arm.com>
 <a720d91be20844cd9ed84728268300d9@HXTBJIDCEMVIW02.hxtcorp.net>
 <09260c7e-8b9d-bc3c-5bca-0fd75417f552@arm.com>
 <CACi5LpMoKP4eG5XhYe5hf5VC9MOY8KuHK=j0ujb8GFpyjAuAww@mail.gmail.com>
 <b0d40351-8d78-fd69-cc87-d5ea5eaabd2a@arm.com>
 <CACi5LpM2GV-vwcEGeCE20QW0PVmDcKnjz017sYBAwYRfZ24AzA@mail.gmail.com>
 <51cf54d6a19f4837b74218b000cc23bc@HXTBJIDCEMVIW02.hxtcorp.net>
 <CACi5LpMXpSWUP97R2VWjf==LdxPBCKTcpKjQjCs4j3Kz9SzYGg@mail.gmail.com>
 <cb5cf891-cf46-3afc-0c77-6667165caf7a@arm.com>
Message-ID: <CACi5LpMRSuLEA0BSnbaxmQNZOdyp19XZEJK1AHntxTvnuquj_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Wed, Jul 11, 2018 at 6:54 PM, James Morse <james.morse@arm.com> wrote:
> Hi Bhupesh,
>
> (CC: +Omar)
>
> On 20/06/18 08:26, Bhupesh Sharma wrote:
>> On Wed, Jun 20, 2018 at 7:46 AM, Jin, Yanjiang
>> <yanjiang.jin@hxt-semitech.com> wrote:
>>>> From: Bhupesh Sharma [mailto:bhsharma at redhat.com]
>>>> On Tue, Jun 19, 2018 at 4:56 PM, James Morse <james.morse@arm.com> wrote:
>>>>> I'm suggesting adding the contents of vmcoreinfo as a PT_NOTE section
>>>>> of /proc/kcore's ELF header. No special knowledge necessary, any
>>>>> elf-parser should be able to dump the values.
>
> [..]
>>>> I am working on fixes on the above lines for kernel and user-space tools (like
>>>> makedumpfile, crash-utility and kexec-tools).
>>>>
>>>> I will post some RFC patches on the same lines (or come back in case I get stuck
>>>> somewhere) shortly.
>
> I spotted this series from Omar:
> https://lkml.org/lkml/2018/7/6/866
>
> Hopefully it does what you need?

Thanks a lot for sharing this useful series.

BTW, I am sorry for taking a long time to reply to this thread, but I
was reading some x86_64/ppc legacy code and also experimenting with
approaches in both user-space and kernel-space and have some
interesting updates.

Just to recap, there are two separate issues we are seeing with arm64
with user-space utilities which are used for debugging live systems or
crashed kernels:

- Availability of PHYS_OFFSET in user-space (both for KASLR and
non-KASLR boot cases):

I see two approaches to fix this issue:
1. Fix inside Kernel:
a). See <https://www.spinics.net/lists/kexec/msg20847.html> for
background details. Having PHY_OFFSET added to the '/proc/kcore' as a
PT_NOTE (it is already added to vmcore as a NUMBER) would suffice.

b). Omar's series add the vmcoreinfo to the kcore itself, so it would
be sufficient for the above case as well, since PHYS_OFFSET is already
added to the vmcoreinfo inside 'arch/arm64/kernel/machine_kexec.c':

void arch_crash_save_vmcoreinfo(void)
{
    <..snip..>
    vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
                        PHYS_OFFSET);
    <..snip..>
}

c). This will help the cases where we are debugging a 'live' (or
running system).

2. Fix inside user-space:
a). See as an example a flaky reference implementation in
'kexec-tools': See
<https://github.com/bhupesh-sharma/kexec-tools/commit/e8f920158ce57399c770c7160711a72fc740f1d6>
 - Note that the calculation of 'ARM64_MEMSTART_ALIGN' value in
user-space is quite tricky (as is evident from the above
implementation and I took an easy route for my specific PAGE_SIZE and
VA_BITS combination).

b). For some user-space tools like crash and makedumpfile, the
underlying macros like PMD_SHIFT etc have been added as arch-specific
code, so they can handle such implementation better.

c). But this again means adding more arch specific code to user-space,
which probably not advisable.

So, we will be better suited to go with a KERNEL fix for this case and
Omar's series should help. I will go ahead and give it a try for
arm64.

- Availability of PAGE_OFFSET in user-space (both for KASLR and
non-KASLR boot cases):

1. I had a look at the legacy x86_64 and ppc64 code for some of the
user-space tools on how they handle and calculate the PAGE_OFFSET.

a). As an example lets consider the case of 'makedumpfile' tool which
determines the PAGE_OFFSET for x86_64 from the PT_LOAD segments inside
'/proc/kcore':

static int
get_page_offset_x86_64(void)
{
    <..snip..>
    if (get_num_pt_loads()) {
        for (i = 0;
            get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
            i++) {
            if (virt_start != NOT_KV_ADDR
                    && virt_start < __START_KERNEL_map
                    && phys_start != NOT_PADDR) {
                info->page_offset = virt_start - phys_start;
                return TRUE;
            }
        }
    }
    <..snip..>
}

b). Note the values of the macros used in above computation:

#define __START_KERNEL_map    (0xffffffff80000000)
#define NOT_KV_ADDR    (0x0)
#define NOT_PADDR    (ULONGLONG_MAX)

2. I have a working approach (completely user-space, no kernel changes
needed) in place for makedumpfile:
<https://github.com/bhupesh-sharma/makedumpfile/commit/18c1c9d798c3efc89b07c731365a0a0a57764003>,
using a similar approach as the one listed for x86_64 above:

int
get_versiondep_info_arm64(void)
{
    <..snip..>
    if (get_num_pt_loads()) {
        for (i = 0;
            get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
            i++) {
            if (virt_start != NOT_KV_ADDR
                    && virt_start < __START_KERNEL_map
                    && phys_start != NOT_PADDR && phys_start !=
0x0000000010a80000) {
                info->page_offset = virt_start - phys_start;
                return TRUE;
            }
        }
    }
    <..snip..>
}

a). Note the values of the macros used in above computation:

#define __START_KERNEL_map    (0xffffffff80000000)
#define NOT_KV_ADDR    (0x0)
#define NOT_PADDR    (ULONGLONG_MAX)

I also need an additional check of 'phys_start != 0x0000000010a80000'
for arm64 on my qualcomm board.

This works both for KASLR and non-KASLR cases and with all the
combinations of PAGE_SIZE (4K and 64K) and VA_BITS (42 bits and 48
bits).

Just for reference, here are the contents of '/proc/kcore' on this system:

# readelf -l /proc/kcore

Elf file type is CORE (Core file)
Entry point 0x0
There are 33 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000000778 0x0000000000000000 0x0000000000000000
                 0x000000000000134c 0x0000000000000000         0x0
  LOAD           0x00000085c2c90000 0xfffffc85c2c80000 0x0000000010a80000
                 0x0000000001b90000 0x0000000001b90000  RWE    0x10000
  LOAD           0x0000000008010000 0xfffffc0008000000 0xffffffffffffffff
                 0x000001ff57ff0000 0x000001ff57ff0000  RWE    0x10000
  LOAD           0x0000000000010000 0xfffffc0000000000 0xffffffffffffffff
                 0x0000000008000000 0x0000000008000000  RWE    0x10000
  LOAD           0x0000026f80830000 0xfffffe6f80820000 0x0000000000820000
                 0x0000000002820000 0x0000000002820000  RWE    0x10000
  LOAD           0x000001ff9be10000 0xfffffdff9be00000 0xffffffffffffffff
                 0x0000000000010000 0x0000000000010000  RWE    0x10000
  LOAD           0x0000026f830a0000 0xfffffe6f83090000 0x0000000003090000
                 0x0000000000050000 0x0000000000050000  RWE    0x10000
  LOAD           0x0000026f83180000 0xfffffe6f83170000 0x0000000003170000
                 0x0000000000090000 0x0000000000090000  RWE    0x10000
  LOAD           0x0000026f83420000 0xfffffe6f83410000 0x0000000003410000
                 0x0000000000040000 0x0000000000040000  RWE    0x10000
  LOAD           0x0000026f834c0000 0xfffffe6f834b0000 0x00000000034b0000
                 0x00000000000b0000 0x00000000000b0000  RWE    0x10000
  LOAD           0x0000026f83650000 0xfffffe6f83640000 0x0000000003640000
                 0x0000000000040000 0x0000000000040000  RWE    0x10000
  LOAD           0x0000026f866b0000 0xfffffe6f866a0000 0x00000000066a0000
                 0x0000000000080000 0x0000000000080000  RWE    0x10000
  LOAD           0x000001ff9be20000 0xfffffdff9be10000 0xffffffffffffffff
                 0x0000000000010000 0x0000000000010000  RWE    0x10000
  LOAD           0x0000026f87070000 0xfffffe6f87060000 0x0000000007060000
                 0x0000000000280000 0x0000000000280000  RWE    0x10000
  LOAD           0x0000026f87390000 0xfffffe6f87380000 0x0000000007380000
                 0x00000000000b0000 0x00000000000b0000  RWE    0x10000
  LOAD           0x0000026f88250000 0xfffffe6f88240000 0x0000000008240000
                 0x0000000000070000 0x0000000000070000  RWE    0x10000
  LOAD           0x000001ff9be30000 0xfffffdff9be20000 0xffffffffffffffff
                 0x0000000000010000 0x0000000000010000  RWE    0x10000
  LOAD           0x0000026f882f0000 0xfffffe6f882e0000 0x00000000082e0000
                 0x0000000000010000 0x0000000000010000  RWE    0x10000
  LOAD           0x0000026f88310000 0xfffffe6f88300000 0x0000000008300000
                 0x0000000000040000 0x0000000000040000  RWE    0x10000
  LOAD           0x0000026f88a00000 0xfffffe6f889f0000 0x00000000089f0000
                 0x0000000000040000 0x0000000000040000  RWE    0x10000
  LOAD           0x0000026f88a60000 0xfffffe6f88a50000 0x0000000008a50000
                 0x0000000000020000 0x0000000000020000  RWE    0x10000
  LOAD           0x0000026f88aa0000 0xfffffe6f88a90000 0x0000000008a90000
                 0x0000000000020000 0x0000000000020000  RWE    0x10000
  LOAD           0x0000026f88fd0000 0xfffffe6f88fc0000 0x0000000008fc0000
                 0x0000000004fe0000 0x0000000004fe0000  RWE    0x10000
  LOAD           0x0000026f8dfe0000 0xfffffe6f8dfd0000 0x000000000dfd0000
                 0x0000000002030000 0x0000000002030000  RWE    0x10000
  LOAD           0x000001ff9be40000 0xfffffdff9be30000 0xffffffffffffffff
                 0x0000000000010000 0x0000000000010000  RWE    0x10000
  LOAD           0x0000026f90810000 0xfffffe6f90800000 0x0000000010800000
                 0x00000000077f0000 0x00000000077f0000  RWE    0x10000
  LOAD           0x000001ff9be50000 0xfffffdff9be40000 0xffffffffffffffff
                 0x0000000000020000 0x0000000000020000  RWE    0x10000
  LOAD           0x0000026f9c020000 0xfffffe6f9c010000 0x000000001c010000
                 0x00000000007f0000 0x00000000007f0000  RWE    0x10000
  LOAD           0x000001ff9be80000 0xfffffdff9be70000 0xffffffffffffffff
                 0x0000000000010000 0x0000000000010000  RWE    0x10000
  LOAD           0x0000026f9c820000 0xfffffe6f9c810000 0x000000001c810000
                 0x00000000627b0000 0x00000000627b0000  RWE    0x10000
  LOAD           0x0000026ffeff0000 0xfffffe6ffefe0000 0x000000007efe0000
                 0x0000000000010000 0x0000000000010000  RWE    0x10000
  LOAD           0x000001ff9c000000 0xfffffdff9bff0000 0xffffffffffffffff
                 0x0000000000010000 0x0000000000010000  RWE    0x10000
  LOAD           0x0000026fff010000 0xfffffe6fff000000 0x000000007f000000
                 0x0000001781000000 0x0000001781000000  RWE    0x10000

b). The above approach works fine for me with multiple user-space
utils, so probably we don't need a kernel fix for this case and can
calculate PAGE_OFFSET in user-space via PT_LOAD 'virt_start -
phys_start' manipulation.

Please share your views.

Regards,
Bhupesh
