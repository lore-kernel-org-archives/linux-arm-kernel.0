From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Apr 2014 18:11:42 +0100
Subject: [Qemu-devel] Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <535681A4.1080402@monstr.eu>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <20140417203521.GB22411@obsidianresearch.com> <535681A4.1080402@monstr.eu>
Message-ID: <20140422171141.GW24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 04:50:12PM +0200, Michal Simek wrote:
> On 04/17/2014 10:35 PM, Jason Gunthorpe wrote:
> > +/* If we have a known, fixed physical load address then set LOAD_OFFSET
> > +   and generate an ELF that has the physical load address in the program
> > +   headers. */
> > +#ifndef CONFIG_ARM_PATCH_PHYS_VIRT
> > +#define LOAD_OFFSET (PAGE_OFFSET - PLAT_PHYS_OFFSET)
> > +#endif
> > +
...
> > -	.head.text : {
> > +	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
> >  		_text = .;
> > +		phys_start = . - LOAD_OFFSET;
> >  		HEAD_TEXT
> >  	}
> 
> I am not quite about these changes above but Russell can comment it.

I don't think /anyone/ is seriously proposing that we should merge this
patch... because that won't happen.  It should be clear enough from the
discussion why that is, but in case it isn't, take a look above.

What is that ifdef saying.  It's saying that if you enable
ARM_PATCH_PHYS_VIRT, which is an absolute requirement for multi-
platform kernels, then you get the proper LMA addresses.  If you don't,
then you don't get proper LMA addresses.

Put another way, if your platform is part of the multi-platform kernel
then you are *excluded* from being able to use this... unless you hack
the Kconfig, and then also provide a constant value for PHYS_OFFSET,
thereby _tying_ the kernel you built to a _single_ platform.

You can't do this _and_ have a multi-platform kernel.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
