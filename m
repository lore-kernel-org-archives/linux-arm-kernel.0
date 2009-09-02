From: laforge@gnumonks.org (Harald Welte)
Date: Thu, 3 Sep 2009 08:18:39 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902161252.GD2367@trinity.fluff.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902161252.GD2367@trinity.fluff.org>
Message-ID: <20090902231839.GC32606@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

thanks for your response.

On Wed, Sep 02, 2009 at 05:12:53PM +0100, Ben Dooks wrote:

> > as indicated before, Samsungs SoC Linux developers are currently working
> > on getting more of their work ready for (and submitted to) mainline.
> 
> Whilst this looks like an improvement in the process, will this stick once
> they decide to shuffle the development team(s) and/or the management after
> effort has been put in to sort this out.

Yes, this is definitely the plan!  In fact, one request that I repeatedly get
is "If we submit a driver, can we put an alias/group e-mail address in as the
maintainer for that driver, since then we add/remove developers from/to that
group".  From this example you can see there is difference.

Of course the higher-end SoC's are not only targetting mobile phones or
navigation devices, but are also aiming at mid's or even netbooks - just like
all the ARM SoC vendors are currently doing.  Going for the netbook market
means you need to support not only one distribution but many distros.  Doing
that almost inevitably means that you have to take your code mainline.

Also, there is a strong customer interest in having Samsungs code mainline. Be
assured that those (long-time, over many products) customer is going to pay
close attention that this is not a one-shot effort but continuous.

Right now, the Samsung Linux team has agreed that all of their new development
(mostly for the C110, as that is highest priority here now) will follow mainline
and pull mainline at least every -rcX version and will not stop at any particular
kernel release.

Sure, this does not mean that the code itself will be 100% what the linux
community wants, but it is definitely a change compared to working on old/stable
kernel versions first and then [if at all] trying to bring this forward.

> > We're actively looking for feedback.  you can find Samsungs current code
> > in the 2.6.28-samsung branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/kki_ap/linux-2.6-samsung.git
> > in case you want to review and give feedback.
> 
> I really don't have the time at the moment to go on a fishing trip into
> another vendor kernel tree. There are good reasons why we try to avoid
> this on public lists:

Well if you don't have the time, then don't do it.  I still think it is a 
big improvement that anyone who is interested can now actually on a day-by-day
basis follow what Samsung is doing internally.  This is not much different,
let's say, from any other tree on git.kernel.org.

Sure, this is just the first step, and none of the code in that tree is
supposed to be magically picked up by the kernel guys or supposed to be ready
for a merge.

Samsung will make per-feature patch submissions.  It just takes time.  So in
case anyone is interested having an early look can do it.  Or maybe somebody
actually wants to help.  Community, right?

> 2) It avoids an automatic assumption that any changes in these trees is
>    going to be noticed by the mainatiner.

That is not an assumption I or Samsung have.

> 3) The number of different bases means there is a risk of contaminating
>    trees or ending up with many different trees using disc space.

We have not added a tree, we simply released more existing (but not public)
trees to the public.  I'm sure you can see that is an improvement.

> 4) It avoids the posiblity of being contaminated by accident.

sorry?

