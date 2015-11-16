From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 Nov 2015 15:57:36 -0500 (EST)
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <20151116181718.GW8644@n2100.arm.linux.org.uk>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <20151116181718.GW8644@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1511161550370.5826@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Nov 2015, Russell King - ARM Linux wrote:

> Nico,
> 
> As you originally created the XIP stuff, I hope you can remember
> the details - can you check this patch please?
> 
> I'm thinking that we need a new symbol around here:
> 
> #ifdef CONFIG_XIP_KERNEL
>         __data_loc = ALIGN(4);          /* location in binary */
> 					<=== here
>         . = PAGE_OFFSET + TEXT_OFFSET;
> #else
> 
> to denote the end of the XIP kernel image which must remain
> accessible after boot.  We don't need the data sections because
> they will have been copied to RAM, and we probably don't want to
> keep those exposed (it's potentially useful for attackers.)

The _etext symbol is already used for that purpose.

Now we round it up to the next section mapping which might leave quite a 
lot of data content exposed in ROM.  But given it is more or less the 
same data present in RAM except for those bits that are modified at run 
time, I don't see what an attacker would gain from the data in ROM   
that cannot already be obtained from kernel RAM.  If the section mapping 
extends to part of the ROM that is no longer kernel data then maybe this 
would expose sensitive data.  Is that what you're worried about?


Nicolas
