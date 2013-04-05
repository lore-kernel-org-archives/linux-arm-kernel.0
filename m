From: geoff@infradead.org (Geoff Levand)
Date: Fri, 05 Apr 2013 09:46:50 -0700
Subject: [PATCH 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <515E9474.2070100@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-7-git-send-email-marc.zyngier@arm.com>
 <1365113453.24496.26.camel@smoke> <515E9474.2070100@arm.com>
Message-ID: <1365180410.24496.67.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Fri, 2013-04-05 at 10:08 +0100, Marc Zyngier wrote:
> On 04/04/13 23:10, Geoff Levand wrote:
> > On Tue, 2013-04-02 at 14:25 +0100, Marc Zyngier wrote:
> >> +	@ Jump to the trampoline page
> >> +	ldr	r2, =#PAGE_MASK
> >> +	adr	r3, target
> >> +	bic	r3, r3, r2
> >> +	ldr	r2, =#TRAMPOLINE_VA
> >> +	add	r3, r3, r2
> >> +	mov	pc, r3
> > 
> > I guess you need 'ldr r2, =PAGE_MASK'.
> > 
> >   arch/arm/kvm/init.S:114: Error: bad expression -- `ldr r2,=#(~((1<<12)-1))'
> >   arch/arm/kvm/init.S:117: Error: bad expression -- `ldr r2,=#0xffff0000'
> 
> Oddly enough, this code compiles perfectly fine on my box.
> What's your compiler/binutils versions?

I thought # was for an immediate value in instructions.  This
is an assembler pseudo-instruction, and based on the ARM manual
here I would think your coding should fail:

  http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0473i/Chdcegci.html

I use the current arm-linux-gnueabihf cross toolchain packages from
Ubuntu 12.04:

  arm-linux-gnueabihf-gcc-4.6 (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  GNU assembler (GNU Binutils for Ubuntu) 2.22

-Geoff
