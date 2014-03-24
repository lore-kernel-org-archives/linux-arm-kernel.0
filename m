From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Mar 2014 10:41:37 +0100
Subject: [PATCH] i2c: mv64xxx: Fix compilation breakage
In-Reply-To: <4177769.XedaQsoUgV@wuerfel>
References: <1394204370-22979-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAP=VYLqCmG6fRmPPABoW4xg_tFgGh2pji=f5ML=cBgCu4zZocg@mail.gmail.com>
 <20140321191739.GT27873@lukather> <4177769.XedaQsoUgV@wuerfel>
Message-ID: <20140324094137.GB5416@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 12:11:24PM +0100, Arnd Bergmann wrote:
> On Friday 21 March 2014 20:17:39 Maxime Ripard wrote:
> > On Fri, Mar 21, 2014 at 11:49:59AM -0400, Paul Gortmaker wrote:
> > > On Mon, Mar 10, 2014 at 7:29 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Mon, Mar 10, 2014 at 11:58:08AM +0100, Maxime Ripard wrote:
> > > >> On Fri, Mar 07, 2014 at 04:08:36PM +0000, Russell King - ARM Linux wrote:
> > > >> > On Fri, Mar 07, 2014 at 03:59:30PM +0100, Maxime Ripard wrote:
> > > >> > > @@ -900,7 +902,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
> > > >> > >  exit_free_irq:
> > > >> > >   free_irq(drv_data->irq, drv_data);
> > > >> > >  exit_reset:
> > > >> > > - if (pd->dev.of_node && !IS_ERR(drv_data->rstc))
> > > >> > > + if (pd->dev.of_node && IS_ENABLED(CONFIG_RESET_CONTROLLER) &&
> > > >> > > +     !IS_ERR(drv_data->rstc))
> > > >> > >           reset_control_assert(drv_data->rstc);
> > > >> >
> > > >> > Another question is... why do we need to check pd->dev.of_node here?
> > > >> > If CONFIG_RESET_CONTROLLER is set, we always try to get the reset
> > > >> > controller node, so drv_data->rstc is either going to be a valid
> > > >> > pointer, or it's going to be an error pointer - neither
> > > >> > reset_control_get() nor devm_reset_control_get return NULL.
> > > >>
> > > >> Following back on this as I was doing the patch, actually,
> > > >> drv_data->rstc will be NULL if we're not probed by DT, and hence never
> > > >> call reset_control_get, that would set an error pointer.
> > > >>
> > > >> But then, we can use IS_ERR_OR_NULL on drv_data->rstc.
> > > >
> > > > I think you can also move the devm_reset_control_get() into the main
> > > > probe function: you're only checking for -EPROBE_DEFER from it to fail,
> > > > allowing other errors to continue with the driver init.  This means
> > > > that on non-OF, devm_reset_control_get() will fail with -ENOENT.
> > > 
> > > Looping linux-next into the CC since this is the cause of the failure
> > > in orion5x_defconfig there, and no point in anyone else re-doing the
> > > same bisect.
> > 
> > I sent a fix for this that hasn't been picked up yet:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/239069.html
> > 
> > IIRC, Wolfram's away until Monday, so I guess it will be merged some
> > time next week.
> 
> I think there is something wrong with an interface that makes you use
> IS_ERR_OR_NULL(). If you are calling reset_control_get_optional(), that'
> should not return an error when there is no reset controller listed
> in the device tree. We should still have a way to propagate -EPROBE_DEFER,
> or bail out if there is a reset controller but there is something wrong
> with it, but otherwise I'd suggest just leaving NULL as a valid pointer
> in drv_data->rstc and making sure that the reset controller functions
> can just deal with a NULL argument, so you never have to check it again.

Actually, it's not the reset framework but the driver itself that
needs this. The framework will always return an error pointer here,
but we won't ever call reset_control_get_optional if we are not probed
with DT, and in that case, we will have NULL is data->rstc, hence why
we need to use IS_ERR_OR_NULL.

We should probably fix the reset functions, but maybe that can come
later so that we have marvell's defconfig fixed?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/65825df2/attachment.sig>
