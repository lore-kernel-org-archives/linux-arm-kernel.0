From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 8 Feb 2016 19:29:26 +0100
Subject: [PATCH] arm64: allow the module region to be randomized
 independently
In-Reply-To: <20160208181305.GW6076@e104818-lin.cambridge.arm.com>
References: <CAGXu5j+1rcScYedzQ5o0aaGZJWPCBGk-gai0D8jY8Huc-VuG7A@mail.gmail.com>
 <1454926332-25929-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160208181305.GW6076@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-qKgT4VhsWs7gVDCbpi_Or6RruhQ+iRMXJFQrwithSyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 February 2016 at 19:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Feb 08, 2016 at 11:12:12AM +0100, Ard Biesheuvel wrote:
>> This adds the option to randomize the module region independently from the
>> core kernel, and enables it by default. This makes it less likely that the
>> location of core kernel data structures can be determined by an adversary,
>> but causes all function calls from modules into the core kernel to be
>> resolved via entries in the module PLTs.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/Kconfig              | 15 ++++++++
>>  arch/arm64/include/asm/module.h |  6 ++++
>>  arch/arm64/kernel/kaslr.c       | 36 +++++++++++++++-----
>>  arch/arm64/kernel/module.c      |  9 ++---
>>  4 files changed, 50 insertions(+), 16 deletions(-)
>
> With this patch I get an unhandled paging request, coming from
> kernel/module.c:2982 (the memset). The PC is wrongly attributed but it's
> in arch/arm64/lib/memset.S:
>

That is quite surprising tbh. The only thing that is supposed to
happen here is that the low and high limits of the
__vmalloc_node_range() call in module_alloc() are modified. I don't
see how a successful __vmalloc_node_range() call should end up here.

I will try to reproduce tomorrow.

-- 
Ard.


