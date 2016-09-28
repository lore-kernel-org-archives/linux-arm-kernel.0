From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Sep 2016 18:12:10 +0100
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <c7675b74-982d-d8b6-935f-a74139820174@redhat.com>
References: <20160921170403.GE12180@e104818-lin.cambridge.arm.com>
 <20160922032328.GB29470@localhost.localdomain>
 <20160922165030.GA27704@e104818-lin.cambridge.arm.com>
 <20160923041230.GC29470@localhost.localdomain>
 <20160923130528.GE2161@e104818-lin.cambridge.arm.com>
 <CAHB_GupuUYPNFoYQeX8EhAcesvqKVVuphuxneudZ5kL2cxm-7g@mail.gmail.com>
 <20160926110159.GB27498@e104818-lin.cambridge.arm.com>
 <20160926130359.GA9370@localhost.localdomain>
 <20160927135133.GF17336@e104818-lin.cambridge.arm.com>
 <c7675b74-982d-d8b6-935f-a74139820174@redhat.com>
Message-ID: <20160928171210.GC29934@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2016 at 08:33:25PM +0530, Pratyush Anand wrote:
> On Tuesday 27 September 2016 07:21 PM, Catalin Marinas wrote:
> >There is also the is_trap_at_addr() function which uses is_trap_insn().
> >I haven't checked the call paths here, are there any implications if
> >is_trap_insn() always returns false?
> 
> I had looked into it and also tested that a tracepoint at an application
> having a same instruction as that of "uprobe break instruction" ie "BRK
> #0x5" is rejected. So, I think a false positive return from is_tarp_insn()
> is still OK.

Looking at handle_swbp(), if we hit a breakpoint for which we don't have
a valid uprobe, this function currently sends a SIGTRAP. But if
is_trap_insn() returns false always, is_trap_at_addr() would return 0 in
this case so the SIGTRAP is never issued.

-- 
Catalin
