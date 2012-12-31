From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 31 Dec 2012 09:44:26 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121229093359.GA5877@avionic-0098.adnet.avionic-design.de>
References: <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
 <50D0A1EA.9090009@wwwdotorg.org>
 <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
 <20121222155040.61829b00@skate>
 <20121228210622.GA4519@avionic-0098.adnet.avionic-design.de>
 <20121228221632.3892e90b@skate> <50DE2FFB.8040804@wwwdotorg.org>
 <20121229093359.GA5877@avionic-0098.adnet.avionic-design.de>
Message-ID: <50E1C0EA.2090107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/2012 02:33 AM, Thierry Reding wrote:
> On Fri, Dec 28, 2012 at 04:49:15PM -0700, Stephen Warren wrote:
...
>> Is it actually necessary for a host/PCI bridge to show up on the
>> PCI bus as device 0?
> 
> It isn't actually required to make PCI work, but it enables PCI
> device matching to DT nodes with the generic code. If we leave out
> the host bridge, then the matching becomes rather complicated and
> we'll most likely have to special-case it (in the worst case on a
> per-mach basis). The PCI core allows this by overriding the default
> implementations (weak symbols) but doing so will conflict with the
> multi-platform work. Making it work with multi-platform will
> probably require the addition of a .of_match() to struct pci_ops or
> similar.
> 
> Faking a host bridge seems like the lesser evil to me.

Hmmm. Doesn't the DT node represent the host controller rather than
the host bridge, such that any device on a certain PCI bus can easily
be mapped back to the relevant host controller device, and hence
relevant DT node? Having to "route" this mapping through the host
bridge PCI device (which IIRC just acts as a somewhat passive conduit
between the host controller and the bus) seems a little odd. But
anyway, I guess if that's the way the PCI core is written, and it's
non-trivial to change, then I guess yes a virtual device does seem
required.
