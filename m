From: huawei.libin@huawei.com (Li Bin)
Date: Tue, 26 Apr 2016 16:23:19 +0800
Subject: [BUG] arm64/hw_breakpoint: trigger breakpoint exception infinitely
Message-ID: <571F2577.2080203@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bug can be reproduced by compiling the hw_breakpoint sample
module that is in the kernel tree, when loading it with parameter
ksym=nfsdstats, and running nfsstat:

$ insmod data_breakpoint.ko ksym=nfsdstats
$ nfsstat

It will trigger breakpoint exception infinitely:

nfsdstats value is changed
...
Call trace:
...
Dump stack from sample_hbp_handler
nfsdstats value is changed
...
Call trace:
...
Dump stack from sample_hbp_handler
......
......

This is because that the overflow_handler is set to the callback
in the module, and in watchpoint_handler, it will not disable the
breakpoint (and set single step that reenable it), so when exception
return, it will trigger the breakpoint exception again immediately...


Li Bin
