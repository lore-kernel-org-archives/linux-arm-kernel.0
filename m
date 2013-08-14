From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Aug 2013 14:57:55 +0100
Subject: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk
 info from DT
In-Reply-To: <20130814134904.GC13141@e106331-lin.cambridge.arm.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-3-git-send-email-rnayak@ti.com>
 <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com>
 <520B8409.5000708@ti.com> <520B88A0.6080806@ti.com>
 <20130814134904.GC13141@e106331-lin.cambridge.arm.com>
Message-ID: <20130814135755.GC25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 02:49:04PM +0100, Mark Rutland wrote:
> [Adding Mike Turquette and dt maintainers]
> 
> On Wed, Aug 14, 2013 at 02:39:44PM +0100, Nishanth Menon wrote:
> > yes. the idea being, we now have a meaning to the clock name - there are 
> > two types of clocks here.. functional and optional, we *might* have 
> > facility to add interface clock(we dont know interface clock handling 
> > yet, but something in the future).. we might increase the support for 
> > number of functional clocks.. it might help to keep the format such that 
> > it is a "bit extendable".
> 
> I completely disagree. The only things that should appear in clock-names
> are the names of the clock inputs that appear in the manual for the
> device. The driver should know which ones are optional, as that's a
> fixed property of the IP and the way the driver uses it.
> 
> You should not be embedding additional semantics in name properties.

Agreed.  I've been on at people about this for years, and every time they
go off and do something else, it ultimately ends up coming back to bite
them.  Clock names _are_ the clock input names as far as device drivers
are concerned, and nothing else.

If there are optional clocks, then the driver should be doing as Mark
says - the driver should try to get them, and if it fails to get them
then they're quite simply not provided by the platform.  If there are
optional clocks which the device driver does not know about (or even
need to know about) then that too should not be a problem - the driver
just doesn't have to touch them.

If they're optional, but required for the device to function, then the
driver should get them and control them as necessary.
