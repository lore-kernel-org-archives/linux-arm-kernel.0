From: alxmtvv@gmail.com (Alex Matveev)
Date: Thu, 16 Nov 2017 22:54:34 +0000
Subject: [PATCH v2 11/18] arm64: make mrs_s and msr_s macros work with LTO
In-Reply-To: <20171116212920.wixsxoccznyef4aq@yury-thinkpad>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-12-samitolvanen@google.com>
 <20171116115433.GG9361@arm.com>
 <20171116130742.wijnukjetoupi4hc@yury-thinkpad>
 <c0c19191-e090-4768-3c46-b813713d2908@arm.com>
 <20171116212920.wixsxoccznyef4aq@yury-thinkpad>
Message-ID: <20171116225434.691af6cf@delmar.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Nov 2017 00:29:20 +0300
Yury Norov <ynorov@caviumnetworks.com> wrote:

> On Thu, Nov 16, 2017 at 01:55:31PM +0000, Robin Murphy wrote:
> > Given that this whole mrs_s infrastructure is a workaround for older
> > assemblers which don't support the "S<op0>_<op1>_<Cn>_<Cm>_<op2>"
> > syntax for arbitrary unnamed system registers (which IIRC was a
> > fairly late addition to the architecture), the only way it could be
> > "fixed" on the toolchain side is by removing all those older
> > toolchains from existence. Good luck with that ;)
> > 
> > In *theory*, it might be possible to do something similar to what
> > we do with CONFIG_BROKEN_GAS_INST to detect offending assemblers
> > and only define and use these macros when necessary (hopefully
> > Clang and other LTO-capable toolchains do accept the proper
> > syntax), but I've no idea how invasive or difficult that might turn
> > out to be.  
> 
> Thank you Robin. The "S<op0>_<op1>_<Cn>_<Cm>_<op2>" is the feature I
> was looking for. I'm not going to remove old toolchain from every user
> machine - I believe if I do, I'll be put into jail finally. :)
> 
> But I think we should use this syntax for {read,write}_sysreg_s
> and other functions if assembler supports it. The existing mrs_s/msr_s
> machinery will be deprecated then, and it will be generally good.

Well, "S<op>_..." is how registers were accessed before implementation
of mrs_s/msr_s - here's the patch from mid-2014 by Catalin Marinas:

commit 72c583951526
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Thu Jul 24 14:14:42 2014 +0100

    arm64: gicv3: Allow GICv3 compilation with older binutils
    
    GICv3 introduces new system registers accessible with the full
    msr/mrs syntax (e.g. mrs x0, Sop0_op1_CRm_CRn_op2). However, only
    recent binutils understand the new syntax. This patch introduces
    msr_s/mrs_s assembly macros which generate the equivalent
    instructions above and converts the existing GICv3 code (both
    drivers/irqchip/ and arch/arm64/kernel/).

The question is - is it OK to drop compatibility with old versions of
binutils (which were already "older" back in 2014)? It's not my call to
make. If yes, then it should be possible to make this change more
aesthetic by reverting to "S<op>" (however, it will affect more places
as now some users of register definitions expect them to be numbers, not
"S<op>" strings).

Going the way of CONFIG_BROKEN_GAS_INST and selecting between "S<op>"
and mrs_s/msr_s is also possible, but then we'd have to keep both
mechanisms around. I'm not quite sure what that would give us.

Regards,
Alex
