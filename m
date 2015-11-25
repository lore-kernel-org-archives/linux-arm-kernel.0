From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Nov 2015 17:51:37 -0800
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <3811106.btnGdZynet@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <6359949.bhCrxaQvmL@wuerfel>
 <20151123231352.GH19156@codeaurora.org>
 <3811106.btnGdZynet@wuerfel>
Message-ID: <20151125015137.GA11298@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Arnd Bergmann wrote:
> On Monday 23 November 2015 15:13:52 Stephen Boyd wrote:
> > On 11/23, Arnd Bergmann wrote:
> > > 
> > > - PJ4/PJ4B (not PJ4B-MP) has a different custom opcode for udiv and sdiv
> > >   in ARM mode. We don't support that with true multiplatform kernels
> > >   because those opcodes work nowhere else, though with your proposed
> > >   series we could easily do that for dynamic patching.
> > 
> > Do you have the information on these custom opcodes? I can work
> > that into the patches assuming the MIDR is different.
> 
> Thomas Petazzoni said this in a private mail:
> 
> | According to the datasheet, the PJ4B has integer signed and unsigned
> | divide, similar to the sdiv and udiv ARM instructions. But the way to
> | access it is by doing a MRC instruction.
> |
> |    MRC<cond> p6, 1, Rd , CRn , CRm, 4
> |
> |for PJ4B is the same as:
> |
> |    SDIV Rd , Rn, Rm
> |
> | on ARM cores.
> |
> |And:
> |
> |    MRC<cond> p6, 1, Rd , CRn , CRm, 0
> |
> |for PJ4B is the same as:
> |
> |    UDIV Rd , Rn, Rm
> |
> |on ARM cores.
> |
> |This is documented in the "Extended instructions" section of the
> |PJ4B datasheet.
> 
> I assume what he meant was that this is true for both PJ4 and PJ4B
> but not for PJ4B-MP, which has the normal udiv/sdiv instructions.
> 
> IOW, anything with CPU implementer 0x56 part 0x581 should use those,
> while part 0x584 can use the sdiv/udiv that it reports correctly.
> 

It looks like we have some sort of function that mostly does
this, except it doesn't differentiate on that lower bit for 1 vs
4. I guess I'll write another one for that.

static inline int cpu_is_pj4(void)
{
        unsigned int id;

        id = read_cpuid_id();
        if ((id & 0xff0fff00) == 0x560f5800)
                return 1;

        return 0;
}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
