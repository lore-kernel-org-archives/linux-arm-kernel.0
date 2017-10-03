From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 3 Oct 2017 15:21:27 +0200
Subject: [PATCH] ARM: cpuidle: Avoid memleak if init fail
In-Reply-To: <1504211076-2331-1-git-send-email-stefan.wahren@i2se.com>
References: <1504211076-2331-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <d785929a-a6af-b803-d34d-a7138102f55f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/2017 22:24, Stefan Wahren wrote:
> In case there are no DT idle states defined or
> cpuidle_register_driver() fails, the copy of the idle driver is leaked:
> 
>     unreferenced object 0xede0dc00 (size 1024):
>     comm "swapper/0", pid 1, jiffies 4294937431 (age 744.510s)
>     hex dump (first 32 bytes):
>     94 9e 0b c1 00 00 00 00 00 00 00 00 00 00 00 00 ................
>     57 46 49 00 00 00 00 00 00 00 00 00 00 00 00 00 WFI.............
>     backtrace:
>     [<c1295f04>] arm_idle_init+0x44/0x1ac
>     [<c0301e6c>] do_one_initcall+0x3c/0x16c
>     [<c1200d70>] kernel_init_freeable+0x110/0x1d0
>     [<c0cb3624>] kernel_init+0x8/0x114
>     [<c0307a98>] ret_from_fork+0x14/0x3c
> 
> So fix this by freeing the unregistered copy in error case.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition")
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
