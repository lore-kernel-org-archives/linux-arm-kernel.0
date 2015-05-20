From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Thu, 21 May 2015 01:04:24 +0200
Subject: [PATCH v8 01/16] scripts: link-vmlinux: Don't pass page offset
 to kallsyms if XIP Kernel
In-Reply-To: <CALszF6B0=dgSDfLFwDi9YmEzrrNVuYbUnqMu5DmDhhy--emtpw@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com>
 <CALszF6B0=dgSDfLFwDi9YmEzrrNVuYbUnqMu5DmDhhy--emtpw@mail.gmail.com>
Message-ID: <555D12F8.4000403@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 18.05.2015 um 13:47 schrieb Maxime Coquelin:
> 2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
>> When Kernel is executed in place from ROM, the symbol addresses can be
>> lower than the page offset.
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

This issue was reported by Stefan Agner in 2014 for the VF610 [1], not
sure if I asked already whether there should be a Reported-by line?
Stefan, have you had a chance to test this patch?

Back then on STM32F4 I debugged that disabling KALLSYMS works around it.

Now on a different XIP target I have confirmed this patch to help show a
stacktrace (my clk driver was missing some CLK_DIVIDER_ALLOW_ZEROs) ...
although my earlyprintk serial output still gets stuck further down the
stacktrace - probably unrelated.

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/clk/clk-divider.c:126
divider_recalc_rate+0x2b/0x44()
[    0.000000] SYS: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
4.1.0-rc4-next-20150519+ #23
[    0.000000] Hardware name: XMC4000 (Device Tree Support)
[    0.000000] [<0800bd5d>] (unwind_backtrace) from [<0800b0cb>]
(show_stack+0xb/0xc)
[    0.000000] [<0800b0cb>] (show_stack) from [<0800e0a5>]
(warn_slowpath_common+0x55/0x78)
[    0.000000] [<0800e0a5>] (warn_slowpath_common) from [<0800e103>]
(warn_slowpath_fmt+0x1b/0x24)
[    0.000000] [<0800e103>] (warn_slowpath_fmt) from [<080942e3>] (divide

But this is definitely an improvement for ARMv7-M debugging,

Tested-by: Andreas F?rber <afaerber@suse.de>

> [Hi Michal, ...] could you consider
> taking it for v4.2?

Regards,
Andreas

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307297.html

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150521/cb0d9366/attachment-0001.sig>
