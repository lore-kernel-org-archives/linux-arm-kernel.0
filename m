From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Sun, 7 Jan 2018 22:46:43 +0100
Subject: [PATCH v2 2/5] mtd: nand: add reworked Marvell NAND controller
 driver
In-Reply-To: <20171221111428.0aa3e65e@bbrezillon>
References: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
 <20171219132942.27433-3-miquel.raynal@free-electrons.com>
 <20171221111428.0aa3e65e@bbrezillon>
Message-ID: <20180107224643.760eac74@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Thu, 21 Dec 2017 11:14:28 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Miquel,
> 
> On Tue, 19 Dec 2017 14:29:39 +0100
> Miquel Raynal <miquel.raynal@free-electrons.com> wrote:
> 
> > Add marvell_nand driver which aims at replacing the existing
> > pxa3xx_nand driver.
> > 
> > The new driver intends to be easier to understand and follows the
> > brand new NAND framework rules by implementing hooks for every
> > pattern the controller might support and referencing them inside a
> > parser object that will be given to the core at each ->exec_op()
> > call.
> > 
> > Raw accessors are implemented, useful to test/debug
> > memory/filesystem corruptions. Userspace binaries contained in the
> > mtd-utils package may now be used and their output trusted.
> > 
> > Timings may not be kept from the bootloader anymore, the timings
> > used for instance in U-Boot were not optimal and it supposed to
> > have NAND support (and initialized) in the bootloader.  
> 
> Hm, AFAIR the old driver was able to dynamically adjust the timings
> when the NAND was ONFI compliant.
> 
> > 
> > Thanks to the improved timings, implementation of ONFI mode 5
> > support (with EDO managed by adding a delay on data sampling),
> > merging the commands together and optimizing writes in the command
> > registers, the new driver may achieve faster throughputs in both
> > directions. Measurements show an improvement of about +23% read
> > throughput and +24% write throughput. These measurements have been
> > done with an Armada-385-DB-AP (4kiB NAND pages forced in 4-bit
> > strength BCH ECC correction) using the userspace tool 'flash_speed'
> > from the MTD test suite.
> > 
> > Besides these important topics, the new driver addresses several
> > unsolved known issues in the old driver which:
> > - did not work with ECC soft neither with ECC none ;
> > - relied on naked read/write (which is unchanged) while the NFCv1
> >   embedded in the pxa3xx platforms do not implement it, so several
> >   NAND commands did not actually ever work without any notice (like
> >   reading the ONFI PARAM_PAGE or SET/GET_FEATURES) ;
> > - wrote the OOB data correctly, but was not able to read it
> > correctly past the first OOB data chunk ;
> > - did not displayed ECC bytes ;  
> 
> 	    ^display
> 
> and I'm not even sure display is the right term here. How about
> 'retrieve'.
> 
> > - used device tree bindings that did not allow more than one NAND
> > chip, and did not allow to choose the correct chip select if not
> >   incrementing from 0. Plus, the Ready/Busy line used had to be 0.
> > 
> > Old device tree bindings are still supported but deprecated. A more
> > hierarchical view has to be used to keep the controller and the NAND
> > chip structures clearly separated both inside the device tree and
> > also in the driver code.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > Tested-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> > Tested-by: Willy Tarreau <w@1wt.eu>
> > ---


I made all the changes you requested, let me the time to do further
tests and I will send a v3.

Thanks,
Miqu?l
