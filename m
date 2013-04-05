From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 5 Apr 2013 11:29:16 -0600
Subject: mvebu-mbus: defining a DT binding
In-Reply-To: <201304051858.05567.arnd@arndb.de>
References: <20130405150200.7b6dee63@skate>
 <20130405162737.GA3598@obsidianresearch.com>
 <201304051858.05567.arnd@arndb.de>
Message-ID: <20130405172916.GC3598@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 06:58:05PM +0200, Arnd Bergmann wrote:

> > So to me, this is already a guide that this might have to be board
> > specific anyhow.
> 
> I mentioned three options before, what you describe is one of
> them:

There is also 

d) The DT contains the bootloader address map, but the mbus driver
   discards that and fully reassigns everything.

e) The DT contains the bootloader address map, but some targets may be
   missing. The address map is kept, and the missing targets are
   dynamically allocated.
 
> a) make the ranges in the DT refer to what the hardware is set to,
> as you explain above. This makes it easy to run an OS without an
> mbus driver, but somewhat harder to reassign the windows at run-time

I don't think it makes things harder, it is straightforward for the
driver to wipe and rewrite the ranges property based on actual
programming.

> b) set the ranges to the windows we want to have in Linux. This is closer
> to what we have at the moment, where we basically configure mbus from
> a static configuration, and allow the windows that are to be dynamic
> (e.g. PCIe) to be left out of this.

Keep in mind that in all cases the mbus driver will zero all the
windows and write its own information. This is necessary to ensure any
left over PEX windows are blown away, for instance. So from a
driver-design standpoint a and b are identical.

The only difference is what do you put in the board
file. Pragmatically it won't matter to many people, Both will work if
the kernel has the mbus driver.

> c) Try to keep the ranges property empty at boot time, except possibly
> the internal register window, and find the optimum address map at
> boot time based on which devices are enabled.

I think d or e is a better choice, since we marry the best feature of
a, and the best function of c.

For working on the driver a/b is certainly the simplest first
step. Adding future capability to go to d or e won't require a DT
change.

Jason
