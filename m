From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 15:45:23 +0000
Subject: iMX31 MBX registers Porting problem
In-Reply-To: <AANLkTi=EsCCwgiK5BtkKfaYEuzVUtnie-LU77cNJ4P4q@mail.gmail.com>
References: <AANLkTin+Mo9YXEfoDAa+btjX5VdiOz1QJp++ck0efPAk@mail.gmail.com>
	<20110131003128.GD27436@n2100.arm.linux.org.uk>
	<AANLkTi=EsCCwgiK5BtkKfaYEuzVUtnie-LU77cNJ4P4q@mail.gmail.com>
Message-ID: <20110131154523.GB32737@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 30, 2011 at 10:08:02PM -0700, Chris wrote:
> Ok, I did that and it inserts and removes an entry I am not sure about
> what would be wrong.
> 
> 0x7f000000-0x7f002000    8192 module_alloc_update_bounds+0x18/0x68
> pages=1 vmalloc
> ...
> 0x848a0000-0x848a5000   20480 reg_probe+0x94/0x12c [reg] ioremap
> 
> 0x7f006000-0x7f008000    8192 module_alloc_update_bounds+0x18/0x68
> pages=1 vmalloc
> ...
> 0x848a8000-0x848ad000   20480 reg_probe+0x94/0x12c [reg] ioremap
> 
> here are two insertions, also showing the module bounds update, not
> sure what to make of this information.

The 'module_alloc_update_bounds+0x18/0x68' entry is the space used for
your module.  As it is free'd lazily, each time you insert it you'll
get different virtual addresses.

> when I cat /proc/iomem I can see my entry:
>    c0000000-c0003fff : mx3_mbx_regs.0
> 
> how can I know that the mapping is pointing me to my location?

ioremap() always gives you a cookie for use with readl() et.al. or NULL.
If it's successful, the mapping will have been created and pointing at
the requested bus address.

I can't see anything wrong with your code, so I suspect you're missing
something with the hardware - maybe a clock which isn't running or an
enable bit somewhere?

I've no idea how MBX works on the MX platforms, so I can't really suggest
anything further.
