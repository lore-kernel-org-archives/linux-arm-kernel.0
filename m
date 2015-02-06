From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Feb 2015 18:11:29 -0800
Subject: [PATCH v3 08/13] mtd: st_spi_fsm: Update the JEDEC probe to
 handle extended READIDs
In-Reply-To: <20150121130204.GC22024@x1>
References: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
 <1418644760-18773-9-git-send-email-lee.jones@linaro.org>
 <20150113050715.GQ9759@ld-irv-0074> <20150121130204.GC22024@x1>
Message-ID: <20150206021129.GB18140@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 01:02:04PM +0000, Lee Jones wrote:
> On Mon, 12 Jan 2015, Brian Norris wrote:
> > On Mon, Dec 15, 2014 at 11:59:15AM +0000, Lee Jones wrote:
> > > The previous code was based on 3-byte JEDEC IDs, with a possible 2-byte
> > > extension.  However, devices are now emerging that return 6 or more bytes of
> > > READID data and the additional bytes are required to differentiate between
> > > variants or generations of similar devices.
> > > 
> > > This patch refactors the device table and JEDEC probe code to handle arbitrary
> > > length READIDs, with the standard JEDEC definition now becoming a special case.
> > > Functionally, there should be no change in behaviour.  A subsequent patch will
> > > update the table with extended READIDs where applicable.
> > 
> > BTW, how's that promise going, where you work on adapting this driver to
> > the spi-nor framework? We've already done some of this same work there.
> 
> I have pushed this point within ST and someone has agreed to do the
> work.  Last I heard it relied on these patches, but I'll ask again.

OK.

> > > +#define RDID(...) __VA_ARGS__  /* Dummy macro to protect array argument. */
> > 
> > What? What needs "protected"?
> 
> You're asking me questions I can't answer I'm afraid and Angus has now
> left the building.  I guess he thinks __VA_ARGS__ will prevent some
> kind of overflow?

If you don't understand your own code, how can I be expected to maintain
it? This one's pretty trivial and harmless, but an accumulation of
answers like this don't exactly put me in a good mood.

FWIW, I expect the comment has nothing to do with the __VA_ARGS__; it's
just commenting that he has placed a macro around the array just in case
somebody needs/wants to rearrange formats later. That way, we don't
necessarily have to rewrite the whole table, but can just change the
macros.

So the __VA_ARGS__ is just there to make the compiler happy (it thinks
an array argument to a macro actually looks like more than one
argument), and the comment is only mildly descriptive of its purpose.

Brian
