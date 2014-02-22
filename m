From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 22 Feb 2014 09:31:28 +0100
Subject: [PATCH v7 4/8] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <5304A042.7090903@redhat.com>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100234.15040.84232.stgit@pagira.o2s.ch>
 <20140218153731.GK3142@lukather> <5303C751.5090809@redhat.com>
 <20140219094615.GT3142@lukather> <5304A042.7090903@redhat.com>
Message-ID: <20140222083128.GH3931@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

(As a side note, your mailer just did something nasty with the
wrapping which made the code snippets totally unreadable. I'm going to
drop them.)

On Wed, Feb 19, 2014 at 01:14:58PM +0100, Hans de Goede wrote:
> >>>> +	wmb(); /* Ensure idma_des hit main mem before we start the idmac */
> >>> 
> >>> wmb ensure the proper ordering of the instructions, not flushing
> >>> the caches like what your comment implies.
> >> 
> >> Since I put that comment there, allow me to explain. A modern ARM
> >> cpu core has 2 or more units handling stores. One for regular
> >> memory stores, and one for io-mem stores. Regular mem stores can
> >> be re-ordered, io stores cannot. Normally there is no "syncing"
> >> between the 2 store units. Cache flushing is not an issue here
> >> since the memory holding the descriptors for the idma controller
> >> is allocated cache coherent, which on arm means it is not cached.
> >> 
> >> What is an issue here is the io-store starting the idmac hitting
> >> the io-mem before the descriptors hit the main-mem, the wmb()
> >> ensures this does not happen.
> > 
> > To expand a bit, my point was not that it was functionnally
> > wrong. Since you put a barrier in there, and that it resides in a
> > cache coherent section, we're fine.
> > 
> > My point was that the comment itself was misleading.
> 
> Well as explained above, the purpose of the wmb is to ensure that
> the descriptors hit main memory, before the following writel (in the
> caller of this function) starts the controller. So I don't see
> exactly how the comment is wrong.
> 
> If you've a better wording for the comment, suggestions are welcome.

Your first reply was great :)

But if you feel like it enough, fine.

[ codeless snip..] 

> >>> I'd rather put it at a debug loglevel.
> >> 
> >> Erm, this only happens if something is seriously wrong.
> > 
> > Still. Something would be seriously wrong in the MMC
> > driver/controller. You don't want to bloat the whole kernel logs
> > with the dump of your registers just because the MMC is
> > failing. This is of no interest to anyone but someone that would
> > actually try to debug what's wrong.
> 
> This is not a complete register dump, this writes a single line to
> the kernel log saying that an io error happened, and printing the
> error flags set in the status register. We cannot be much shorter
> then this without simply not notifying the user that an io error has
> happened, and not notifying the user is wrong IMHO.

Ok.

> >>>> +	/* And put it back in reset */
> >>>> +	sunxi_mmc_exit_host(host);
> >>> 
> >>> Hu? If it's in reset, how can it generate some IRQs?
> >> 
> >> Yes, that is why we do the whole dance of init controller, get
> >> irq, disable irq, drop it back in reset (until the mmc subsys
> >> does a power on of the mmc card / sdio dev).
> >> 
> >> Sometime the controller asserts the irq in reset for some reason,
> >> so without the dance as soon as we do the devm_request_irq we get
> >> an irq, and worse, not only do we get an irq, we cannot clear it
> >> since writing to the interrupt status register does not work when
> >> the controller is in reset, so we get stuck re-entering the irq
> >> handler.
> > 
> > Hmmm, I see. It probably deserves some commenting here too then.
> 
> This call is the mirror of the sunxi_mmc_init_host a few lines
> higher, which has this comment:
> 
> /* Make sure the controller is in a sane state before enabling irqs */
> 
> Which attempts to explain why we do the init controller, claim irq,
> disable irq, put controller back in reset sequence. Again suggestions
> for a better comment are welcome.

And again, the second part of your first reply was great :)

> >>>> +	ret = mmc_add_host(mmc); 
> >>>> +	if (ret)
> >>>> +		goto error_free_dma;
> >>>> +
> >>>> +	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
> >>>> +	platform_set_drvdata(pdev, mmc);
> >>> 
> >>> This should be before the registration. Otherwise, you're racy.
> >> 
> >> Nope, we only need this to get the data on sunxi_mmc_remove,
> >> everywhere else the data is found through the mmc-host struct.
> > 
> > Still, if anyone makes a following patch using the platform_device
> > for some reason, we will have a race condition, without any way to
> > notice it.
> > 
> > Plus, you're doing all the other bits of initialization of your
> > structures much earlier, why not be consistent and having all of
> > them at the same place?
> 
> Most platform drivers I've worked on do platform_set_drvdata as late
> as possible, so that the drvdata does not get set and never cleared
> in error paths.

You don't actually have to clear it, and some frameworks actually
require you to call dev_set_drvdata before registration, so that
statement looks quite odd to me.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140222/a6da9994/attachment.sig>
