From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 Jan 2016 17:43:41 +0100
Subject: [PATCH] arm64: allow vmalloc regions to be set with set_memory_*
In-Reply-To: <20160128150815.GG775@arm.com>
References: <1453125665-26627-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160128150815.GG775@arm.com>
Message-ID: <CAKv+Gu-GxicSKDq+Nm9H+dWrSVOhupozu4pZ=Pk7CzC_VrW=2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2016 at 16:08, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Jan 18, 2016 at 03:01:05PM +0100, Ard Biesheuvel wrote:
>> The range of set_memory_* is currently restricted to the module address
>> range because of difficulties in breaking down larger block sizes.
>> vmalloc maps PAGE_SIZE pages so it is safe to use as well. Update the
>> function ranges and add a comment explaining why the range is restricted
>> the way it is.
>>
>> Suggested-by: Laura Abbott <labbott@fedoraproject.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/mm/pageattr.c | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> What's the user for this? It would be better to apply along with something
> that actually needs to change permission for arbitrary vmalloc mappings.
>

BPF already uses set_memory_ro() but doesn't bother to check the return value.

Without the patch, I get:

root at ubuntu-arm64:~# grep bpf /proc/vmallocinfo
0xffff000000014000-0xffff000000016000    8192 bpf_prog_alloc+0x3c/0xb8
pages=1 vmalloc
0xffff00000017a000-0xffff00000017c000    8192 bpf_prog_alloc+0x3c/0xb8
pages=1 vmalloc
root at ubuntu-arm64:~# grep -E 0xffff000000014000\|0xffff00000017a000
/sys/kernel/debug/kernel_page_tables
0xffff000000014000-0xffff000000015000           4K     RW NX SHD AF
        UXN MEM/NORMAL
0xffff00000017a000-0xffff00000017b000           4K     RW NX SHD AF
        UXN MEM/NORMAL

and with:

root at ubuntu-arm64:~# grep bpf /proc/vmallocinfo
0xffff000000014000-0xffff000000016000    8192 bpf_prog_alloc+0x3c/0xb8
pages=1 vmalloc
0xffff00000017a000-0xffff00000017c000    8192 bpf_prog_alloc+0x3c/0xb8
pages=1 vmalloc
root at ubuntu-arm64:~# grep -E 0xffff000000014000\|0xffff00000017a000
/sys/kernel/debug/kernel_page_tables
0xffff000000014000-0xffff000000015000           4K     ro NX SHD AF
        UXN MEM/NORMAL
0xffff00000017a000-0xffff00000017b000           4K     ro NX SHD AF
        UXN MEM/NORMAL


> Anyway, with that (and a rebase to -rc2):
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>

Thanks