> 5) It is contra to the whole Linux development process (see #1)

I think, once again, you are exaggerating.  Would you rather want those
branches that were samsung internal again be closed off?  Do you think that
is better?

> > === plat-s3c/clock.c ===
> > * submit clk->owner bugfix mainline
> 
> I belive that this has been in for a while, or are you talking about
> a different fix?

there are three or four fixes that we're preparing right now.  Preparing since
I need to walk an entire team through every step of the process of creating
per-feature patches, using git, and last but not least we need to send proper
mail to the mailing list.  This is why something simple like that can take
a number of days.  Still, today should be when you receive those.

> > === plat-s3c/gpio.c ===
> > * off-by-one error, send fix mainline
> 
> I think this has been fixed, although if not, why hasn't this been
> submitted already?

Because Samsung was not working on/with mainline before.  Now they have decided
and are learning, but the learning process is ongoing and not finished.

> > === suspend-to-ram ===
> > * port to mainline and test, submit mainline
> 
> I belive suspend-to-ram works for all the current in-kernel devices,
> so shouldn't need any more work. If there are specific problems, please
> report them so we can look at sorting them out.

Ok, it's just a large portion of code that samsung has in its tree and not
in mainline, so I made the assumption it was lacking.  I'll ask them to test
mainline and report back.

> > === adc / touchscreen ===
> > * move plat-s3c24xx/adc.c to plat-s3c/adc.c
> 
> I belive this patch has already been submitted to the list, but not
> sorted out.

Is there any particular reason?  I have looked at the register level
description of 2410,2440,2443 and 6410... they're 99.9% compatible, so it
should definitely move out of there.  I also think the s5pc1xx stuff does
again have the same IP core for ADC/TS.

> > * update it with 6410 specific ADC extensions (12bit, faster clock, ...)
> > * port existing s3c_ts driver to use s3c_adc_register()
> > ** has anyone been doing wokr on this already? ben?
> 
> I have been keeping Arnaud's drviver up to date with mainline for Simtec,
> but as such we've not tried submitting this as there is at least one more
> driver out there (see touchscreen filters which has been already posted
> to this thread).

Yes, and as Nelson has pointed out, the ts_filters are more controversial
and should go in separate.  Can you please get your touchscreen driver
scheduled for merge?  If you have known issues, I can help with them, if
I have the code and know about the issues.

> > * introduce new 'inverted' property in toucscreen platform_data
> > ** the purpose is to support machines that have the (0,0) coordinate not
> >    in the top left corner but a different location of the screen
> > ** use it for runtime checking, remove CONFIG_TOUCHSCREEN_NEW
> 
> I thought tslib should take care of ensuring the proper calibration of
> the touchscreen, such as inversions and any other problems and thus
> baking values in the driver is of no real use?

I was not sure if a complete inversion is actually covered by tslib.  Probably
best to test it. 

> > === video / multimedia ===
> > * needs a lot of thought
> > * support standard mainlien architecture wherever possible
> > ** 2D accelerated framebuffer
> > ** DRI/DRM/TTM/KMS
> > ** V4L
> 
> I am not reallhy sure if there is any current support for using
> hardware blocks for decoding video data. I think that having some
> form of framework for doing these as well as allowing blocks to be
> chained togehter would be useful.
> 
> Again this is something that needs to be taken up with the relevant
> community (assuming there is one) to come to a good solution.

This is relatively difficult, I've been facing the same issues (lack of
infrastructure) in my work for other companies.  On the other hand,
those companies typically don't have the Linux experience to be able
to come up with a good generic architecture for it.

In any case, I only wanted to state "we know there is a problem, and we
are thinking about it, but it is lower priority right now"

> > === s5m8751 PMIC ===
> 
> I don't see why this is being mentioned here, it isn't really part of
> the requirements to get the s3c64xx/s5pc range of devices working.

you can assume that a number of devices will probably buy SoC+PMIC from
the same company, that's why I think it would be beneficial for even for
the s3c/s5c code to have this in mainline.

> Yes, this block is basically an SDHCI system with some changes from
> Samsung for the clocks. It was certainly typical of the previous
> methodology to write a completely new driver where there was an
> existing in kernel driver that could be modified to cover this.
 
Yes, I realize that history.

> > * fix mainline s3c-sdhci clock related bugs, submit mainline
> 
> It would be nice to have timely and accurate bug reports about
> these issues as soon as they are detected. Finding out about
> these later in a long list does not fill me with wonder and joy
> about the whole process.

yes, that will automatically be the case when the Samsung guys work
with something closer to mainline.

> As far as I have been aware, I have not seen any issues with the
> clocks on the s3c6410 or s3c6400 boards. I don't have anything
> after this to test with.

