From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Feb 2016 14:58:44 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Mon, Feb 01, 2016 at 11:54:52AM +0100, Ard Biesheuvel wrote:
> This moves the module area to right before the vmalloc area, and
> moves the kernel image to the base of the vmalloc area. This is
> an intermediate step towards implementing KASLR, which allows the
> kernel image to be located anywhere in the vmalloc area.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This patch is causing lots of KASAN warnings on Juno (interestingly, it
doesn't seem to trigger on Seattle, though we only tried for-next/core).
I pushed the branch that I'm currently using here:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/kernmap


A typical error (though its place varies based on the config options,
kernel layout):

BUG: KASAN: stack-out-of-bounds in clockevents_program_event+0x28/0x1b0 at addr ffffffc936257cc8
Read of size 8 by task swapper/2/0
page:ffffffbde6d895c0 count:0 mapcount:0 mapping:          (null) index:0x0
flags: 0x4000000000000000()
page dumped because: kasan: bad access detected
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.5.0-rc1+ #130
Hardware name: Juno (DT)
Call trace:
[<ffffff900408b590>] dump_backtrace+0x0/0x258
[<ffffff900408b7fc>] show_stack+0x14/0x20
[<ffffff900448789c>] dump_stack+0xac/0x100
[<ffffff9004224f3c>] kasan_report_error+0x544/0x570
[<ffffff9004225328>] kasan_report+0x40/0x48
[<ffffff9004223c58>] __asan_load8+0x60/0x78
[<ffffff90041596f0>] clockevents_program_event+0x28/0x1b0
[<ffffff900415c63c>] tick_program_event+0x74/0xb8
[<ffffff9004148944>] __remove_hrtimer+0xcc/0x100
[<ffffff9004148f0c>] hrtimer_start_range_ns+0x3f4/0x538
[<ffffff900415d450>] __tick_nohz_idle_enter+0x558/0x590
[<ffffff900415d74c>] tick_nohz_idle_enter+0x44/0x78
[<ffffff900411fcc8>] cpu_startup_entry+0x48/0x2c0
[<ffffff9004091f58>] secondary_start_kernel+0x208/0x278
[<0000000080082aac>] 0x80082aac
Memory state around the buggy address:
 ffffffc936257b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc936257c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
>ffffffc936257c80: f1 f1 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00
                                              ^
 ffffffc936257d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc936257d80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1


And some additional info from the kernel boot:

Processing EFI memory map:
  0x000008000000-0x00000bffffff [Memory Mapped I/O  |RUN|  |  |  |  |  |   |  |  |  |UC]
  0x00001c170000-0x00001c170fff [Memory Mapped I/O  |RUN|  |  |  |  |  |   |  |  |  |UC]
  0x000080000000-0x00008000ffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x000080010000-0x00008007ffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x000080080000-0x00008149ffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0000814a0000-0x00009fdfffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x00009fe00000-0x00009fe0ffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x00009fe10000-0x0000dfffffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0000e00f0000-0x0000febd5fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0000febd6000-0x0000febd9fff [ACPI Reclaim Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]*
  0x0000febda000-0x0000febdafff [ACPI Memory NVS    |   |  |  |  |  |  |   |WB|WT|WC|UC]*
  0x0000febdb000-0x0000febdcfff [ACPI Reclaim Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]*
  0x0000febdd000-0x0000feffffff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x000880000000-0x0009f8794fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009f8795000-0x0009f8796fff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009f8797000-0x0009f9bb4fff [Loader Code        |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009f9bb5000-0x0009faf6efff [Boot Code          |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009faf6f000-0x0009fafa9fff [Runtime Data       |RUN|  |  |  |  |  |   |WB|WT|WC|UC]*
  0x0009fafaa000-0x0009ff2b1fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009ff2b2000-0x0009ffb70fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009ffb71000-0x0009ffb89fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009ffb8a000-0x0009ffb8dfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009ffb8e000-0x0009ffb8efff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009ffb8f000-0x0009ffdddfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009ffdde000-0x0009ffe76fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009ffe77000-0x0009fff6dfff [Boot Code          |   |  |  |  |  |  |   |WB|WT|WC|UC]
  0x0009fff6e000-0x0009fffaefff [Runtime Code       |RUN|  |  |  |  |  |   |WB|WT|WC|UC]*
  0x0009fffaf000-0x0009ffffefff [Runtime Data       |RUN|  |  |  |  |  |   |WB|WT|WC|UC]*
  0x0009fffff000-0x0009ffffffff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]


Memory: 7068520K/8371264K available (10424K kernel code, 3464K rwdata, 5284K rodata, 1016K init, 380K bss, 1286360K reserved, 16384K cma-reserved)
Virtual kernel memory layout:
    kasan   : 0xffffff8000000000 - 0xffffff9000000000   (    64 GB)
    modules : 0xffffff9000000000 - 0xffffff9004000000   (    64 MB)
    vmalloc : 0xffffff9004000000 - 0xffffffbdbfff0000   (   182 GB)
      .init : 0xffffff9004fd9000 - 0xffffff90050d7000   (  1016 KB)
      .text : 0xffffff9004080000 - 0xffffff9004fd9000   ( 15716 KB)
      .data : 0xffffff90050d7000 - 0xffffff9005439200   (  3465 KB)
    vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
              0xffffffbdc2000000 - 0xffffffbde8000000   (   608 MB actual)
    fixed   : 0xffffffbffe7fd000 - 0xffffffbffec00000   (  4108 KB)
    PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe00000   (    16 MB)
    memory  : 0xffffffc000000000 - 0xffffffc980000000   ( 38912 MB)

-- 
Catalin
