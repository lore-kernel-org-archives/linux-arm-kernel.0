From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Dec 2015 19:03:37 +0000
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <20151201021615.GA5704@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
Message-ID: <20151201190337.GG29045@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 07:46:15AM +0530, Pratyush Anand wrote:
> Hi Geoff,
> 
> On 30/11/2015:10:51:15 AM, Geoff Levand wrote:
> > Hi,
> > 
> > On Fri, 2015-11-27 at 18:43 +0530, Pratyush Anand wrote:
> > 
> > > On 24/11/2015:10:25:34 PM, Geoff Levand wrote:
> > > > +> > 	> > /* Test the entry flags. */
> > > > +.Ltest_source:
> > > > +> > 	> > tbz> > 	> > x18, IND_SOURCE_BIT, .Ltest_indirection
> > > > +
> > > > +> > 	> > mov x20, x13> > 	> > 	> > 	> > 	> > /*  x20 = copy dest */
> > > > +> > 	> > mov x21, x12> > 	> > 	> > 	> > 	> > /*  x21 = copy src */
> > > 
> > > Till v10 we had here invalidation for relocated destination page to PoC. I could
> > > not understand, why it was removed. Removing that piece of code breaks kexec
> > > booting with mustang. I need [1] to kexec boot into second kernel with mustang
> > > platform.
> > 
> > We need to flush the new kernel to PoC.  The code that was here that
> > was doing that would only be executed when the new kernel needed
> > relocation (the standard kexec case).  We also need to flush kernels
> > that do not need relocation (the standard kdump case).
> > 
> > I moved the new kernel flush to kexec_segment_flush(), called
> > unconditionally in machine_kexec() so we can handle both cases
> > with one piece of code.
> 
> Yes, I had noticed that. Actually flushing before cache is disabled can always
> cause heisenbug.

Please use "clean", "invalidate", or "clean+invalidate" rather than
"flush". The latter is ambiguous and misleading.

You can validly perform maintenance while the cache may allocate for a
region of memory, it's just that afterwards the cache may hold a clean
entries for that region.

You can clean/clean+invalidate to push data to the PoC, or you can
invalidate/clean+invalidate to ensure that no asynchronous writebacks
occur later (so long as you do not make a cacheable write to said
cacheline).

The only thing that you cannot guarantee is that there is not some clean
cacheline allocated for a region of memory to which cacheable accesses
may be performed.

Note that the kernel only requires its Image to be clean to the PoC. So
long as this is true, we know that there will not be asynchrnoous
writebacks, and can invalidate as necessary as part of the boot process.

Thanks,
Mark.
