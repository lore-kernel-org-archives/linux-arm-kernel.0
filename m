From: slash.tmp@free.fr (Mason)
Date: Fri, 3 Mar 2017 23:09:22 +0100
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
 <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
Message-ID: <45563021-b979-e35f-d039-f2a4cead124d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 20:02, Robin Murphy wrote:

> On 03/03/17 17:15, Mason wrote:
> 
>> [    1.264893] Unable to handle kernel paging request at virtual address d08664f4
> 
> Note that that's a reasonable approximation of a vmalloc address...
> 
> ...and that specifically it's r0 + r3...
> 
> ...and again. And always at the same PC, too. Looking at
> quirk_usb_early_handoff(), it mostly seems to go off poking bridge
> resources, so I'd hazard a guess that it's down to your host driver,
> with something uninitialised (or already freed) being used as an offset
> into some ioremapped resource (which given the consistency of r0 is
> probably allocated pretty early on).

When you say "host driver", do you mean the USB driver,
or the PCIe controller driver?

I am currently writing the PCIe controller driver, so I do
expect a large number of bugs there; but the USB driver is
just the generic XHCI driver. Although I now realize that
I wrote no DT node for the USB HW... Would that explain
the random weirdness?

> "addr2line -i -e vmlinux c039fe44", and work backwards from there ;) In
> particular I'd follow the provenance of r3.

I'll definitely take a closer look. Thanks for the disassembly.

Regards.
