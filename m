From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 17 Dec 2012 11:29:11 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
References: <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
 <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
 <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
Message-ID: <20121217182911.GA10448@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Ie route access for 00:1N.0 to the configuration space on bridge port N
> 
> Is there any particular reason why you choose 0x10 as the base slot
> for bridge ports? With the latest DT support patches, mapping this
> should be even simpler as we associate a port index with each port
> and the port array is gone.

No specific reason, it similar to what intel did and clearly shows the
port number in a octet of the device id. It just can't be 0.

> > Then you are a bit closer. You should see both root port bridges
> > appear in your lspci.. IIRC the host bridge device is not essential to
> > discovery working on Linux.
> 
> The second port will probably still not appear, at least not in the
> latest patches for DT support since it won't be registered unless
> enabled. Even if enabled it will not be registered unless a link is
> available, which it isn't in any of the setups that I currently have.
> I'll need to check with our hardware engineers whether we can hook
> something up to the second port.

You can probably bodge around and just register it anyhow, the
internal bridge will still show up in linux, even though there is no
device behind it.

I'm not sure if PCI-E ports should be ignored if the link is down. The
kernel has the ability to re-scan them at runtime, and if the
controller has a link up interrupt then it can happen automatically.

I sent through a patch for kirkwood that did this, we hot plug the
PCIe device because userspace intializes it.

Jason
