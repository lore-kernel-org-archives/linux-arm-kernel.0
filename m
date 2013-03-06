From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 21:40:36 +0100
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306202447.GA4916@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
Message-ID: <20130306214036.62fc93b9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 6 Mar 2013 13:24:47 -0700, Jason Gunthorpe wrote:

> Well, in this case I think it is fairly reasonable because it means
> the mbus driver could work with all current and future Marvell chips
> that are based on this architecture, rather than having to fiddle with
> the driver every time.. 
> 
> Part of the point of all this DT stuff is to give HW designers some
> reasonable flexability in their HW design without requiring code
> changes to Linux to boot it. So if Marvell makes a new Armada varient
> that re-uses all the same pre existing IP, just with different mbus
> targets, they should be able to make Linux run on it simply by writing
> a SOC specific firmware and DT.

That simply doesn't work for real. HW designers often introduce a
subtle change in the registers, and bing, your driver no longer works,
and you have to fix it anyway.

The idea that making changes only to the DT will allow porting the
kernel to a new family of SoC is just a dream. I know a lot of people
are dreaming about this, but it doesn't make sense: you can't imagine,
when designing a DT binding, what kind of crazy bizarre change the HW
designers will come up with in a newer revision of a given IP. And the
good way to handle that, IMO, is to put as little logic in the DT as
possible (because DT bindings have to be stable), and handle the crazy
little differences between SoCs in the driver.

> > Also, I don't believe that windows should be described in the Device
> > Tree. My long term plan is rather to make the allocation of the base
> > address of each window entirely dynamic, because there is absolutely no
> > reason for those addresses to be fixed in stone in the Device Tree.
> 
> How will that work? Device tree necessarily must have CPU addresses
> for the things it describes. Today we have the problem that those
> addresses must match the values hard coded into Linux, ie DT is
> describing what Linux expects, not what the HW provides..

I don't follow you. For the moment we have to say in the DT, I have a
NOR of 16 MB, and it's mapped at 0xCD000000. This 0xCD000000 is
completely useless: the NOR driver or whatever driver sets up the NOR
can do an allocate_resource(), which returns an available fragment of
the physical address space, and create the address decoding window at
this address.

The base address of address decoding windows is not a description of
the hardware. Those base addresses can be dynamically allocated during
the probing of devices.

> OF was targetted at the case where the firmware would set the windows
> and then the DT is simply the way to communicate what the window
> settings are to the consumer.
> 
> This idea that Linux should setup windows on its own has moved away
> from what OF was intended for, I'm not sure there is an overarching
> plan on how to handle those cases - but hardcoding addresses in Linux
> and then requiring the DT to match them exactly certainly seems wrong.

Where have you seen that I want to hardcode addresses in Linux? That's
what is done for now, because it has been done this way since a long
time in the Linux support for Marvell SoCs, and I don't want to move
away from that in one step.


> > No: there will anyway be different functions to be called depending on
> > the SoC family. So the driver will anyway have to have different
> > compatible strings for the different SoC families, because we can't
> > put
> 
> Well I wrote the 'mbus_win_offset' function concept with DT lists:
> 
> >    windows = <0 1 2 3 4>;
> >    remappable-windows = <7 8 9>;
> >    internal-window = 5;
> 
> And the two varients of the SDRAM function still have to exist, but
> would be best handled by separating the SDRAM description from the
> MBUS description in DT - they are orthogonal concepts.

You've solved the problem for those two particular cases, and then the
next SoC shows up, and has a little difference in the register layout,
or something... and your DT binding no longer works.

Really, I don't see any point or any useful feature brought by adding
this enormous additional amount of information in the DT.

> > Another reason is that the DT bindings become part of the kernel ABI,
> > so they can't be changed once they are defined and have started to be
> > used seriously on production devices. This leads to a very simple
> > choice: limit the amount of things we put in the DT, and instead put
> > more of the internal logic into the driver.
> 
> Well, this is certainly a fair notion - but things like the MAPDEF
> values, and window offsets are properties of the SOC and are never,
> ever going to change. So selecting a sane way to communicate those
> values through DT makes lots of sense to me.

Never going to change? They change from one SoC family to another...

> > No, I also have a temporary disagreement: I think what you're asking is
> > way too far away from the current code. I've already been asked to
> > make
> 
> I certainly agree with this. If it wasn't for the idea that the DT is
> a stable ABI and thus must be perfect from the start, I wouldn't have
> mentioned any of this right now, making fine tuning adjustments as a
> follow on seems better to me.
> 
> It is absolutely way too much work to try and fix everything in one
> go! I would be happy to see your patch go in as-is, but mildly unhappy
> to see us stuck with this DT layout forever...

Again, I don't see the point of making the DT binding more complex than
the one being proposed here, and you haven't given any really
compelling arguments except that it is not to your taste. I believe
we're reaching a point where things start to be a matter of taste, and
so unless you're writing the code and doing the work yourself, you also
have to accept that other people might have different visions of how
things should be handled, and therefore have different tastes.

How can we make progress on this, in a *reasonable* way?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
