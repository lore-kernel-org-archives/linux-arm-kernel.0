From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 23:07:16 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023160131.GA20675@roeck-us.net>
References: <20131021085420.GA21518@ulmo.nvidia.com>
 <52658C49.80400@wwwdotorg.org> <5265AFED.1040503@roeck-us.net>
 <52665314.2040904@imgtec.com>
 <232aa6e4-19fe-4460-8101-8bf1d639ff3c@email.android.com>
 <20131022164922.GA29852@roeck-us.net>
 <20131022203546.GC8037@mithrandir>
 <20131022211000.GA30394@roeck-us.net>
 <20131023075758.GA7404@ulmo.nvidia.com>
 <20131023160131.GA20675@roeck-us.net>
Message-ID: <20131023210715.GF8828@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 09:01:31AM -0700, Guenter Roeck wrote:
> On Wed, Oct 23, 2013 at 09:57:58AM +0200, Thierry Reding wrote:
[...]
> > 	pic1i2c: i2c-controller {
> > 		...
> > 
> > 		eeprom at 55 {
> > 			/* insert all other properties here */
> > 		};
> > 	};
> > 
> If I add the above to the i2c controller node, the kernel will try to
> instantiate the eeprom when the system comes up. If no card is
> inserted at that time, this will fail. The above describes the devices
> which needs to be instantiated after a card is inserted into the connector,
> and only then (and removed when the card is pulled).
> In addition, I use the 'ideeprom' property to establish a callback
> to be able to read the eeprom contents and trigger loading the DT overlay.

That's an interesting setup and a pretty elegant solution.

> > But that breaks down once you start needing to represent more than just
> > a single EEPROM behind the connector.
> > 
> And if insertion is dynamic, triggered by card insertion.
> 
> There are actually several additional i2c devices on the same bus.
> To instantiate those I use devicetree overlays, but that is done
> after the eeprom is read and I know which overlay to load.

Yes, I see why you need something less traditional to pull that off. And
we should be able to describe that kind of setup using DT as well. The
world would of course be much better if this was all discoverable and we
didn't have to describe it in the first place...

> > > > > not the very least because DT isn't supported on x86 and I have to deal with
> > > > > that situation as well (and, no, ACPI doesn't solve my problems there either).
> > > > 
> > > > Actually DT is supported very well on x86. There's at least one platform
> > > > in mainline that uses it (arch/x86/platform/ce4100/falconfalls.dts) and
> > > > I've ported a platform that I worked on in the past to use DT on x86 as
> > > > well.
> > > > 
> > > But presumably that was DT only, or was it a system that needs to use
> > > DT on top of ACPI ? If so, I would be very interested in that experience,
> > > especially if you had any issues to get it working.
> > 
> > I'm not quite sure I understand what you mean by "on top of ACPI". The
> > device certainly did support ACPI, but I was using DT more as a
> > supplement to describe what ACPI and PCI couldn't.
> > 
> > To be somewhat more specific, the platform used an FPGA connected to the
> > chipset using PCIe. That itself was excellent because all of a sudden
> > devices were actually discoverable. So it was easy to just implement a
> > GPIO, SPI or I2C controller and whatnot within that FPGA, but once a
> > device behind SPI or I2C needed to be hooked up, you loose all benefits
> > from having something like PCI and you're back to square one.
> > 
> > One example where this became essential was that the touchscreen on the
> > device was controlled by an I2C chip, and the touchscreen controller's
> > interrupt pin was connected to the GPIO controller on the PCI bus. So
> > what we ended up with looked roughly something like this:
> > 
> > 	pci at 3fc {
> > 		[...bunch of nodes to describe PCI hierarchy...]
> > 
> > 		pci at 2,0 {
> > 			/* GPIO expander */
> > 			gpio: pci at 0,0 {
> > 				...
> > 				interrupt-controller;
> > 				...
> > 			};
> > 		};
> > 
> > 		[...more nodes...]
> > 
> > 		pci at 8,0 {
> > 			/* I2C controller */
> > 			pci at 0,0 {
> > 				touchscreen at 48 {
> > 					...
> > 					interrupt-parent = <&gpio>;
> > 					interrupts = <1 0x8>;
> > 					...
> > 				};
> > 			};
> > 		};
> > 	};
> > 
> > That's a *very* simplified form. The complete device tree is much more
> > complex because it requires the exact hierarchy of PCI to be represented
> > in order for the right device nodes to end up attached to the right PCI
> > devices.
> > 
> > But perhaps that doesn't help you at all with the problems that you've
> > encountered?
> > 
> Actually, the use case sounds pretty similar, so maybe you have solved the
> problem at least to some degree. In my case, I'll also need devicetree overlays,
> since I also need to be able to handle OIR capable cards, but that is a separate
> set of problems.
> 
> Was this just a matter of enabling OF on this platform, or do you have an
> out-of-tree set of patches ? If the latter, is it available somewhere
> to look at (including the complete devicetree from your above example) ?

It was mostly a matter of enabling OF and writing the device tree. Most
of the generic kernel code changes I even got merged, but there were a
few patches that I never got around to merge. Some weren't anywhere
close to a mergeable state either.

I no longer work for the company and don't have access to the patches.
But I can ping a few people and see if I can dig up something for you.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/0c67cd55/attachment.sig>
