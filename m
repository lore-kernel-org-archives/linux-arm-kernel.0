From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 13 Dec 2013 01:44:53 +0200
Subject: [PATCH] dma: mv_xor: fix kernel crash on probe error
In-Reply-To: <CAPcyv4hr2N0kiZabsJJjfmFqTRbT_ntjX4Rdg=THpYg=_2cELg@mail.gmail.com>
References: <1386882715-16433-1-git-send-email-aaro.koskinen@iki.fi>
 <20131212224249.GX4360@n2100.arm.linux.org.uk>
 <CAPcyv4hr2N0kiZabsJJjfmFqTRbT_ntjX4Rdg=THpYg=_2cELg@mail.gmail.com>
Message-ID: <20131212234453.GB8754@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:36:13PM -0800, Dan Williams wrote:
> On Thu, Dec 12, 2013 at 2:42 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Dec 12, 2013 at 11:11:55PM +0200, Aaro Koskinen wrote:
> >> If the non-DT channel add path fails, the kernel will crash as the
> >> channel is not set to NULL and it will try to release the channel using
> >> the error value. Fix that.
> >>
> >> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >> ---
> >>  drivers/dma/mv_xor.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> >> index 7807f0ef4e20..2cb35a62c7f0 100644
> >> --- a/drivers/dma/mv_xor.c
> >> +++ b/drivers/dma/mv_xor.c
> >> @@ -1227,6 +1227,7 @@ static int mv_xor_probe(struct platform_device *pdev)
> >>                                                  cd->cap_mask, irq);
> >>                       if (IS_ERR(xordev->channels[i])) {
> >>                               ret = PTR_ERR(xordev->channels[i]);
> >> +                             xordev->channels[i] = NULL;
> >>                               goto err_channel_add;
> >>                       }
> >>               }
> >
> > Yes, I found this too, and although this is _a_ fix, it's not my
> > preferred.  I'd much prefer this instead - avoid writing invalid
> > channels to xordev->channels[i] in the first place...  Slightly
> > larger patch but IMHO more correct.
> >
> 
> Looks good to me.  Aaro?

I'm also fine this version. Just to be sure, I tested the error path on
my Marvell OpenRD client, so you can put my Tested-by to the final patch.

A.
