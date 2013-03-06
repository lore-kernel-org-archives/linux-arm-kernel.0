From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Mar 2013 13:24:47 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306202710.15a6aa2c@skate>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
Message-ID: <20130306202447.GA4916@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 08:27:10PM +0100, Thomas Petazzoni wrote:

> I personally dislike this proposal quite a lot. I believe it puts way
> too many things into the Device Tree. Seems like these days, people
> want to write thousands of lines of data in Device Trees rather than
> having drivers properly abstract the differences between SoC.

Well, in this case I think it is fairly reasonable because it means
the mbus driver could work with all current and future Marvell chips
that are based on this architecture, rather than having to fiddle with
the driver every time.. 

Part of the point of all this DT stuff is to give HW designers some
reasonable flexability in their HW design without requiring code
changes to Linux to boot it. So if Marvell makes a new Armada varient
that re-uses all the same pre existing IP, just with different mbus
targets, they should be able to make Linux run on it simply by writing
a SOC specific firmware and DT.

> Also, I don't believe that windows should be described in the Device
> Tree. My long term plan is rather to make the allocation of the base
> address of each window entirely dynamic, because there is absolutely no
> reason for those addresses to be fixed in stone in the Device Tree.

How will that work? Device tree necessarily must have CPU addresses
for the things it describes. Today we have the problem that those
addresses must match the values hard coded into Linux, ie DT is
describing what Linux expects, not what the HW provides..

OF was targetted at the case where the firmware would set the windows
and then the DT is simply the way to communicate what the window
settings are to the consumer.

This idea that Linux should setup windows on its own has moved away
from what OF was intended for, I'm not sure there is an overarching
plan on how to handle those cases - but hardcoding addresses in Linux
and then requiring the DT to match them exactly certainly seems wrong.

As for dynamic allocation, they way to do it via DT is through the
ranges property, similar to how I noted. The DT can be modified
in-memory, so a dyanmic mbus driver would ignore the CPU target
address in the ranges, select its own CPU address and then update the
in-memory DT with the corrected value. Everything else would then work
properly.

> > > + * Some variants of Orion5x have 4 remappable windows, some other have
> > > + * only two of them.
> > > + */
> > > +static const struct mvebu_mbus_soc_data orion5x_4win_mbus_data = {
> > > +	.num_wins            = 8,
> > > +	.num_remappable_wins = 4,
> > 
> > These values also seem like something worth reading from the DT as
> > well.. See above for an idea.
> 
> No: there will anyway be different functions to be called depending on
> the SoC family. So the driver will anyway have to have different
> compatible strings for the different SoC families, because we can't
> put

Well I wrote the 'mbus_win_offset' function concept with DT lists:

>    windows = <0 1 2 3 4>;
>    remappable-windows = <7 8 9>;
>    internal-window = 5;

And the two varients of the SDRAM function still have to exist, but
would be best handled by separating the SDRAM description from the
MBUS description in DT - they are orthogonal concepts.

> Another reason is that the DT bindings become part of the kernel ABI,
> so they can't be changed once they are defined and have started to be
> used seriously on production devices. This leads to a very simple
> choice: limit the amount of things we put in the DT, and instead put
> more of the internal logic into the driver.

Well, this is certainly a fair notion - but things like the MAPDEF
values, and window offsets are properties of the SOC and are never,
ever going to change. So selecting a sane way to communicate those
values through DT makes lots of sense to me.

> No, I also have a temporary disagreement: I think what you're asking is
> way too far away from the current code. I've already been asked to
> make

I certainly agree with this. If it wasn't for the idea that the DT is
a stable ABI and thus must be perfect from the start, I wouldn't have
mentioned any of this right now, making fine tuning adjustments as a
follow on seems better to me.

It is absolutely way too much work to try and fix everything in one
go! I would be happy to see your patch go in as-is, but mildly unhappy
to see us stuck with this DT layout forever...

Especially since I really want to see your PCI stuff go in ....

Jason
