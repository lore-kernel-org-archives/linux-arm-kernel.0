From: andy.green@linaro.org (Andy Green)
Date: Wed, 24 Apr 2013 07:30:02 +0800
Subject: [PATCHv3 00/14] drivers: mailbox: framework creation
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C504A63B4@DLEE11.ent.ti.com>
References: <1363145021-14339-1-git-send-email-s-anna@ti.com>
 <CABb+yY0RYkVeo2Sb4WsDJY0jf17488FEz0d2CB994eQaSOEsVg@mail.gmail.com>
 <37C860A02101E749A747FA2D3C1E3C504A5DF7@DLEE11.ent.ti.com>
 <CABb+yY1x4x_A+QtGG9ohsLPgs8c3nEVnd_ExJBGOOR8=6YLPFA@mail.gmail.com>
 <37C860A02101E749A747FA2D3C1E3C504A63B4@DLEE11.ent.ti.com>
Message-ID: <5177197A.4050104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/13 03:20, the mail apparently from Anna, Suman included:

Hi Suman -

> This series missed the 3.9 merge window, and is currently slated for
> getting merged into 3.10. The PL320 made it into 3.9 itself (I wasn't
> aware of it until I saw it in mainline) and created the
> drivers/mailbox folder.  I would think it would be relatively
> straight-forward to adopt it to the mailbox API, as it has only 3
> API. We should be doing incremental changes on top of this series, as
> most of the base API would still be the same. The current series is
> helping out with couple of efforts, the breaking up of the PRCMU code
> and on the multiplatform support for OMAP with mailbox enabled. We
> can definitely collaborate on the improvements. Andy Green would also
> be interested, as he is also looking into adopting the mailbox API.

To clarify Jassi works on my team, after I wrote two Mailbox drivers for 
two different IP on the chips we're working on, I handed them off to him 
and Jassi's working on further integration using those drivers.  So 
we're both doing the same thing.

 From my POV I am very happy you made the new API - before that there 
was only PL320 sitting there and nothing you could call an API.  Once I 
understood the approach (no docs was a bit painful) I was able to 
implement both drivers we needed with what you have.

The main problem I have with it we discussed in direct mail previously, 
since we have two different mailbox IP, we need to improve the register 
/ unregister so it can cope, right now it's unnecessarily limited to one 
mailbox driver.

That "there can only be one" approach also leaked out into the drivers 
having filescope statics for things that should have been instantiated 
per-mailbox device (including device naming as literals, rather than 
mbox%d needed if there can be multiple drivers).  In my driver 
implementations I moved them to live in the per-device priv struct and 
stored the names in there too.

The other point I mentioned before was the FIFO, it's always there and 
size set by CONFIG_ stuff.  Actually it would be better if it was set 
per mailbox or per mailbox driver at runtime.  For one of the IPs, we 
will have another driver mediating access to the mailbox that enforces a 
single client access covering possibly multiple mailbox messages.  Under 
those conditions, a fifo isn't really meaningful.  But that's less of a 
problem.

As I say I was very happy to see you addressing the lack of an API, 
Jassi though is working deeper with it than just making the mailbox 
drivers as I did; he's using the API from other consumer drivers so he 
may have a different set of concerns or, looking at what he's written 
here, opportunities.

-Andy

-- 
Andy Green | Fujitsu Landing Team Leader
Linaro.org ? Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
