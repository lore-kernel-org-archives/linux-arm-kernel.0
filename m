From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Mon, 11 Dec 2017 22:02:55 +0100
Subject: [PATCH 02/12] mtd: nand: add reworked Marvell NAND controller
 driver
In-Reply-To: <20171211180511.1d734b37@bbrezillon>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171207201814.30411-3-miquel.raynal@free-electrons.com>
 <CAAEAJfC89bRugBsK8jrK=6fdq76yzjThA74UCAhAaVuonLLNvg@mail.gmail.com>
 <20171211175506.0b8ea4d1@xps13>
 <20171211180511.1d734b37@bbrezillon>
Message-ID: <20171211220255.0292fd8f@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Dec 2017 18:05:11 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Mon, 11 Dec 2017 17:55:06 +0100
> Miquel RAYNAL <miquel.raynal@free-electrons.com> wrote:
> 
> > On Mon, 11 Dec 2017 13:27:30 -0300
> > Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> >   
> > > On 7 December 2017 at 17:18, Miquel Raynal
> > > <miquel.raynal@free-electrons.com> wrote:    
> > > > Add marvell_nand driver which aims at replacing the existing
> > > > pxa3xx_nand driver.
> > > >
> > > > The new driver intends to be easier to understand and follows
> > > > the brand new NAND framework rules by implementing hooks for
> > > > every pattern the controller might support and referencing them
> > > > inside a parser object that will be given to the core at each
> > > > ->exec_op() call.
> > > >
> > > > Raw accessors are implemented, useful to test/debug
> > > > memory/filesystem corruptions. Userspace binaries contained in
> > > > the mtd-utils package may now be used and their output trusted.
> > > >
> > > > Timings may not be kept from the bootloader anymore, the timings
> > > > used for instance in U-Boot were not optimal and it supposed to
> > > > have NAND support (and initialized) in the bootloader.
> > > >
> > > > Thanks to the improved timings, implementation of ONFI mode 5
> > > > support (with EDO managed by adding a delay on data sampling),
> > > > merging the commands together and optimizing writes in the
> > > > command registers, the new driver may achieve faster
> > > > throughputs in both directions. Measurements show an
> > > > improvement of about +23% read throughput and +24% write
> > > > throughput. These measurements have been done with an
> > > > Armada-385-DB-AP (4kiB NAND pages forced in 4-bit strength BCH
> > > > ECC correction) using the userspace tool 'flash_speed' from the
> > > > MTD test suite.
> > > >
> > > > Besides these important topics, the new driver addresses several
> > > > unsolved known issues in the old driver which:
> > > > - did not work with ECC soft neither with ECC none ;
> > > > - relied on naked read/write (which is unchanged) while the
> > > > NFCv1 embedded in the pxa3xx platforms do not implement it, so
> > > > several NAND commands did not actually ever work without any
> > > > notice (like reading the ONFI PARAM_PAGE or SET/GET_FEATURES) ;
> > > > - wrote the OOB data correctly, but was not able to read it
> > > > correctly past the first OOB data chunk ;
> > > > - did not displayed ECC bytes ;
> > > > - used device tree bindings that did not allow more than one
> > > > NAND chip, and did not allow to choose the correct chip select
> > > > if not incrementing from 0. Plus, the Ready/Busy line used had
> > > > to be 0.
> > > >
> > > > Old device tree bindings are still supported but deprecated. A
> > > > more hierarchical view has to be used to keep the controller
> > > > and the NAND chip structures clearly separated both inside the
> > > > device tree and also in the driver code.
> > > >      
> > > 
> > > So, is this driver fully compatible with the current pxa3xx-nand
> > > driver?    
> > 
> > It should be!
> >   
> > > 
> > > Have you tested with U-Boot's driver (based on the pxa3xx-nand)?
> > > 
> > > I recally some subtle issues with the fact that U-Boot and Linux
> > > had to agree about the BBT format.    
> > 
> > I kept the pxa3xx_nand driver BBT format.
> > 
> > This is something I mistakenly omitted from the commit message:
> > 
> > There are 5 supported layouts in the driver (the same as withing the
> > pxa3xx_nand driver):
> >     1/ Page: 512B, strength 1b/512B (hamming)
> >     2/ Page: 2kiB, strength 4b/2kiB (hamming)
> >     3/ page: 2kiB, strength 16b/2kiB (BCH)
> >     4/ page: 4kiB, strength 16b/2kiB (BCH)
> >     5/ page: 4kiB, strength 32b/2kiB (BCH)  
> 
> Are you sure of #5? I thought the engine was only capable of modifying
> the ECC block size, not the strength. If this is the case, then mode
> #5 is actually 16b/1024kiB.

You are right, #5 you actually be:

    5/ page: 4kiB, strength 16b/1kiB (BCH)  

Thanks for pointing it,
Miqu?l

> 
> > 
> > Layout 2 has been tested with CM_X300 compulab module (PXA SoC) with
> > and without DMA.
> > Layout 4 has been tested with an Armada 385 db, an Armada 7040 DB
> > and an Armada 8040 DB.
> > Layout 5 has been tested with an Armada 398 db.
> > 
> > Layout 1 has been tested with the Armada 385 db with some hacks.
> > Layout 3 has been tested with the Armada 385 db with some other
> > hacks, that is why I am concerned about the other thread on the MTD
> > mailing list "wait timeout when scanning for BB" where a 2kiB page
> > with 16b/2048B strength is in use.
> > 
> > Regards,
> > Miqu?l  
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
