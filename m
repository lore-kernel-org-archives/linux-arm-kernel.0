From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Feb 2016 17:44:13 +0100
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu_bKeJiS0Ctd8QU2M7_SKfpDrA5hksqZgfPUwYqO_KrjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2016 at 17:06, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Feb 12, 2016 at 03:38:46PM +0000, Sudeep Holla wrote:
>>
>> On 12/02/16 15:26, Catalin Marinas wrote:
>> >On Fri, Feb 12, 2016 at 04:17:09PM +0100, Ard Biesheuvel wrote:
>> >>On 12 February 2016 at 16:10, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >>>On Fri, Feb 12, 2016 at 04:02:58PM +0100, Ard Biesheuvel wrote:
>> >>>>On 12 February 2016 at 15:58, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >>>>>On Mon, Feb 01, 2016 at 11:54:52AM +0100, Ard Biesheuvel wrote:
>> >>>>>>This moves the module area to right before the vmalloc area, and
>> >>>>>>moves the kernel image to the base of the vmalloc area. This is
>> >>>>>>an intermediate step towards implementing KASLR, which allows the
>> >>>>>>kernel image to be located anywhere in the vmalloc area.
>> >>>>>>
>> >>>>>>Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >>>>>
>> >>>>>This patch is causing lots of KASAN warnings on Juno (interestingly, it
>> >>>>>doesn't seem to trigger on Seattle, though we only tried for-next/core).
>> >>>>>I pushed the branch that I'm currently using here:
>> >>>>>
>> >>>>>git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/kernmap
>> >>>>>
>> >>>>>
>> >>>>>A typical error (though its place varies based on the config options,
>> >>>>>kernel layout):
>> >>>>>
>> >>>>>BUG: KASAN: stack-out-of-bounds in clockevents_program_event+0x28/0x1b0 at addr ffffffc936257cc8
>> >>>>
>> >>>>Can you confirm that these are stack accesses? I was having similar
>> >>>>errors before, and I ended up creating the kasan zero page patch
>> >>>>because it turned out the kasan shadow page in question was aliased
>> >>>>and the stack writes were occurring elsewhere.
>> >>>
>> >>>It's possible, we are looking into this. Is there any other patch I miss on
>> >>>the above branch?
>> >>
>> >>I don't think so but I will check
>> >
>> >Commit 7b1af9795773 ("arm64: kasan: ensure that the KASAN zero page is
>> >mapped read-only") was merged in -rc2 while the branch above is based on
>> >-rc1. Anyway, I merged it into -rc2 and the errors are similar.
>> >
>>
>> Sorry to add more confusion, but I observed similar KASAN warning
>> with latest mainline(v4.5-rc3+, commit c05235d50f68) with below diff.
>
> I can reproduce this with UBSAN enabled (log below for the record).
>
> So far, we have:
>
> KASAN+for-next/kernmap goes wrong
> KASAN+UBSAN goes wrong
>
> Enabled individually, KASAN, UBSAN and for-next/kernmap seem fine. I may
> have to trim for-next/core down until we figure out where the problem
> is.
>

I haven't managed to reproduce this yet on QEMU, Seattle or FVP, but I
did notice something that may or may not be related:
without my changes the memory map show this:

    kasan   : 0xffffff8000000000 - 0xffffff9000000000   (    64 GB)
    vmalloc : 0xffffff9000010000 - 0xffffffbdbfff0000   (   182 GB)

i.e., there is a 64 KB guard region between the shadow region and the
vmalloc region. I am not sure what it is for, but I realize now that I
accidentally removed it in my patch:

    kasan   : 0xffffff8000000000 - 0xffffff9000000000   (    64 GB)
    modules : 0xffffff9000000000 - 0xffffff9004000000   (    64 MB)
    vmalloc : 0xffffff9004000000 - 0xffffffbdbfff0000   (   182 GB)



>
> BUG: KASAN: stack-out-of-bounds in find_busiest_group+0x164/0x16a0 at addr ffffffc93665bc8c
> Read of size 4 by task swapper/3/0
> page:ffffffbde6d996c0 count:0 mapcount:0 mapping:          (null) index:0x0
> flags: 0x4000000000000000()
> page dumped because: kasan: bad access detected
> CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.5.0-rc3+ #134
> Hardware name: Juno (DT)
> Call trace:
> [<ffffffc00008f8f0>] dump_backtrace+0x0/0x358
> [<ffffffc00008fc5c>] show_stack+0x14/0x20
> [<ffffffc00069d0a8>] dump_stack+0x108/0x150
> [<ffffffc0003077f8>] kasan_report_error+0x690/0x970
> [<ffffffc0003082c0>] kasan_report+0x60/0xc0
> [<ffffffc00030634c>] __asan_load4+0x64/0x80
> [<ffffffc00015f714>] find_busiest_group+0x164/0x16a0
> [<ffffffc000160ea0>] load_balance+0x250/0x1450
> [<ffffffc0001630c0>] pick_next_task_fair+0x5d0/0xb40
> [<ffffffc000f08090>] __schedule+0x460/0xbc8
> [<ffffffc000f08870>] schedule+0x78/0x208
> [<ffffffc000f092d4>] schedule_preempt_disabled+0x3c/0xd8
> [<ffffffc000172208>] cpu_startup_entry+0x160/0x4c8
> [<ffffffc0000985b8>] secondary_start_kernel+0x280/0x428
> [<0000000080082e2c>] 0x80082e2c
> Memory state around the buggy address:
>  ffffffc93665bb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffc93665bc00: f1 f1 f1 f1 00 f4 f4 f4 f2 f2 f2 f2 00 00 f1 f1
>>ffffffc93665bc80: f1 f1 00 00 00 00 f3 f3 00 f4 f4 f4 f3 f3 f3 f3
>                       ^
>  ffffffc93665bd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffc93665bd80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 04 f4 f4 f4
>
> --
> Catalin
