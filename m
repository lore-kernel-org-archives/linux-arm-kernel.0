From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 10:31:12 +0200
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <20150430082051.GA3488@pd.tnic>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <CAL_JsqL8UnDco14Z8H7ZcxS=fLNiYgSb6ivv=zzpVctiD0FptA@mail.gmail.com>
 <20150430082051.GA3488@pd.tnic>
Message-ID: <4411194.KCIZ9l536O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 10:20:51 Borislav Petkov wrote:
> On Wed, Apr 29, 2015 at 06:02:14PM -0500, Rob Herring wrote:
> >  I think that it is silly to group otherwise independent things
> > together and generally not what we do anywhere else in the kernel.
> > They all likely have different capabilities and control mechanisms.
> 
> So let's look at the other extremity here: the moment someone releases
> yet another "independent" IP block with some RAS functionality, same
> someone will create yet another <vendor>_edac_<ip_block> driver. How
> many independent IP blocks are there with RAS functionality? 10, 20,
> 100...? That number is most likely growing, I'd bet.

That should be a safe assumption.

> Oh, and then there'll probably be functionality which is needed by two
> IP blocks so it needs to be shared. So we either copy'paste stuff or
> create a lib only for that functionality...
> 
> Even worse, what if two EDAC drivers for two IP blocks would need to
> talk to each other. That'll be fun.
> 
> Or there'll be a v2 of the IP block which has almost the same
> functionality but no 100% - just a *little* different. So then we go
> create <vendor>_edac_<ip_block-v2> driver. Yuck!
> 
> What I would prefer is to concentrate all vendor-specific RAS
> functionality in one single driver. Shared functionality is then taken
> care of automagically with all the synergies (I hate that word!)
> involved and no unnecessary too finer-grained splitting.
> 
> In that case, we would only have to enable loading more than one EDAC
> drivers on a system which has different RAS IP blocks. Now *that* is a
> much cleaner solution IMO which will keep the sanity in EDAC-land above
> 0.

The problem with your approach is that a lot of these blocks are not
vendor specific. You will probably see a server chip that contains a
memory controller from DesignWare, a cache controller from ARM, and
some other device from the chip vendor, and each of them comes with
EDAC support. Then you get three other vendors that have various
combinations of the same memory controller, cache controller and
other EDAC devices. Not all of these chips would have ARM CPU cores,
some may be e.g. MIPS or PowerPC.

This is very much what we see in all other subsystems (timers,
irqchips, gpio, ...) and the answer is always to have one driver
per device type, and have that driver handle all the variations
of that device, but not group devices into one driver just because
they happen to be on the same chip for one vendor who is merely
integrating them.

	Arnd
