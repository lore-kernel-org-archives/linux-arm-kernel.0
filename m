From: slash.tmp@free.fr (Mason)
Date: Thu, 30 Jul 2015 15:58:53 +0200
Subject: arch/arm/kernel/setup.c does not compile at -O0
In-Reply-To: <55BA2335.706@arm.com>
References: <55BA1E62.9080103@free.fr> <55BA2335.706@arm.com>
Message-ID: <55BA2D9D.1070402@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/2015 15:14, Robin Murphy wrote:

> On 30/07/15 13:53, Mason wrote:
> 
>> Any idea how I can get DS-5 to properly handle local variables?
> 
> I carry a patch locally reverting 2062afb4f804 - at least on arm64, the 
> debugger manages to resolve optimised locals considerably better without 
> the -fno-var-tracking-assignments option. The Kconfig "Generate dwarf4 
> debug info" option is a good idea, and "Generate readable assembly code" 
> sometimes helps a bit too.

I reverted 2062afb4f804 (I'm using 4.9.3 so I think it's safe)

AFAICT, config DEBUG_INFO_DWARF4 isn't available in 3.14
(I think bfaf2dd3509b was included in 3.16)

But the problem seems to be on a higher level. My debugger
just doesn't see ANY local variable whatsoever.

For example, if I break in serial8250_probe, step past the
initializations, then the Eclipse "Variables" tab states
Locals: 0 variables (as it does everywhere, mind you).

If I try to print from the "Commands" tab:

print p
ERROR(EXP8): Could not find the symbol "p"
print irqflag
ERROR(EXP8): Could not find the symbol "irqflag"

I'm doing wrong something fundamental.

This is my work flow:

Start the system, interrupt it in Uboot
Connect the DS-5 probe
Set a HW breakpoint at the address of start_kernel
Let Uboot load the kernel
When the breakpoint is hit, load the symbols with:
  add-symbol-file /opt/linux-3.14/vmlinux

=> Is vmlinux supposed to contain the debug info for the
local variables? (I mean 'automatic' variables, in the
C sense.)

> Whilst in general -O0 isn't going to work, I've had some success using 
> "__attribute__ ((optimize(0)))" on individual functions of interest.

This will work at the function granularity?

Regards.
