From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 20 Mar 2014 12:50:04 +0000
Subject: [PATCH v7 3/3] arm64: Add architecture support for PCI
In-Reply-To: <201403201326.02377.arnd@arndb.de>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <201403201217.22339.arnd@arndb.de>
 <20140320113820.GH6457@e106497-lin.cambridge.arm.com>
 <201403201326.02377.arnd@arndb.de>
Message-ID: <20140320125004.GK6457@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 12:26:02PM +0000, Arnd Bergmann wrote:
> On Thursday 20 March 2014, Liviu Dudau wrote:
> > > I don't even understand why you want to create a generic pci_address_to_pio
> > > implementation, when we don't need that for arm64 at all. Unless I'm
> > > missing something important, that function is only called in case of
> > > PCI_PROBE_DEVTREE with pci_of_scan on PowerPC. I don't expect any
> > > architecture to do the same thing, and the only other architecture that
> > > needs something like it (sparc) has a different implementation.
> > 
> > Because in my [v7 2/6]* patch for the generic host bridge support I start
> > using pci_address_to_pio to fix the conversion of PCI ranges to resources.
> > That requires an arm64 (or more correctly, an arch with memory mapped IO
> > specific) version of pci_address_to_pio().
> 
> Yes, but why do you use it there?

I'm parsing the device tree and have reached the PCI IO range for the host bridge.
There is no host bridge created yet for that and hence no mapping. I need to
take the DT range declaration that gives me   CPU start .. SIZE --> BUS start and
convert it into   Logical IO port start .. Logical IO port end. While I could've
come up with (yet) another function that does the conversion from CPU address to
port IO address, I thought it would be nice to use the existing pci_address_to_pio()
function and adapt it to my needs. It has a __weak implementation anyway so I
could overwrite it in the architecture code.

To me it looked like a good plan and we had some discussions around my initial
goofy mistake of using pci_addr as physical address for translation. I never
thought it was considered a bad idea.

Best regards,
Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
