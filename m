From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Jun 2013 14:58:31 +0100
Subject: Cache issues in vexpress cpu shutdown (regression in 3.10)
In-Reply-To: <1370439902.3446.15.camel@linaro1.home>
References: <1370430551.3387.11.camel@linaro1.home>
 <20130605113912.GE18614@n2100.arm.linux.org.uk>
 <20130605115046.GA11402@mudshark.cambridge.arm.com>
 <1370439902.3446.15.camel@linaro1.home>
Message-ID: <20130605135831.GE11402@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 02:45:02PM +0100, Jon Medhurst (Tixy) wrote:
> On Wed, 2013-06-05 at 12:50 +0100, Will Deacon wrote:
> > On Wed, Jun 05, 2013 at 12:39:12PM +0100, Russell King - ARM Linux wrote:
> > > Could it be that flush_cache_louis() doesn't actually do what it claims
> > > to?
> > 
> > Smells like erratum #643719, which was fixed in r1p0 of A9. The LoUIS value
> > in the CLIDR reports 0 instead of 1.
> > 
> > Tixy -- if you can confirm the above (i.e. your register has the wrong
> > value) then we can come up with a workaround. I'm not sure whether any
> > platforms other than vexpress have such an early A9 revision though...
> 
> Yes, you have a good nose. The LoUIS value reads zero and hacking
> v7_flush_dcache_louis to force it to one makes the problems go away.

Ok, that confirms it then.

> So, is the correct fix to add an errata config option to add a check for
> an r0p? ARM A9 when LoUIS value reads as zero?

That's the most general solution, yes.

> I'm not sure that we should just add flush_cache_all back to the
> vexpress cpu_enter_lowpower because flush_cache_louis is used in several
> places and could also cause problems there. Though presumably not that
> serious problems if we've gone this time without anyone noticing...

Hence my question earlier on: does any platform other than VE actually have
a pre r1p0 A9 in it? If we don't know, then your solution above sounds
reasonable.

Will
