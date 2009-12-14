From: wd@denx.de (Wolfgang Denk)
Date: Mon, 14 Dec 2009 14:57:22 +0100
Subject: "ARM: MX3: fix CPU revision number detection" breaks QONG support
In-Reply-To: <20091211234714.GT28375@buzzloop.caiaq.de>
References: <20091211143318.1D8B43F6CC@gemini.denx.de>
	<20091211234714.GT28375@buzzloop.caiaq.de>
Message-ID: <20091214135722.CBCBF4C026@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel Mack,

In message <20091211234714.GT28375@buzzloop.caiaq.de> you wrote:
> 
> Yes, Vaentin Lonchamp (cc) also reported that problem. The problem seems
> to be related to things the bootloader does to your board, and I'm not
> sure yet where the difference is between the MX31 LiteKit and others. My
> suspect was that the clocks are not set up properly, but they have been
> reported to be ok. What fails is a single register access. Maybe access
> to this function block needs to be enabled or unlocked or something?

I don't think this is a boot loader issue.

In Linux, the kernel hangs here:

	/* read SREV register from IIM module */
	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);

In U-Boot, I can read this register just fine:

	=> md 5001c024 1
	5001c024: 00000028    (...

In Linux, the IO_ADDRESS() makes this a read from 0xFC11C024, which
hangs.

So if this is a clock thing, then it must be a clock being disabled by
Linux.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
But the only way of discovering the limits  of  the  possible  is  to
venture a little way past them into the impossible.
                         - _Profiles of the Future_ (1962; rev. 1973)
                  ``Hazards of Prophecy: The Failure of Imagination''
