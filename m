From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 13 Mar 2013 12:30:54 -0600
Subject: [PATCH] ARM: mvebu: fix RAM size for Armada XP board DB-MV784MP-GP
In-Reply-To: <20130313174324.GS21478@lunn.ch>
References: <20130216164457.GA23237@titan.lakedaemon.net>
 <1363101135-21635-1-git-send-email-jason@lakedaemon.net>
 <51408D86.6040703@cogentembedded.com>
 <51408F0C.2010408@free-electrons.com>
 <20130313173559.GD24042@obsidianresearch.com>
 <20130313174324.GS21478@lunn.ch>
Message-ID: <20130313183054.GA26303@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 06:43:24PM +0100, Andrew Lunn wrote:
> On Wed, Mar 13, 2013 at 11:35:59AM -0600, Jason Gunthorpe wrote:
> > On Wed, Mar 13, 2013 at 03:37:00PM +0100, Gregory CLEMENT wrote:
> > 
> > > >> +		 * size of the module actually plugged
> > > >>   		 */
> > > >> -		reg = <0x00000000 0xC0000000>;
> > > >> +		reg = <0x00000000 0xD0000000>;
> > > > 
> > > >     But this is not 4G?
> > > 
> > > You're totally right!
> > > It should be reg = <0x00000000 0xF0000000>;
> > 
> > Isn't it 'right' as it is? The various included DT's put devices at
> > address 0xd0008000 for instance, memory shouldn't overlap that..
> 
> Shouldn't DT describe the hardware? The hardware has 4GB. How much of
> it Linux decides to use so as to avoid overlaps with registers etc, is
> not a hardware issue, but software.

Sure, but which HW? The 'reg' in 'memory' is not describing a DDR
bus. It is describing the DDR address mapping registers in the SOC -
and they are probably set for 0 -> 0xD0000000 by the firmware.

To describe the 4G of DDR you need DT nodes that show:
- The N DDR chip selects going to each DDR rank
- How much memory is in each DDR rank
- How each chip select is currently mapped into CPU address space

This is the minimal amount of information needed for Linux to
reprogram the entire address map, if it so chooses.

To me, the *address map* in the DTB passed from the firwmare should
reflect the state of the machine when the OS is started. That way an
OS without drivers for the address map hardware will function
properly.

Regards,
Jason
