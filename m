From: wangnan0@huawei.com (Wangnan (F))
Date: Tue, 5 Jan 2016 13:06:15 +0800
Subject: [PATCH v2] arm64: Store breakpoint single step state into pstate
In-Reply-To: <20160104165535.GI1616@arm.com>
References: <1450860731-194418-1-git-send-email-wangnan0@huawei.com>
 <1450921362-198371-1-git-send-email-wangnan0@huawei.com>
 <20160104165535.GI1616@arm.com>
Message-ID: <568B4F47.5080307@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2016/1/5 0:55, Will Deacon wrote:
> Hello,
>
> On Thu, Dec 24, 2015 at 01:42:42AM +0000, Wang Nan wrote:

[SNIP]

> The problem seems to be that we take the debug exception before the
> breakpointed instruction has been executed and call perf_bp_event at
> that moment, so when we single-step the faulting instruction we actually
> step into the SIGIO handler and end up getting stuck.
>
> Your fix doesn't really address this afaict, in that you don't (can't?)
> handle:
>
>    * A longjmp out of a signal handler
>    * A watchpoint and a breakpoint that fire on the same instruction
>    * User-controlled single-step from a signal handler that enables a
>      breakpoint explicitly
>    * Nested signals

Please have a look at [1], which I improve test__bp_signal() to
check bullet 2 and 4 you mentioned above. Seems my fix is correct.

[1] 
http://lkml.kernel.org/g/1451969880-14877-1-git-send-email-wangnan0 at huawei.com

Thank you.
