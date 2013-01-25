From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Jan 2013 11:08:01 -0800 (PST)
Subject: [PATCH 5/6] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <20130116105957.GA1963@linaro.org>
References: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
 <20130114150531.GE21142@e102568-lin.cambridge.arm.com>
 <20130116105957.GA1963@linaro.org>
Message-ID: <3747315.IyCCRDXgbD@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 16 of January 2013 10:59:57 Dave Martin wrote:
> On Mon, Jan 14, 2013 at 03:05:32PM +0000, Lorenzo Pieralisi wrote:
> > On Mon, Jan 14, 2013 at 02:48:41PM +0000, Mark Rutland wrote:
> > > Hello,
> > > 
> > > This all looks good. I just have a couple of comments about the cpus
> > > node.> > 
> > > On Sun, Jan 13, 2013 at 01:10:57AM +0000, Tomasz Figa wrote:
> > > > This patch adds basic device tree definitions for Samsung S3C64xx
> > > > SoCs.
> > > > 
> > > > Since all the SoCs in the series are very similar, the files are
> > > > created hierarchically - one file for the whole series and then
> > > > separate files for particular SoCs including the common one.
> > > > 
> > > > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > > 
> > > [...]
> > > 
> > > > diff --git a/arch/arm/boot/dts/s3c64xx.dtsi
> > > > b/arch/arm/boot/dts/s3c64xx.dtsi new file mode 100644
> > > > index 0000000..55d6e08
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/s3c64xx.dtsi
> > > > @@ -0,0 +1,97 @@
> > > > +/*
> > > > + * Samsung's S3C64xx SoC series common device tree source
> > > > + *
> > > > + * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
> > > > + *
> > > > + * Samsung's S3C64xx SoC series device nodes are listed in this
> > > > file.
> > > > + * Particular SoCs from S3C64xx series can include this file and
> > > > provide + * values for SoCs specfic bindings.
> > > > + *
> > > > + * Note: This file does not include device nodes for all the
> > > > controllers in + * S3C64xx SoCs. As device tree coverage for
> > > > S3C64xx increases, additional + * nodes can be added to this
> > > > file.
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or
> > > > modify + * it under the terms of the GNU General Public License
> > > > version 2 as + * published by the Free Software Foundation.
> > > > + */
> > > > +
> > > > +/include/ "skeleton.dtsi"
> > > > +
> > > > +/ {
> > > > +	cpus {
> > > > +		cpu at 0 {
> > > > +			compatible = "arm,arm1176jzf-s";
> > > > +		};
> > > > +	};
> > > 
> > > You can drop the unit address from the cpu node - it's meant to be
> > > there to differentiate multiple nodes (and is supposed to match the
> > > reg property, which the 1176jzf-s can't have, as it doesn't have an
> > > MPIDR).
> > 
> > Well, this is a point that I should consider since the kernel docs I
> > wrote are misleading, they require the reg property that can not be
> > there on UP. True, MPIDR does not exist in this case, but I have to
> > document this in the bindings since it is unclear.
> > 
> > > Also, "arm,arm1176jzf-s" isn't listed in the binding doc. There was
> > > a question about how to maintain this list [1], but I can't seem to
> > > find a conclusion, if any were reached.  It might be worth
> > > appending "arm,arm1176" to the compatible list for the cpu node in
> > > case we want to enable something via dt for all 1176 variations.
> > > 
> > > Dave, Lorenzo, any thoughts?
> > 
> > Eh, frankly I do not know how to handle this. Either we add a
> > compatible string to the bindings anytime a DT gets merged in the
> > kernel but how to maintain it, it has to be defined. Happy to hear
> > some feedback on this.
> 
> Well, the number of CPU types does not grow rapidly.  It will be much
> less than one per SoC -- so keeping the list up to date shouldn't be
> that much effort.
> 
> For ARM1176JZF-S, it could make sense for the comatible list to be
> 
> 	"arm,arm1176jzf-s", "arm,arm1176"
> 
> ...since the differences between 1176 variants are software probeable
> (i.e., whether there is an FPU or not).  AFAIK the J, Z apply to all
> ARM1176, and the -S (synthesisable RTL) is nothing to do with software.
> The kernel probably only really needs to know "arm,arm1176".

OK. So the conclusion is that I should change the cpus node to following:

       cpus {
               cpu {
                       compatible = "arm,arm1176jzf-s", "arm,arm1176";
               };
       };

Am I right?

Best regards,
Tomasz
