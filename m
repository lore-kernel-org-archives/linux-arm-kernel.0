From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 5 Mar 2013 03:45:24 +0000
Subject: [PATCH LINUX v5] xen: event channel arrays are xen_ulong_t and
 not unsigned long
In-Reply-To: <20130305030436.GA18040@mudshark.cambridge.arm.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361360886-2956-1-git-send-email-ian.campbell@citrix.com>
 <51340ACD.70904@gmail.com>
 <20130305030436.GA18040@mudshark.cambridge.arm.com>
Message-ID: <1362455124.8941.19.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-03-05 at 03:04 +0000, Will Deacon wrote:
> Hi guys,
> 
> On Mon, Mar 04, 2013 at 02:45:33AM +0000, Rob Herring wrote:
> > On 02/20/2013 05:48 AM, Ian Campbell wrote:
> > > On ARM we want these to be the same size on 32- and 64-bit.
> > > 
> > > This is an ABI change on ARM. X86 does not change.
> > > 
> > > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > > Cc: Jan Beulich <JBeulich@suse.com>
> > > Cc: Keir (Xen.org) <keir@xen.org>
> > > Cc: Tim Deegan <tim@xen.org>
> > > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: xen-devel at lists.xen.org
> > > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> [...]
> 
> > I'm seeing some some build failures on randconfig builds with this change:
> > 
> > /tmp/ccJaIZOW.s: Assembler messages:
> > /tmp/ccJaIZOW.s:831: Error: even register required -- `ldrexd r5,r6,[r4]'
> > 
> > This is with ubuntu 12.04 cross compiler (gcc version 4.6.3
> > (Ubuntu/Linaro 4.6.3-1ubuntu5)).
> > 
> > This register restriction is on ARM, but not Thumb builds. Comparing
> > this to atomic64_cmpxchg, I don't see how to fix this. Perhaps Will or
> > Nico have thoughts.
> 
> [...]
> 
> > > +	asm volatile("@ xchg_xen_ulong\n"
> > > +		"1:     ldrexd  %0, %H0, [%3]\n"
> > > +		"       strexd  %1, %2, %H2, [%3]\n"
> > > +		"       teq     %1, #0\n"
> > > +		"       bne     1b"
> > > +		: "=&r" (oldval), "=&r" (tmp)
> > > +		: "r" (val), "r" (ptr)
> > > +		: "memory", "cc");
> 
> I also can't immediately see why GCC would allocate oldval to an odd base
> register. Can you share your .config please?

I fixed something along these lines before v5 of this patch, although I
must confess I don't recall what it was that I changed (and looking at
the older versions of the patch isn't giving me any clues). I can't
reproduce it now though :-(

I'm using the 4.6.3 cross compiler from kernel.org:
ftp://ftp.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/

Ian.
