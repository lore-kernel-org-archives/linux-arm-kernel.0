From: bbb.lst@gmail.com (Bjoern Brandenburg)
Date: Sun, 30 May 2010 21:04:03 -0400
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <1275259589.22752.14.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
	<20100530073652.GX2695@buzzloop.caiaq.de>
	<AANLkTimUF5iiGnc6RnN5C3sy-R6DAqHZNf6ZEu2o3W9P@mail.gmail.com>
	<AANLkTikdvjg52v-3AKUBukGO2FCp3fENGoYgpZZ2xVtT@mail.gmail.com>
	<AANLkTilMtEpt5hRfF_hszpU_AxZm7H93bkhqUacGWZc9@mail.gmail.com>
	<1275259589.22752.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTim4e5Sdj9tronOiI-sIMVGaUQdfRIhKHzZ4XfKp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 30, 2010 at 6:46 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Sun, 2010-05-30 at 22:38 +0100, Bjoern Brandenburg wrote:
>> On Sun, May 30, 2010 at 5:05 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
>> > On Sun, May 30, 2010 at 3:27 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
>> >>
>> >> I'll try to see if I can pinpoint what was dropped between 2.6.33-arm1
>> >> and 2.6.34-arm.
>> >
>> > Progress: I can get 2.6.34-arm to boot with all 4 CPUs after
>> > cherry-picking the following commits (which seemed relevant but
>> > absent):
>> >
>> > 60060ca ARM: Handle instruction cache maintenance fault ?properly
>> > 3f64e83 ARM errata: Eviction Buffer not empty after Cache Sync on L220
>> > 3b009b5 ARM: change definition of cpu_relax() for ARM11MPCore
>> >
>> > Let's see which is the critical one...
>>
>> It's 3f64e83 "ARM errata: Eviction Buffer not empty after Cache Sync
>> on L220" [1]. With this commit cherry-picked (on top of the 'rebased'
>> branch in ARM's repository, i.e., 2.6.34-arm), the system boots to X11
>> and runs some simple FS tests; the other ones don't make a difference.
>>
>> Are there plans for getting this and the other patches in the
>> 'rebased' branch into mainline (for .35 or .36)?
>
> Thanks for the investigation. I recall I got something similar in the
> past though I could no longer reproduce it with 2.6.34 (-arm) on the
> PB11MPCore I have. Could you try reverting commit e7c5650f606 (ARM:
> Change the mandatory barriers implementation) on a vanilla 2.6.34
> kernel?

That doesn't seem to help. v2.6.34 with e7c5650f606 reverted still hangs.

Looking up port of RPC 100003/3 on 152.2.128.169
Looking up port of RPC 100005/3 on 152.2.128.169
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing init memory: 148K
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
nfs: server 152.2.128.169 not responding, still trying
INFO: task init:1 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
init          D c03429a0     0     1      0 0x00000000
[<c03429a0>] (schedule+0x228/0x5f8) from [<c0342dc4>] (io_schedule+0x54/0x84)
[<c0342dc4>] (io_schedule+0x54/0x84) from [<c0098b1c>] (sync_page+0x50/0x5c)
[<c0098b1c>] (sync_page+0x50/0x5c) from [<c034316c>]
(__wait_on_bit_lock+0x6c/0xb8)
[<c034316c>] (__wait_on_bit_lock+0x6c/0xb8) from [<c0098aa4>]
(__lock_page+0x94/0xac)
[<c0098aa4>] (__lock_page+0x94/0xac) from [<c0098ccc>]
(find_lock_page+0x50/0x68)
[<c0098ccc>] (find_lock_page+0x50/0x68) from [<c0099404>]
(filemap_fault+0x1a0/0x420)
[<c0099404>] (filemap_fault+0x1a0/0x420) from [<c00afde8>]
(__do_fault+0x54/0x49c)
[<c00afde8>] (__do_fault+0x54/0x49c) from [<c00b10f8>]
(handle_mm_fault+0x114/0x898)
[<c00b10f8>] (handle_mm_fault+0x114/0x898) from [<c00381e4>]
(do_page_fault+0x208/0x300)
[<c00381e4>] (do_page_fault+0x208/0x300) from [<c002d4f4>]
(do_DataAbort+0x34/0x98)
[<c002d4f4>] (do_DataAbort+0x34/0x98) from [<c002e080>]
(ret_from_exception+0x0/0x10)
Exception stack(0xdfc3dfb0 to 0xdfc3dff8)
dfa0:                                     400f5776 400e4000 001406e8 4001ef60
dfc0: 400e9260 4001eb80 400f8ea8 00000002 0000017a 40027548 402246e8 bed80b24
dfe0: 00008002 bed80a68 40003cfc 4000bba8 20000010 ffffffff
INFO: task init:1 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
init          D c03429a0     0     1      0 0x00000000
[<c03429a0>] (schedule+0x228/0x5f8) from [<c0342dc4>] (io_schedule+0x54/0x84)
[<c0342dc4>] (io_schedule+0x54/0x84) from [<c0098b1c>] (sync_page+0x50/0x5c)
[<c0098b1c>] (sync_page+0x50/0x5c) from [<c034316c>]
(__wait_on_bit_lock+0x6c/0xb8)
[<c034316c>] (__wait_on_bit_lock+0x6c/0xb8) from [<c0098aa4>]
(__lock_page+0x94/0xac)
[<c0098aa4>] (__lock_page+0x94/0xac) from [<c0098ccc>]
(find_lock_page+0x50/0x68)
[<c0098ccc>] (find_lock_page+0x50/0x68) from [<c0099404>]
(filemap_fault+0x1a0/0x420)
[<c0099404>] (filemap_fault+0x1a0/0x420) from [<c00afde8>]
(__do_fault+0x54/0x49c)
[<c00afde8>] (__do_fault+0x54/0x49c) from [<c00b10f8>]
(handle_mm_fault+0x114/0x898)
[<c00b10f8>] (handle_mm_fault+0x114/0x898) from [<c00381e4>]
(do_page_fault+0x208/0x300)
[<c00381e4>] (do_page_fault+0x208/0x300) from [<c002d4f4>]
(do_DataAbort+0x34/0x98)
[<c002d4f4>] (do_DataAbort+0x34/0x98) from [<c002e080>]
(ret_from_exception+0x0/0x10)
Exception stack(0xdfc3dfb0 to 0xdfc3dff8)
dfa0:                                     400f5776 400e4000 001406e8 4001ef60
dfc0: 400e9260 4001eb80 400f8ea8 00000002 0000017a 40027548 402246e8 bed80b24
dfe0: 00008002 bed80a68 40003cfc 4000bba8 20000010 ffffffff

2.6.35-rc1 also doesn't boot.

Anything else that I should try? I'd be happy to help out with testing
patches; it'd be nice to have our box working with a vanilla kernel in
the future.

Thanks,
Bj?rn
