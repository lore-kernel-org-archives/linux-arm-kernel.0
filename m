From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jan 2014 16:40:35 +0000
Subject: [PATCH v2 3/5] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <20140129133227.GQ3867@lukather>
References: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
 <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140129122520.GY11841@sirena.org.uk>
 <20140129133227.GQ3867@lukather>
Message-ID: <20140129164035.GC22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 02:32:27PM +0100, Maxime Ripard wrote:
> On Wed, Jan 29, 2014 at 12:25:20PM +0000, Mark Brown wrote:

> > A select of PM_RUNTIME is both surprising and odd - why is that there?
> > The usual idiom is that the device starts out powered up (flagged using
> > pm_runtime_set_active()) and then runtime PM then suspends it when it's
> > compiled in.  That way if for some reason people want to avoid runtime
> > PM they can still use the device.

> Since pm_runtime_set_active and all the pm_runtime* callbacks in
> general are defined to pretty much empty functions, how the
> suspend/resume callbacks are called then? Obviously, we need them to
> be run, hence why I added the select here, but now I'm seeing a
> construct like what's following acceptable then?

> pm_runtime_enable(&pdev->dev);
> if (!pm_runtime_enabled(&pdev->dev))
>    sun6i_spi_runtime_resume(&pdev->dev);

I think you're looking for pm_request_idle() - just leave the device
started by default and kick the system to suspend it.

> Actually the IP asserts the CS automatically, the only thing you need
> to do is to set which CS to use for your next transfer in some
> register (which is what I'm doing after the !enable), and the CS will
> be managed directly by the controller. Hence, there's no way to say
> wether you want to enable it or not.

> The controller allows to control the CS manually also, if that's the
> preferred way of doing things.

Yes, that's required to provide set_cs() - it's there so that things
like the cs_change option in transfers can be factored out into the
core.  We may in future want to integrate the ability to switch between
manual and automatic management but it's likely to be more trouble than
it's worth.

> > This means we can only transfer a single FIFO of data?  I didn't see a
> > check on the transfer length.

> At the moment, indeed. And that's the first thing I check in the
> transfer_one function.

Oh, so it is - sorry.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140129/886075ea/attachment.sig>
