From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Mar 2013 14:50:31 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306214036.62fc93b9@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
Message-ID: <20130306215031.GB4916@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 09:40:36PM +0100, Thomas Petazzoni wrote:
> > Part of the point of all this DT stuff is to give HW designers some
> > reasonable flexability in their HW design without requiring code
> > changes to Linux to boot it. So if Marvell makes a new Armada varient
> > that re-uses all the same pre existing IP, just with different mbus
> > targets, they should be able to make Linux run on it simply by writing
> > a SOC specific firmware and DT.
> 
> That simply doesn't work for real. HW designers often introduce a
> subtle change in the registers, and bing, your driver no longer works,
> and you have to fix it anyway.

The goal would be to have HW architects cognisant of what capabilites
are available in the DT and Kernel and stay within those
limits. Fundamentally this is how x86 maintains its compatibility and
to achive this dream on ARM the same must be true.

This process must go from both sides, the DT must allow enough
flexibility and the HW architect must care to minimize the software
impact. Today there is no real incentive for HW to say the same
because they have to make Linux patches for every new SOC anyhow. The
introduction of DT will be the first time there is an actual tangible
economic advantage to developing/considering DT bindings for your IP
during the HW architecture phase. I hope that will change things for
the better :)

> > > Also, I don't believe that windows should be described in the Device
> > > Tree. My long term plan is rather to make the allocation of the base
> > > address of each window entirely dynamic, because there is absolutely no
> > > reason for those addresses to be fixed in stone in the Device Tree.
> > 
> > How will that work? Device tree necessarily must have CPU addresses
> > for the things it describes. Today we have the problem that those
> > addresses must match the values hard coded into Linux, ie DT is
> > describing what Linux expects, not what the HW provides..
> 
> I don't follow you. For the moment we have to say in the DT, I have a
> NOR of 16 MB, and it's mapped at 0xCD000000. This 0xCD000000 is
> completely useless: the NOR driver or whatever driver sets up the NOR
> can do an allocate_resource(), which returns an available fragment of
> the physical address space, and create the address decoding window at
> this address.

As I understand it (from other conversations), the preferred way to do
this in a DT world is with the layout I described. The mbus driver
would allocate the regions and update the DT in memory with the
results of allocate_resource(). There are a couple ways to make a DT
layout that allows this, but the basic idea is the same.

This keeps the window allocation encapsulated within the mbus driver,
the NOR driver doesn't know or care about these details, and all the
OF machinery still works because the window base address in DT is
valid.

> > This idea that Linux should setup windows on its own has moved away
> > from what OF was intended for, I'm not sure there is an overarching
> > plan on how to handle those cases - but hardcoding addresses in Linux
> > and then requiring the DT to match them exactly certainly seems wrong.
> 
> Where have you seen that I want to hardcode addresses in Linux? That's
> what is done for now, because it has been done this way since a long
> time in the Linux support for Marvell SoCs, and I don't want to move
> away from that in one step.

I say this because I don't see how to go from this DT binding to a
future that has full dynamic window address assignment. What do you
imagine a NOR DT stanza would look like for dynamic assignment? How do
you tell which DT stanza is associated with which target attributes?
How do you keep mbus specific window setup code out of the
NOR/NAND/SPI/MTD/etc drivers?

> You've solved the problem for those two particular cases, and then the
> next SoC shows up, and has a little difference in the register layout,
> or something... and your DT binding no longer works.

There are now about 5 SOCs with the same layout for the MBUS window
registers, and the idea to specify the base offset of each of the 3
types of window register types works for all of them. 

So to me, this is a prime thing to store in DT. If a future HW uses a
totally different register layout then should this driver even work on
it?

But, this is orthogonal to using 'ranges' and target id's in the DT
to associate DT stanzas with MBUS targets.

> > Well, this is certainly a fair notion - but things like the MAPDEF
> > values, and window offsets are properties of the SOC and are never,
> > ever going to change. So selecting a sane way to communicate those
> > values through DT makes lots of sense to me.
> 
> Never going to change? They change from one SoC family to another...

I ment never change within the SOC. If they were the same on every SOC
then they could live in the driver just fine. It is the fact that
every SOC that uses the MBUS driver uses different target attributes
that makes them a good candidate to live in DT.

> > It is absolutely way too much work to try and fix everything in one
> > go! I would be happy to see your patch go in as-is, but mildly unhappy
> > to see us stuck with this DT layout forever...
> 
> Again, I don't see the point of making the DT binding more complex than
> the one being proposed here, and you haven't given any really
> compelling arguments except that it is not to your taste. I believe
> we're reaching a point where things start to be a matter of taste, and
> so unless you're writing the code and doing the work yourself, you also
> have to accept that other people might have different visions of how
> things should be handled, and therefore have different tastes.
> 
> How can we make progress on this, in a *reasonable* way?

Well, as you say, we've pretty much completed presenting arguments for
each view on this subject, so it is really up to the gatekeepers of
the stable DT 'ABI' to decide on how they want this all to look in the
end, IMHO.

Jason C/Andrew L/Arnd?

Regards,
Jason
