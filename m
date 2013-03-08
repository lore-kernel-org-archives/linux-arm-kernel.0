From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 8 Mar 2013 02:42:48 +0000
Subject: [PATCH] xen: arm: mandate EABI and use generic atomic operations.
In-Reply-To: <20130307141445.GB14958@phenom.dumpdata.com>
References: <1362640645-26564-1-git-send-email-ian.campbell@citrix.com>
 <20130307141445.GB14958@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1303080241530.22839@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Mar 2013, Konrad Rzeszutek Wilk wrote:
> On Thu, Mar 07, 2013 at 07:17:25AM +0000, Ian Campbell wrote:
> > Rob Herring has observed that c81611c4e96f "xen: event channel arrays are
> > xen_ulong_t and not unsigned long" introduced a compile failure when building
> > without CONFIG_AEABI:
> > 
> > /tmp/ccJaIZOW.s: Assembler messages:
> > /tmp/ccJaIZOW.s:831: Error: even register required -- `ldrexd r5,r6,[r4]'
> > 
> > Will Deacon pointed out that this is because OABI does not require even base
> > registers for 64-bit values. We can avoid this by simply using the existing
> > atomic64_xchg operation and the same containerof trick as used by the cmpxchg
> > macros. However since this code is used on memory which is shared with the
> > hypervisor we require proper atomic instructions and cannot use the generic
> > atomic64 callbacks (which are based on spinlocks), therefore add a dependency
> > on !GENERIC_ATOMIC64. Since we already depend on !CPU_V6 there isn't much
> > downside to this.
> > 
> > While thinking about this we also observed that OABI has different struct
> > alignment requirements to EABI, which is a problem for hypercall argument
> > structs which are shared with the hypervisor and which must be in EABI layout.
> > Since I don't expect people to want to run OABI kernels on Xen depend on
> > CONFIG_AEABI explicitly too (although it also happens to be enforced by the
> > !GENERIC_ATOMIC64 requirement too).
> > 
> > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Rob Herring <robherring2@gmail.com>
> > Cc: Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Stefano, I need your Ack before I can put it in my tree for Linus.

It looks OK to me


Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
