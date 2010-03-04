From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 05 Mar 2010 08:28:34 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267712512.31654.176.camel@mulgrave.site>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
	<1267333263.2762.11.camel@mulgrave.site>
	<20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
	<1267709756.6526.380.camel@e102109-lin.cambridge.arm.com>
	<20100304135128.GA12191@atrey.karlin.mff.cuni.cz>
	<1267712512.31654.176.camel@mulgrave.site>
Message-ID: <1267738114.22204.70.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-04 at 19:51 +0530, James Bottomley wrote:
> 
> Technically, he is.  In the old days, most VI architectures were high
> end enough not to require PIO transfers.  The only exception was an
> IDE driver used by sparc, which lead to the arch specific ide in/out
> string instructions, in which sparc actually did all the necessary
> flushing.

Actually, Catalin's problem is with newer PIPT ARM :-)

> So no other drivers than old IDE grew up with cache flushing in the
> PIO case (and almost no high end VI hardware had an IDE interface, so
> they rarely got implemented in the arch layer).  However, recently,
> with the transition from old IDE to libata and the prevalence of ARM
> with more commodity hardware, the deficiency is becoming exposed.
> Even the PA8000 workstations now come with an IDE CD, which means
> we're starting to have problems with them as well.

I don't think there's a core or driver problem in this specific case. As
we discussed earlier, I believe the problem is that ARM considers a
fresh page out of the page cache as "clean" instead of "dirty", and
inverting that like we do on powerpc will fix their problem too.

> > Seems like ARM has requirement other architectures do not, that is
> > a) not documented anywhere
> > b) causes problems
> > 
> > You could argue that performance improvement (how big is it,
> anyway?)
> > is worth it, but this should be agreed to by wider community...
> 
> Performance is always worth it provided we don't sacrifice
> correctness.
> The thing which was discovered in this thread is basically that ARM is
> handling deferred flushing (for D/I coherency) in a slightly different
> way from everyone else ... once that's fixed, ARM will likely not have
> the D/I problem, but we'll still have the libata (and other PIO
> systems) D flushing issue. 

You mean older VIVT ARM will grow a new issue there ?

Cheers,
Ben.
