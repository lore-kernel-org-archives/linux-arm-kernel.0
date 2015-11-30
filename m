From: geoff@infradead.org (Geoff Levand)
Date: Mon, 30 Nov 2015 10:51:15 -0800
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <20151127131306.GE23908@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
Message-ID: <1448909475.31214.27.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2015-11-27 at 18:43 +0530, Pratyush Anand wrote:

> On 24/11/2015:10:25:34 PM, Geoff Levand wrote:
> > +> > 	> > /* Test the entry flags. */
> > +.Ltest_source:
> > +> > 	> > tbz> > 	> > x18, IND_SOURCE_BIT, .Ltest_indirection
> > +
> > +> > 	> > mov x20, x13> > 	> > 	> > 	> > 	> > /*  x20 = copy dest */
> > +> > 	> > mov x21, x12> > 	> > 	> > 	> > 	> > /*  x21 = copy src */
> 
> Till v10 we had here invalidation for relocated destination page to PoC. I could
> not understand, why it was removed. Removing that piece of code breaks kexec
> booting with mustang. I need [1] to kexec boot into second kernel with mustang
> platform.

We need to flush the new kernel to PoC.  The code that was here that
was doing that would only be executed when the new kernel needed
relocation (the standard kexec case).  We also need to flush kernels
that do not need relocation (the standard kdump case).

I moved the new kernel flush to kexec_segment_flush(), called
unconditionally in machine_kexec() so we can handle both cases
with one piece of code.

Have you experienced a problem on mustang with the current version?

-Geoff
