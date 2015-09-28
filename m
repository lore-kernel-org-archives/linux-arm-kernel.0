From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 28 Sep 2015 15:07:23 +0200
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <2003030.YkVHTCZahK@wuerfel>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <1578470.DLzaBp4j3T@vostro.rjw.lan> <2003030.YkVHTCZahK@wuerfel>
Message-ID: <14747297.j7J33tmxDW@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 28, 2015 10:24:58 AM Arnd Bergmann wrote:
> On Sunday 27 September 2015 16:10:48 Rafael J. Wysocki wrote:
> > On Saturday, September 26, 2015 09:33:56 PM Arnd Bergmann wrote:
> > > On Saturday 26 September 2015 11:40:00 Viresh Kumar wrote:
> > > > On 25 September 2015 at 15:19, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > So if you allow something like debugfs to update your structure, how
> > > > > do you make sure there is the proper locking?
> > > > 
> > > > Not really sure at all.. Isn't there some debugfs locking that will
> > > > jump in, to avoid updation of fields to the same device?
> > > 
> > > No, if you need any locking to access variable, you cannot use the
> > > simple debugfs helpers but have to provide your own functions.
> > > 
> > > > >> Anyway, that problem isn't here for sure as its between two
> > > > >> unsigned-longs. So, should I just move it to bool and resend ?
> > > > >
> > > > > I guess it might be more convenient to fold this into the other patch,
> > > > > because we seem to be splitting hairs here.
> > > > 
> > > > I can and that's what I did. But then Arnd asked me to separate it
> > > > out. I can fold it back if that's what you want.
> > > 
> > > It still makes sense to keep it separate I think, the patch is clearly
> > > different from the other parts.
> > 
> > I just don't see much point in going from unsigned long to u32 and then
> > from 32 to bool if we can go directly to bool in one go.
> 
> It's only important to keep the 34-file multi-subsystem trivial cleanup
> that doesn't change any functionality separate from the bugfix.

Which isn't a bugfix really, because the EC code is not run on any big-endian
systems to my knowledge.  And it won't matter after the [2/2] anyway.

And the changelog of it doesn't really makes sense, because it talks about
future systems, but after the [2/2] no future systems will run that code in
the first place.

> If you like to avoid patching one of the files twice, the alternative would
> be to first change the API for all other instances from u32 to bool
> and leave ACPI alone, and then do the second patch that changes ACPI
> from long to bool.

My point is that this patch doesn't matter.  It doesn't really fix anything
and the result of it goes away after the second patch.

The only marginal value of having it as a separate commit is in case if
(a) we need to revert the [2/2] for some reason and (b) ACPI-based ARM systems
(the big-endian ones) become full-hardware at one point.  You know what the
chances of that are, though. :-)

That said I've ACKed the patch, because I don't care that much.  I'm not exactly
sure why you care either.

Thanks,
Rafael
