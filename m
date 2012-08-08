From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 8 Aug 2012 09:55:12 -0400 (EDT)
Subject: [PATCH 01/22] ARM: add mechanism for late code patching
In-Reply-To: <5022673A.7060407@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-2-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1208040045360.5231@xanadu.home> <50219C45.7030601@ti.com>
 <alpine.LFD.2.02.1208080106500.5231@xanadu.home>
 <5022673A.7060407@ti.com>
Message-ID: <alpine.LFD.2.02.1208080948210.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Aug 2012, Cyril Chemparathy wrote:

> On 08/08/12 01:56, Nicolas Pitre wrote:
> > On Tue, 7 Aug 2012, Cyril Chemparathy wrote:
> [...]
> > > u32 arm_check[] = {
> > > 	0xe2810041, 0xe2810082, 0xe2810f41, 0xe2810f82, 0xe2810e41,
> > > 	0xe2810e82, 0xe2810d41, 0xe2810d82, 0xe2810c41, 0xe2810c82,
> > > 	0xe2810b41, 0xe2810b82, 0xe2810a41, 0xe2810a82, 0xe2810941,
> > > 	0xe2810982, 0xe2810841, 0xe2810882, 0xe2810741, 0xe2810782,
> > > 	0xe2810641, 0xe2810682, 0xe2810541, 0xe2810582, 0xe2810441,
> > > };
> > 
> > Instead of using this array you could let the assembler do it for you
> > like this:
> > 
> > asm (" \n\
> > 	.arm \n\
> > arm_check: \n\
> >          .set shft, 0 \n\
> >          .rep 12 \n\
> >          add     r1, r2, #0x81 << \shft \n\
> >          .set shft, \shft + 2 \n\
> >          .endr \n\
> > ");
> > 
> 
> Neat macro magic.  Are you thinking that we build this in as a self test in
> the code?

For such things, this is never a bad idea to have some test alongside 
with the main code, especially if this is extended to more cases in the 
future.  It is too easy to break it in subtle ways.

See arch/arm/kernel/kprobes-test*.c for a precedent.


Nicolas
