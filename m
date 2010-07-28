From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Jul 2010 23:36:03 +0100
Subject: [PATCH 2/3] arm: mm: do not set missing flags on ScorpionMP
In-Reply-To: <1280354280.21185.10.camel@c-dwalke-linux.qualcomm.com>
References: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
	<1279911483-7039-3-git-send-email-johlstei@codeaurora.org>
	<20100724082334.GB15571@n2100.arm.linux.org.uk>
	<1280354280.21185.10.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100728223603.GB6729@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 02:58:00PM -0700, Daniel Walker wrote:
> On Sat, 2010-07-24 at 09:23 +0100, Russell King - ARM Linux wrote:
> > On Fri, Jul 23, 2010 at 11:58:02AM -0700, Jeff Ohlstein wrote:
> > > From: Steve Muckle <smuckle@codeaurora.org>
> > > 
> > > ScorpionMP does not have the SMP/nAMP mode and TLB ops
> > > broadcasting bits in the ACTLR.
> > 
> > Please provide a separate instance of __v7_proc_info for your processor
> > and direct it to jump into the __v7_setup code after this setup instead.
> 
> 
> You mean add another label into __v7_setup along with a proc-msm.S to
> jump over this code?

Yes to the first, no to the second.

__v7_setup:
#ifdef CONFIG_SMP
        mrc     p15, 0, r0, c1, c0, 1
        tst     r0, #(1 << 6)                   @ SMP/nAMP mode enabled?
        orreq   r0, r0, #(1 << 6) | (1 << 0)    @ Enable SMP/nAMP mode and
        mcreq   p15, 0, r0, c1, c0, 1           @ TLB ops broadcasting
#endif
__v7_msm_setup:
	...

        .section ".proc.info.init", #alloc, #execinstr

	.type	__v7_msm_proc_info, #object
__v7_msm_proc_info:
	.long	...
	.long	...
	...
	b	__v7_msm_setup
	...

        /*
         * Match any ARMv7 processor core.
         */
        .type   __v7_proc_info, #object
__v7_proc_info:
	...
