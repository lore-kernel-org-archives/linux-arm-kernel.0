From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 10 Dec 2010 18:55:53 -0700 (MST)
Subject: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific
	accessor/mutatorfunctions
In-Reply-To: <0adb8bf19a1586d582ac168dcbfc4f5e@mail.gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
	<20101208061829.30541.99531.stgit@twilight.localdomain>
	<0adb8bf19a1586d582ac168dcbfc4f5e@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1012101839460.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Dec 2010, Santosh Shilimkar wrote:

> One more possible road block of removing the direct register access
> from PM code is DEVICE PRM module. Even with this clean-up for DEVCIE
> PRM related registers. I guess we still need to use the lowest level
> APIs.

To clarify my comments, I'm not talking about replacing omap4_prm_*() with 
omap4_prminst_*() for the device PRM cases.  I agree that is not 
desirable.  What I'd like to see is for the middle-level PM code, such as 
pm*.c, to call functions that describe what they are actually trying to do 
at a higher level, rather than writing to registers directly.

I'll take the PRM_VOLTSETUP* registers as a rough example.  This may be a 
bad example since we probably don't write to this directly from pm*.c any 
more, but the basic idea is, rather than writing some mystery value to a 
register from the pm*.c code, we should write something like:

int omap4_prm_regulator_set_ramp_up_duration(u32 ns, u8 starting_pwrst);

which would then take care of computing the prescaler and count values 
appropriately given the current sys_clk and writing them to the register 
or returning an error if something is wrong.

The long-term goal is to be able to reuse as much PM code as possible 
between all of the different OMAP2+ platforms.


- Paul
