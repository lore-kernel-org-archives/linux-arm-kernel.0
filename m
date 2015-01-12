From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 12 Jan 2015 15:23:59 +0100
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <CACxGe6vRN2Tc97=Sx05gri02goxBaHnZm30hR37q=002agFLAA@mail.gmail.com>
 <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
Message-ID: <20150112142358.GA23680@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2015-01-10 14:44:02, Grant Likely wrote:
> On Wed, Dec 17, 2014 at 10:26 PM, Grant Likely <grant.likely@linaro.org> wrote:
> > On Tue, Dec 16, 2014 at 11:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Monday 15 December 2014 19:18:16 Al Stone wrote:
> >>> 7. Why is ACPI required?
> >>>    * Problem:
> >>>      * arm64 maintainers still haven't been convinced that ACPI is
> >>>        necessary.
> >>>      * Why do hardware and OS vendors say ACPI is required?
> >>>    * Status: Al & Grant collecting statements from OEMs to be posted
> >>>      publicly early in the new year; firmware summit for broader
> >>>      discussion planned.
> >>
> >> I was particularly hoping to see better progress on this item. It
> >> really shouldn't be that hard to explain why someone wants this feature.
> >
> > I've written something up in as a reply on the firmware summit thread.
> > I'm going to rework it to be a standalone document and post it
> > publicly. I hope that should resolve this issue.
> 
> I've posted an article on my blog, but I'm reposting it here because
> the mailing list is more conducive to discussion...
> 
> http://www.secretlab.ca/archives/151

Unfortunately, I seen the blog post before the mailing list post, so
here's reply in blog format.

Grant Likely published article about ACPI and ARM at

http://www.secretlab.ca/archives/151

. He acknowledges systems with ACPI are harder to debug, but because
Microsoft says so, we have to use ACPI (basically).

I believe doing wrong technical choice "because Microsoft says so" is
a wrong thing to do.

Yes, ACPI gives more flexibility to hardware vendors. Imagine
replacing block devices with interpretted bytecode coming from
ROM. That is obviously bad, right? Why is it good for power
management?

It is not.

Besides	being harder to	debug, there are more disadvantages:

* Size, speed and complexity disadvantage of bytecode interpretter in
the kernel.

* Many more drivers. Imagine GPIO	switch,	controlling rfkill
  (for
  example). In device tree case, that's few lines in the .dts
  specifying
  which GPIO that switch is on.

In ACPI	case, each hardware vendor initially implements	rfkill switch
in AML,	differently. After few years, each vendor implements
(different) kernel<->AML interface for querying	  rfkill state and
toggling it in software. Few years after that, we implement kernel
drivers for those AML interfaces, to properly integrate	    them in
the
kernel.

* Incompatibility. ARM servers will now be very different from other
ARM systems.

Now, are there some arguments for ACPI? Yes -- it allows hw vendors to
hack half-working drivers without touching kernel
sources. (Half-working: such drivers are not properly integrated in
all the various subsystems). Grant claims that power management is
somehow special, and requirement for real drivers is somehow ok for
normal drivers (block, video), but not for power management. Now,
getting driver merged into the kernel does not take that long -- less
than half a year if you know what you are doing. Plus, for power
management, you can really just initialize hardware in the bootloader
(into working but not optimal state). But basic drivers are likely to
merged fast, and then you'll just have to supply DT tables.

Avoid ACPI. It only makes things more complex and harder to debug.

            	       	    	  	      	      	  	 Pavel
							 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
