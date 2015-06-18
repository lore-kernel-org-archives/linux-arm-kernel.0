From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 18 Jun 2015 16:28:35 +0200
Subject: ARMADA-XP cpu1 .. cpu3 does not come online
In-Reply-To: <20150618142233.GL7557@n2100.arm.linux.org.uk>
References: <20150618123833.GA28005@t440.home> <20150618133607.GB312@lunn.ch>
 <20150618142233.GL7557@n2100.arm.linux.org.uk>
Message-ID: <20150618142835.GF312@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 03:22:33PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 18, 2015 at 03:36:07PM +0200, Andrew Lunn wrote:
> > > Uncompressing Linux... done, booting the kernel.                               
> > > [    0.000000] Booting Linux on physical CPU 0x0                               
> > > [    0.000000] Linux version 4.0.5-00001-g8b87c3c (peter at t440) (gcc version 4.95
> > > [    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c5387d 
> > > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache 
> > > [    0.000000] Machine model: AXP-TEST-BOARD 
> > > [    0.000000] bootconsole [earlycon0] enabled
> > > [    0.000000] Truncating RAM at 0x00000000-0xffffffff to -0x2f800000 
> > > 
> > > ^^ This is worrying to me, firstly because memory is being truncated down, secondly because my dts file only specifies memory from 0x00000000 to 0xf000000 (see attached dts file)
> > 
> > 0x2f800000 suggests you have an old boot loader, with IO at
> > 0xd000,0000. Upgrading to a newer uboot will allow you to use more of
> > the 4G of RAM. It might also fix your SMP issue.
> 
> No.  The 0x2f800000 comes from having more than 0x2f800000 bytes of memory
> and having highmem disabled.  It's got nothing to do with boot loaders at
> all.
> 
> The way this works is that sanity_check_meminfo() looks at the base of
> the vmalloc() area.  If PAGE_OFFSET + memory_size results in memory above
> the vmalloc() area, and highmem is disabled, sanity_check_meminfo()
> truncates the memory to that limit and reports the above message.

Hi Russell

Thanks for the explanation.

I think at one point x86 used to print a hint about enabling HIGHMEM.
Is it worth adding something similar?

   Andrew
