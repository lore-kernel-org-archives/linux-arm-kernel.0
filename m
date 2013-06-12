From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Jun 2013 17:37:36 +0200
Subject: [PATCHv4 2/9] i2c: mv64xxx: make the registers offset configurable
In-Reply-To: <51B88DB0.90302@gmail.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130612135735.GR18614@n2100.arm.linux.org.uk>
 <20130612144447.GI16699@lukather> <51B88DB0.90302@gmail.com>
Message-ID: <20130612153736.GL16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wed, Jun 12, 2013 at 05:03:12PM +0200, Sebastian Hesselbarth wrote:
> On 06/12/13 16:44, Maxime Ripard wrote:
> >Hi Russel,
> >
> >On Wed, Jun 12, 2013 at 02:57:35PM +0100, Russell King - ARM Linux wrote:
> >>On Wed, Jun 12, 2013 at 10:07:11AM +0200, Maxime Ripard wrote:
> >>>The Allwinner i2c controller uses the same logic as the Marvell one, but
> >>>with slightly different register offsets.
> >>>
> >>>Introduce a structure that will be passed by either the pdata or
> >>>associated to the compatible strings, and that holds the various
> >>>registers that might be needed.
> >>
> >>I don't like this change.  It introduces further indirection where it's
> >>not really necessary, and it's also using platform data to specify this
> >>which is in the opposite direction to what's required for moving towards
> >>DT.
> >
> >Well, some users of this aren't converted to DT, hence why I made the
> >changes to the platform_data.
> 
> Actually, this is not quite true. Yes of course, there are still users
> of non-DT Marvell SoCs and it is still in the progress of full-DT. But
> also ppc is using DT, except that they parse it and put in in
> platform_data. Reasonable since back then, there was no global DT API
> available.

Ah, I see, thanks for the insight. I was here referring more
specifically to Orion that seems to be still stuck with !DT at the
moment, at least partially.

> IMHO for the time in between (i.e. now) check for pdev->dev.of_node
> and !pdev->dev.platform_data will allow you to distinguish all users
> perfectly:
> 
> - non-DT has platform_data set only
> - ppc DT has of_node and platform_data set
> - pure DT has of_node set only
> 
> This will allow you to limit your register offset modifications to
> Allwinner exclusively and for pure DT (if that is what you want for
> Allwinner).
> 
> Checkout mv643xx_eth in net-next where the above discrimination
> strategy was chosen.
> 
> [...]
> >>I'd suggest making the default register offsets be the drivers existing
> >>offsets, and allowing it to be overriden.  That nicely sorts out the
> >>next comment below, and also gets rid of it in platform data.  Moreover,
> >>if you're going to re-use this driver, you should do it via a different
> >>"compatible" name in DT, which the driver can then use to identify the
> >>different register set layout.
> >
> >The logic here will change quite a bit in the next iteration thanks to
> >the comments I received.
> >
> >I'm now using a platform_device_id structure to match the name of the
> >driver just like what was done with the DT in that patchset. This also
> >removes the need to add the regs field to the platform data and ...
> 
> Also here, if Allwinner is pure DT, you can call some
> mv643xx_i2c_of_probe() for pure DT only with the above discrimination.

Unless I'm missing something, isn't it what's already in place here?

We have:

if (pdata) {
    /* Fill in the driver data structure from pdata */
} else if (pd->dev.of_node) {
    /* Fill in the driver data structure from dt */
} else {
    return -EFAIL;
}

I guess that should cover all the cases you mentionned, even the PPC
one, right?

Now, the question about what content do we find in these platform_data
is actually a different one. This patch passed the regs offset as a
member of those. We all agreed that it was not the most elegant solution
(and like you mentionned, I will never use this pdata structure anyway
for the Allwinner stuff).

I guess we could just take the marvell offsets when using pdata, and use
different register offsets based on the compatibles when loading from
dt?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
