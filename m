From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 11 May 2012 16:07:41 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120511142941.GA16214@n2100.arm.linux.org.uk>
References: <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
 <20120510094205.GM3908@opensource.wolfsonmicro.com>
 <1336647675.15424.390.camel@vkoul-udesk3>
 <20120511140710.GC6220@n2100.arm.linux.org.uk>
 <20120511141835.GF3960@opensource.wolfsonmicro.com>
 <20120511142941.GA16214@n2100.arm.linux.org.uk>
Message-ID: <20120511150741.GH3960@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 03:29:41PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 11, 2012 at 03:18:35PM +0100, Mark Brown wrote:

> > I do think that (separately to what ALSA does) if we're going to have a
> > callback specified per request we really should make sure that they all
> > get run as best as we can since the way the API is written people using
> > non-cyclic transfers may run into the same surprise; for cyclic ones the
> > issue you identify is very real though.

> Please stop confusing non-cyclic with cyclic transfers.  We know what the
> required semantics are for non-cyclic transfers and they really aren't
> under discussion here.  I'm focusing 100% on the cyclic case here.

I'm not confusing them - I'm just pretty sure that all the issues which
you are identifying also apply to the non-cyclic case so while we're
looking at fixing things we (collectively, not particularly including
you as you're focused on the cyclic case) should look at that too.
Right now we're not handling either cyclic or non-cyclic cases well.

> That's my point.  And keeping count of N times to call the callback in
> the DMA engine driver is racy at best.

Yes, it'll always break down at some point - no argument there.

> Here's what I think.  I think the best solution for cyclic transfers
> is as follows:

I agree, for cyclic transfers this is a very good approach.  I'd
probably even set up a separate callback mechanism for cyclic transfers
to make this crystal clear and error out if an attempt was made to use
the linear one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120511/b42d9312/attachment.sig>
