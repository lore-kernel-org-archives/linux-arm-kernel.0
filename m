From: tj@kernel.org (Tejun Heo)
Date: Mon, 04 Jan 2010 07:49:56 +0900
Subject: [PATCH] stack2core: show stack message and convert it to core
	file 	when kernel die
In-Reply-To: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
Message-ID: <4B411F14.1040302@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2010 12:05 AM, Hui Zhu wrote:
> Hello,
> 
> For, when the kernel die, the user will get some message like:
> PC is at kernel_init+0xd4/0x104
> LR is at _atomic_dec_and_lock+0x48/0x6c
> pc : [<c0008470>]    lr : [<c01911f8>]    psr: 60000013
> sp : c7823fd8  ip : c7823f48  fp : c7823ff4
> Stack: (0xc7823fd8 to 0xc7824000)
> 3fc0:                                                       00000000 00000001
> Backtrace:
> [<c000839c>] (kernel_init+0x0/0x104) from [<c0042660>] (do_exit+0x0/0x880)
> This backtrace have some wrong message sometime and cannot get any
> val. Of course, kdump can get more message.  But it need do some a lot
> of other config.
> 
> The stack2core function, can let kernel show stack message when kernel
> die.  This stack message can be convert to core file by program s2c
> (tools/s2c).  Then gdb can show the message in this core file.

FWIW, I love it.  I used to have to match the assembly to the source
code manually to find out which register and stack space meant what.
This will be very helpful in decoding oops message, but I think that
it would be far more useful if it uses the existing oops messages
instead of adding extra messages.  The new messages don't add any new
information and the oops message is already quite long and scrolls off
the screen on certain configurations.  Adding new configuration option
and making oops message longer will make acquiring the information
quite more difficult.

If implementing parsing of oops message in C is too awkward
(unsurprising at all), maybe implementing a converter in perl or
python is the easiest way so that it takes the oops message and puts
out well formatted input for the s2c program?

thanks.

-- 
tejun
