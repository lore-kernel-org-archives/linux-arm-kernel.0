From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Dec 2015 15:30:04 +0000
Subject: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
In-Reply-To: <20151124020631.GA15165@rob-hp-laptop>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
Message-ID: <20151210153004.GA26758@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 08:06:31PM -0600, Rob Herring wrote:

> I think you need something absolute and probably per MHz (like 
> dynamic-power-coefficient property). Perhaps the IPC (instructions per 
> clock) value?

> In other words, I want to see these numbers have a defined method 
> of determining them and don't want to see random values from every 
> vendor. ARM, Ltd. says core X has a value of Y would be good enough for 
> me. Vendor X's A57 having a value of 2 and Vendor Y's A57 having a 
> value of 1024 is not what I want to see. Of course things like cache 
> sizes can vary the performance, but is a baseline value good enough? 

> However, no vendor will want to publish their values if these are 
> absolute values relative to other vendors.

> If you expect these to need frequent tuning, then don't put them in DT.

I agree strongly.  Putting what are essentially tuning numbers for the
system into the ABI is going to lead us into a mess long term since if
we change anything related to the performance of the system the numbers
may become invalid and we've no real way of recovering sensible
information.

There is of course also the issue where people are getting the numbers
from in the first place - were the numbers picked for some particular
use case or to optimise some particular benchmark, what other conditions
existed at the time (cpufreq setup for example), what tuning goals did
the people picking the numbers have and do any of those things
correspond to what a given user wants?  If detailed tuning the numbers
for specific systems matters much will we get competing users patching
the in kernel DTs over and over, and what do we do about ACPI systems?
Having an absolute definition doesn't really help with this since the
concrete effect DT authors see is that these are tuning numbers.

It would be better to have the DT describe concrete physical properties
of the system which we can then map onto numbers we like, that way if we
get better information in future or just decide that completely
different metrics are appropriate for tuning we can just do that without
having to worry about translating the old metrics into new ones.  We can
then expose the tuning knobs to userspace for override if that's needed.
If doing system specific tuning on vertically integrated systems really
is terribly important it's not going to matter too much where the tuning
is but we also have to consider more general purpose systems.

We're not going to get out of having to pick numbers at some point,
pushing them into DT doesn't get us out of that but it does make the
situation harder to manage long term and makes the performance for the
general user less relaible.  It's also just more work all round,
everyone doing the DT for a SoC is going to have to do some combination
of cargo culting or repeating the callibration.

I remember Peter remarking at one of the LPC discussions of this idea
that there had been some bad experiences with getting numbers from 
firmware on other systems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151210/78b5aebc/attachment.sig>