> [    7.140606] Unable to handle kernel paging request at virtual address 00004000
> [    7.147794] pgd = ffffffc060171000
> [    7.151190] [00004000] *pgd=0000000000000000, *pud=0000000000000000
> [    7.157447] Internal error: Oops: 96000045 [#1] PREEMPT SMP
> [    7.162962] Modules linked in:
> [    7.165995] CPU: 1 PID: 875 Comm: systemd-modules Not tainted 4.5.0-rc1+ #95
> [    7.172976] Hardware name: Juno (DT)
> [    7.176520] task: ffffffc9760bb000 ti: ffffffc079538000 task.ti: ffffffc079538000
> [    7.183939] PC is at __efistub_memset+0x1ac/0x200
> [    7.188601] LR is at load_module+0xfc8/0x1df8
> [    7.192912] pc : [<ffffff8008336fac>] lr : [<ffffff8008120d88>] pstate: 40000145
> [    7.200233] sp : ffffffc07953bd40
> [    7.203514] x29: ffffffc07953bd40 x28: 0000000000002361
> [    7.208791] x27: ffffff80086bb000 x26: ffffff8008f84aa0
> [    7.214054] x25: 0000000000000111 x24: 000000000000006e
> [    7.219317] x23: 0000007f7bc01918 x22: ffffff8008f0e100
> [    7.224580] x21: ffffff8008f4d2c0 x20: 0000000000004000
> [    7.229855] x19: ffffffc07953be70 x18: 0000000000000000
> [    7.235127] x17: 0000000000000000 x16: 0000000000000002
> [    7.240398] x15: ffffffffffffffff x14: ffffff0000000000
> [    7.245667] x13: ffffffbdc3e55340 x12: 0000000000006fff
> [    7.250934] x11: ffffffc97fed46a8 x10: 0000000000000010
> [    7.256198] x9 : 0000000000000000 x8 : 0000000000004000
> [    7.261462] x7 : 0000000000000000 x6 : 000000000000003f
> [    7.266823] x5 : 0000000000000040 x4 : 0000000000000000 [    7.271219] systemd-journald[864]: Received request to flush runtime journal from PID 1
>
> [    7.279835]
> [    7.281487] x3 : 0000000000000004 x2 : 000000000000229e
> [    7.286758] x1 : 0000000000000000 x0 : 0000000000004000
> [    7.292019]
> [    7.293495] Process systemd-modules (pid: 875, stack limit = 0xffffffc079538020)
> [    7.300822] Stack: (0xffffffc07953bd40 to 0xffffffc07953c000)
> [    7.306522] bd40: ffffffc07953be40 ffffff8008121de0 0000000000000000 0000000000000005
> [    7.314276] bd60: 0000007f7bc01918 0000007f7bb24ad4 0000000080000000 0000000000000015
> [    7.322029] bd80: 000000000000011e 0000000000000111 ffffff80086b0000 ffffffc079538000
> [    7.329781] bda0: 0000000000000000 0000000000000005 0000007f7bc01918 0000007f7bb24ad4
> [    7.337536] bdc0: ffffff8008f0e288 ffffff8008f84ae0 ffffff8008f0e2d8 ffffff8008f0d000
> [    7.345288] bde0: ffff81a40000000f 0000000000000001 0000000000000000 0000000000077b20
> [    7.353041] be00: 0000000056b8d7f8 00000000134c2b98 0000000056b8d7f8 000000001163e398
> [    7.360793] be20: 0000000056b8d7f8 000000001163e398 0000000000001000 00000000000003c0
> [    7.368545] be40: 0000000000000000 ffffff8008085d30 0000000000000000 0000000000000000
> [    7.376298] be60: ffffffffffffffff 0000005571c2aa60 ffffff8008f0d000 0000000000077b20
> [    7.384051] be80: ffffff8008f84120 ffffff8008f4b7af ffffff8008f4d2c0 0000000000001388
> [    7.391803] bea0: 0000000000001dd8 0000000000000000 0000000000000000 0000002700000026
> [    7.399555] bec0: 0000000000000011 000000000000000b 0000000000000005 0000007f7bc01918
> [    7.407307] bee0: 0000000000000000 0000000000000005 0000000000000000 60ceffffffffffff
> [    7.415060] bf00: ffffffffffffffff ffffffffffffffff 0000000000000111 0000000000000038
> [    7.422812] bf20: 0101010101010101 0000000000000001 0000000000000000 ffffffffffff0000
> [    7.430565] bf40: 0000007f7bc43000 0000007f7ba626b8 0000007f7bb24ab0 0000007f7bc132d8
> [    7.438317] bf60: 0000005565850710 0000005571c2a8a0 0000000000000000 0000007f7bc01918
> [    7.446069] bf80: 0000005571c2a920 0000000000020000 0000000000000000 0000000000000000
> [    7.453821] bfa0: 0000005571c29330 0000000000000000 0000000000000000 0000007ff3bc1e80
> [    7.461575] bfc0: 0000007f7bbfa1ac 0000007ff3bc1e80 0000007f7bb24ad4 0000000080000000
> [    7.469327] bfe0: 0000000000000005 0000000000000111 f712e45f3fdb5baf 5d70fcf3d73b5fa3
> [    7.477075] Call trace:
> [    7.479494] Exception stack(0xffffffc07953bb80 to 0xffffffc07953bca0)
> [    7.485871] bb80: ffffffc07953be70 0000000000004000 ffffffc07953bd40 ffffff8008336fac
> [    7.493624] bba0: 0000000000400000 00000000024000c0 ffffffc975853300 00c8000000000713
> [    7.501376] bbc0: ffffff80086bb000 0000000000002361 0000000000004000 0000000000000000
> [    7.509128] bbe0: ffffffc07953bc60 ffffff80081885d8 ffffffc07953bca0 ffffff8008187fb8
> [    7.516880] bc00: 0000000000000003 ffffffc975853480 00000000ffffffff 00000000024002c0
> [    7.524631] bc20: 0000000000004000 0000000000000000 000000000000229e 0000000000000004
> [    7.532383] bc40: 0000000000000000 0000000000000040 000000000000003f 0000000000000000
> [    7.540135] bc60: 0000000000004000 0000000000000000 0000000000000010 ffffffc97fed46a8
> [    7.547888] bc80: 0000000000006fff ffffffbdc3e55340 ffffff0000000000 ffffffffffffffff
> [    7.555646] [<ffffff8008336fac>] __efistub_memset+0x1ac/0x200
> [    7.561334] [<ffffff8008121de0>] SyS_finit_module+0xb0/0xc0
> [    7.566852] [<ffffff8008085d30>] el0_svc_naked+0x24/0x28
> [    7.572112] Code: 91010108 54ffff4a 8b040108 cb050042 (d50b7428)
> [    7.578196] ---[ end trace 13bd770b734da68a ]---
>
> --
> Catalin
