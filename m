From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 21:49:00 +0000
Subject: [GIT PULL v3] pxa: patches for v2.6.38-rc
In-Reply-To: <20110114173147.GK15996@n2100.arm.linux.org.uk>
References: <AANLkTi=B3sfBXS3vN1+nnRa5m64jiaqmzRFfi6w07dJB@mail.gmail.com>
	<20110114173147.GK15996@n2100.arm.linux.org.uk>
Message-ID: <20110114214900.GP15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 05:31:47PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 14, 2011 at 11:08:59AM -0600, Eric Miao wrote:
> > Hi Russell,
> > 
> > I rebased the branch on top of devel-stable. The conflict in irq.c is
> > fixed. And there is a one-liner patch fixing a building issue in spitz.c
> > missing of physmap.h. Please re-pull and let know any other issue.
> 
> Pulled cleanly, thanks.

Building my PXA config:

arch/arm/mach-pxa/irq.c:124: warning: initialization from incompatible pointer type
arch/arm/mach-pxa/irq.c:125: warning: initialization from incompatible pointer type
arch/arm/mach-pxa/irq.c:126: warning: initialization from incompatible pointer type
arch/arm/mach-pxa/irq.c:127: warning: initialization from incompatible pointer type

Seems the initializers want to be .irq_ack rather than .ack etc.

I also need to remove asm/pgtable.h from arch/arm/mach-pxa/generic.c:
  CC      arch/arm/mach-pxa/generic.o
In file included from arch/arm/include/asm/pgtable.h:461,
                 from arch/arm/mach-pxa/generic.c:26:
include/asm-generic/pgtable.h: In function ?ptep_test_and_clear_young?:
include/asm-generic/pgtable.h:29: error: dereferencing pointer to incomplete type

and I also got:
arch/arm/mach-pxa/tosa-bt.c: In function ?tosa_bt_probe?:
arch/arm/mach-pxa/tosa-bt.c:84: error: implicit declaration of function ?rfkill_set_led_trigger_name?

which looks like a missing dependency.

Do you want to fix these and send an updated pull?
