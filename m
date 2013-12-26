From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Dec 2013 11:34:16 -0800
Subject: [PATCH] regmap: Allow regmap_bulk_write() to work for "no-bus"
 regmaps
In-Reply-To: <20131224125358.GB30815@sirena.org.uk>
References: <52A7C0C3.2070805@codeaurora.org>
 <20131211132729.GT11468@sirena.org.uk>
 <52AA42FD.4040503@codeaurora.org>
 <20131213104128.GT11044@sirena.org.uk>
 <20131213213707.GO21983@codeaurora.org>
 <20131216210153.GA3185@sirena.org.uk>
 <20131217023047.GC31766@codeaurora.org>
 <20131218184541.GH31886@sirena.org.uk>
 <52B897A1.8030205@codeaurora.org>
 <20131224125358.GB30815@sirena.org.uk>
Message-ID: <20131226193416.GI31766@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24, Mark Brown wrote:
> On Mon, Dec 23, 2013 at 12:05:53PM -0800, Stephen Boyd wrote:
> > On 12/18/13 10:45, Mark Brown wrote:
> 
> > > This doesn't quite work - val is an array of objects of the size of the
> > > size of a register not of unsigned integers so you're parsing extra data
> > > out there.  That possibly wasn't the best choice of API but we have
> > > quite a few users now so ick.
> 
> > Are you concerned that we'll read past the end of the val buffer? Do we
> > need to cast the pointer to be the appropriate size according to
> > val_bytes? Something like this?
> 
> That's one issue, the other is that if we try to read (say) and 8 bit
> value as an unsigned int we'll not just read the value we're looking
> for.

Ah right. My no-bus implementation was clearing out the upper 24
bits of the word so I could just send the u8 value. With this
approach that isn't necessary.

> 
> >                 for (i = 0; i < val_count; i++) {
> >                         unsigned int ival;
> > 
> >                         switch (val_bytes) {
> >                         case 1: 
> >                                 ival = *(u8 *)(val + (i * val_bytes));
> >                                 break;
> 
> I think we do sadly.  Or refactor the API to work in unsigned ints
> which would've been more sensible in the first place but that'd make it
> asymmetrical with the read API as it stands...

Ok it sounds like you're willing to go with this updated loop.
I'll resend a proper patch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