those are ADMA related.

> > * add ADMA support and submit mainline
> 
> I am sure I have asked several times about the seemingly random
> ADMA errors that appear on the S3C6410 (I belive the S3C6400 is
> SDMA only) and what (if anything) can be done about them, which
> is why the driver currently has the ADMA support disabled (and
> a number of extra SDHCI debugging facilities to show state when
> ADMA fails).

this has only been resolved two days agon and the patches are likely
submitted later today.

> > * test / make sure it's feature complete: 1...n patches
> 
> I would hope this would go without saying.

For _you_ this goes without saying.  For _me_ it does.  But have you
ever worked inside / with a company that has never done anything like
this before?  Then you have to make those kind of things explicit.

It is a learning curve, and you cannot expect them to complete that curve in a
second or a day.  This is where people like us can help.

> > * what about 8bit MMC? add as separate patch
> 
> I belive that there is support in the MMC/SD core for this, but not
> yet in the SDHCI driver. I have yet to come across any 8bit SD cards
> out in the wild, so have not looked closer at this.

I think 8bit is really specifically about MMC, not SD.

> > * what about MMC highspeed? add as separate patch
> 
> I belive the SDHCI driver and the MMC/SD core should support high-speed
> cards and do the neccessary setup for the SDHCI controller. If there is
> anything else needed, then an update may be needed to the glue file.

SD Highspeed is independent of MMC highspeed.  The current driver only
supports SD highspeed.

> > * fast boot for movinand? add as separate patch
> 
> As a footnote to this section, I have asked about the correct setup
> data for the extended controll registers which control the clock
> feedbacks in the system. Having tried several of the published
> Samsung kernels (and I have no love for fishing around inside these
> to try and find the correct settings from an #ifdef nightmare in
> some cases) I have yet to find settings that allow for error free
> operation on the SMDK6410...

Can you be more specific about which registers those are?  I'm sure Thomas
would be able to help you, as he has been working on the sdhci-s3c related
fixes over the last few days.

> > === NAND ===
> > * mainline currently uses same driver for s3c24xx and s3c64xx
> > ** samsung uses a new driver for 2450, 6400, 6410 (and later)
> > * does it make sense to extend the mainline driver with new SoC support
> >   or should we rather split the mainline driver?
> 
> It depends, this would better be discussed in a seperate mail about what
> features in the newer devices could do with seperate support. Really this
> and the comments below belong on the MTD list where the issues can be
> thorougly discussed with all the developers involved with the NAND
> subsytem.

of course.  This will likely follow, and i've already posted one initial mail
to linux-mtd yesterday.  Nonetheless I thought it was of interest to you
and other members of linux-arm-kernel to see what is happening and what is
on Samsung's agenda now.

> > * needs more investigation, some code is in samsung tree that is not mainline
> > * what does it do, why?  something alarm related?
> 
> I belive the newer devices have a battery flat indicator, an improved tick
> interrupt control, but basically this is the same block that has been in all
> the Samsing based devices.

thanks, as indicated, we'll investigate further.
> 
> > === SPI ===
> > * separate SPI slave mode changes from actual 64xx driver
> > * start with submitting the SPI master mode driver
> > * then discuss how to add slave to core Linux SPI system
> > * then finally add SPI slave code to s3c driver
> 
> This needs to be taken up with the relevant maintainers. I do see there
> is a lack of support for slave side SPI, but there is currently nobody
> using it.

Right now we (specifically jassi) is planning to rip the slave support out
of Samsungs current code and submit that.  slave support is likely a
more complex issue for later and that should not block the spi master support
from going in.

> > === USB Gadget ===
> > * there are two drivers inside Samsung, one developed by System LSI
> >   and one developed by DMC Lab (Kyungmin Park's team)
> > * discuss with Kyungmin Park's team, decide which driver should go ahead
> 
> How about the one that is already in mainline? I spent a lot of time working
> on that driver and ensuring it was fit to submit. 

I did not realize there was one, my apologies.

> 2) All of the Samsung drivers so far have been badly documented 

