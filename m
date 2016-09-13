From: zhongjiang@huawei.com (zhong jiang)
Date: Tue, 13 Sep 2016 21:37:51 +0800
Subject: Qustion::  hungtask will come up when ksm enable.
Message-ID: <57D8012F.7080508@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I hit a following problem when run a oom case in ltp.  The kernel version is 4.1 stable.

[  601.937145] Call trace:
[  601.939600] [<ffffffc000086a88>] __switch_to+0x74/0x8c
[  601.944760] [<ffffffc000a1bae0>] __schedule+0x23c/0x7bc
[  601.950007] [<ffffffc000a1c09c>] schedule+0x3c/0x94
[  601.954907] [<ffffffc000a1eb84>] rwsem_down_write_failed+0x214/0x350
[  601.961289] [<ffffffc000a1e32c>] down_write+0x64/0x80
[  601.966363] [<ffffffc00021f794>] __ksm_exit+0x90/0x19c
[  601.971523] [<ffffffc0000be650>] mmput+0x118/0x11c
[  601.976335] [<ffffffc0000c3ec4>] do_exit+0x2dc/0xa74
[  601.981321] [<ffffffc0000c46f8>] do_group_exit+0x4c/0xe4
[  601.986656] [<ffffffc0000d0f34>] get_signal+0x444/0x5e0
[  601.991904] [<ffffffc000089fcc>] do_signal+0x1d8/0x450
[  601.997065] [<ffffffc00008a35c>] do_notify_resume+0x70/0x78

ksm_exit should take the write lock and wait all read lock is released. in fact,  but I find
ksmd still hold a read lock in scan_get_next_rmap_item.  thefefore, it will lead to hungtask.

Any suggestion will be appreciated.

Thanks
zhongjiang
