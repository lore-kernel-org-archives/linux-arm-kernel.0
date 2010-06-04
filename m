From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Jun 2010 20:13:32 -0400 (EDT)
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <AANLkTinKoGMzJBUhUkG9O--Q2sWbqaSgdHKTJ6QtrbOd@mail.gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<4C0818F9.9070008@bluewatersys.com>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<AANLkTinKoGMzJBUhUkG9O--Q2sWbqaSgdHKTJ6QtrbOd@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006031955510.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Jun 2010, Kyungmin Park wrote:

> If target has several variants with different memory size, different
> GPIOs. It's really hard to maintain and support.
> To address this issues. we implement the detect routine and give
> different system revision at bootloader side and kernel boot with this
> information. with this approaches I can support 5 different targets
> based on s5pc110.

Please have a look at arch/arm/mach-kirkwood/netspace_v2-setup.c for 
example.  This file contains the support for two boards already.  
They're supported by the same source files because they have lot of code 
in common.  but the differences are distinguished by the machine ID 
number passed into r1 by the bootloader used to select which machine 
record is selected.  The proper machine_init method within each of those 
machine records is called on boot, where a different table for GPIO 
initialization (it is called MPP on Kirkwood) is again selected.  All 
this is accomplished at run time.

If you want more complex GPIO config variants, have a look at mach-pxa/* 
where they're called MFP instead.

Memory size should normally be detected and passed along to the kernel 
by the bootloader.

> In previous time, we usually make a kernel for each boards but it's
> hard works and takes long time. So single kernel is best approaches
> and it's possible at least similar CPUs. e.g. samsung s5p series.
> 
> As I know s5pc110 (aka s5pv210) and s5p644x is similar and can
> possible to make single kernel.

Exact.  It is always a good idea to try to compile as many boards as 
possible in a single kernel, and then have the ability to optimize the 
kernel configuration in order to have the support for only one board 
built into the kernel if desired.


Nicolas