Sorry, how well are drivers typically documented in the kernel?  I think
this is not something specific to Samsung, if you're fair about it.

> and seem to have problems of their own. The first variants ignored alignment
> issues, made assumptions about when you can transfer data.

which is a result from lack of understanding the Linux USB api's and their
requirements.  Not everyone is born with the years of experience that you
and others in this field share.

Yes, this is why we have a community development process, and now that Samsung
starts to participate they will also be able to benefit from the review cycles
that will enable more experienced developers to point those things out to them,
_plus_ Samsungs internal developers actually will have permission/time to
address those comments in the code and resubmit - since otherwise the code
does not get mainline, which is a specific customer demand :)

> As a note, this is another case of asking questions about the hardware
> and not getting a lot of useful information back. 

Yes, in a typical semiconductor veondor (any of them) you will never have
actual developers interact with customer.  You always have at least some
management, customer support or the FAE in between.  This is why it is
seriously discouraged for such a developer to interact with somebody like you.

Once again, nothing specific to Samsung at all.  It's the culture of that
industry, and they're as much into it as we are into the Linux culture.  You
might have worked in your culture for a decade or more, and they have in
theirs.

This is different now, but even with the permsision to interact with the
mainline linux developers, it will probably still take some time for every
developer to actually make that kind of change.

> Posting a new driver to the list as 'feedback' is hardly my idea of
> documentation as well as ignoring the usual ettiquete of trying to provide
> patches for an extant driver.

As indicated, the 'new driver' was developed by a completlely independend
part of Samsung, and the System LSI guys didn't even know there was a
different driver until I told them that somebody else from Samsung had
submitted one.   Yes, this is funny - but also very common in corporations
of that size.  

I still remember a friend of mine being hired by Siemens to recommend a PPC
bootloader to them, where he then recommnded to use one that was released by a
different Siemens department as open source.

> It seems quite clear from reading the documentation that the PIO mode
> of operation simply does not work and that I need to either sort out
> the upper layer's use of unaligned buffers or add bounce-buffers to
> the s3c-hsotg.c driver.

I think the driver submitted by Marek + Kyungmin to this list a couple of
months ago claimed to do exactly the opposite:  Support PIO but no DMA.

I'll put this down as something to investigate at Samsung internally.

> > === USB OTG Host ===
> > * Samung's current driver has a OS abstraction layer and is only glued
> >   to Linux.  Reasoning was to have one driver that is chapter9 certified.
> > * However, Linux mianline doesn't accept this
> > * have to write new actual Linux driver
> 
> Hmm.

Do you see any other option or what is this supposed to mean?

> As a final note, myself and Simtec (my employer, if anyone didn't already
> realise) have been supporting the Samsung SoC line for a long time at ours
> or a 3rd party's expense. 

Yes, I'm sorry for that, but as you know this is a reality as long as the
respective semiconductor vendors do not understand the Linux development
model.  Samsung System LSI is by far not the only silicon company who
is still in that situation or was until two weeks ago.

> It is still sad to see that it requires third party intervention (you) to try
> and get them to do things properly.

I do not think it is sad at all.  Which company (or more specifically
semiconductor manufacturer) have you ever seen to magically have all this
knowledge and skill about open source development model, the linux kernel
community, it's culture and rules, ...?

To the best of my knowledge, even for companies like Intel and AMD it was
a process over many years that involved hiring people who have this kind
of background and who can help them first understanding and then learning
this process.  Alternative is to partner with a company who does, see e.g.
the x86_64 work done by SuSE(Andi Kleen) for AMD.

So rather to the opposite, I think it affords my (and hopefully others')
respect that they have finally made a [r&d management] choice to change.   Yes,
this would have been better and easier four years ago.  But we can't change the
past, can we?

Let's rather focus on what we can do from now on, in this new situation.

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
