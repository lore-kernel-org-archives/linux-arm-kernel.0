From: b.a.stenning@gmail.com (Bruce Stenning)
Date: Mon, 12 Dec 2011 11:18:45 +0000
Subject: Bad page state BUG triggered by init process (kernel 3.1.2)
Message-ID: <CAN_pD_CfXh=savgYk21vo8+5E8ScfSgVsu7m4VjBLVwdPop+SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a bad page state BUG triggered during the running of 'init' on our ARM
board (iop13xx) running busybox.  I have manually added the symbols associated
with the kernel addresses in the stack trace:

Freeing init memory: 124K
Setting up root file system indirection
BUG: Bad page state in process busybox  pfn:00000
page:c0291000 count:0 mapcount:0 mapping:  (null) index:0x0
page flags: 0x200(arch_1)
Function entered at [<c0016b84>] from [<c0058024>] -- unwind_backtrace
Function entered at [<c0058024>] from [<c005846c>] -- bad_page
Function entered at [<c005846c>] from [<c0058b14>] -- get_page_from_freelist
Function entered at [<c0058b14>] from [<c005b434>] -- __alloc_pages_nodemask
Function entered at [<c005b434>] from [<c005b7f0>] -- __do_page_cache_readahead
Function entered at [<c005b7f0>] from [<c0054df4>] -- ra_submit
Function entered at [<c0054df4>] from [<c0068440>] -- filemap_fault
Function entered at [<c0068440>] from [<c006aea0>] -- __do_fault
Function entered at [<c006aea0>] from [<c006b398>] -- handle_pte_fault
Function entered at [<c006b398>] from [<c0017b14>] -- handle_mm_fault
Function entered at [<c0017b14>] from [<c0008370>] -- do_page_fault
Function entered at [<c0008370>] from [<c0011834>] -- do_PrefetchAbort
Exception stack(0xdf993fb0 to 0xdf993ff8)
3fa0:                                     00008ed4 00000005 bebe8e84 00008074
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00066810 bebe8e78 00000000 00060858 00000010 ffffffff
Disabling lock debugging due to kernel taint
(.) (..) (bin) (cmd) /cmd -> /jffs/cmd
(dev) (etc) /etc -> /jffs/etc

This is with the 3.1.2 Linux kernel.  It does not happen with the 2.6.39.4
kernel.  This seems to be the only time this BUG_ON triggers.

It looks somewhat similar to the problem fixed in the following commit:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=b962a286e500c6259af8ba133361f8528eed9172

Has anyone else seen this, and is there a fix to address it?

Kind Regards,

Bruce Stenning,
b <dot> a <dot> stenning <at> gmail <dot> com
