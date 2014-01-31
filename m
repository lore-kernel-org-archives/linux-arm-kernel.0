From: balbi@ti.com (Felipe Balbi)
Date: Thu, 30 Jan 2014 20:29:54 -0600
Subject: [PATCH v2 3/5] spi: sunxi: Add Allwinner A31 SPI controller driver
In-Reply-To: <CAGa+x854huSmiWmEv2EgOPUgZKcp3iitNaBvKXt8DiEj8msSVg@mail.gmail.com>
References: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
 <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
 <20140129122520.GY11841@sirena.org.uk>
 <20140129133227.GQ3867@lukather>
 <CAGa+x854huSmiWmEv2EgOPUgZKcp3iitNaBvKXt8DiEj8msSVg@mail.gmail.com>
Message-ID: <20140131022954.GB8163@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 30, 2014 at 03:52:16PM -0800, Kevin Hilman wrote:
> On Wed, Jan 29, 2014 at 5:32 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Wed, Jan 29, 2014 at 12:25:20PM +0000, Mark Brown wrote:
> >> On Wed, Jan 29, 2014 at 12:10:48PM +0100, Maxime Ripard wrote:
> >>
> >> > +config SPI_SUN6I
> >> > +   tristate "Allwinner A31 SPI controller"
> >> > +   depends on ARCH_SUNXI || COMPILE_TEST
> >> > +   select PM_RUNTIME
> >> > +   help
> >> > +     This enables using the SPI controller on the Allwinner A31 SoCs.
> >> > +
> >>
> >> A select of PM_RUNTIME is both surprising and odd - why is that there?
> >> The usual idiom is that the device starts out powered up (flagged using
> >> pm_runtime_set_active()) and then runtime PM then suspends it when it's
> >> compiled in.  That way if for some reason people want to avoid runtime
> >> PM they can still use the device.
> >
> > Since pm_runtime_set_active and all the pm_runtime* callbacks in
> > general are defined to pretty much empty functions, how the
> > suspend/resume callbacks are called then? Obviously, we need them to
> > be run, hence why I added the select here, but now I'm seeing a
> > construct like what's following acceptable then?
> 
> Even with your 'select', The runtime PM callbacks will never be called
> in the current driver.  pm_runtime_enable() doesn't do any runtime PM
> transitions.  It just allows transitions to happen when they're
> triggered by _get()/_put()/etc.
> 
> > pm_runtime_enable(&pdev->dev);
> > if (!pm_runtime_enabled(&pdev->dev))
> >    sun6i_spi_runtime_resume(&pdev->dev);
> 
> Similarily here, it's not the pm_runtime_enable that will fail when
> runtime PM is disabled (or not built-in), it's a pm_runtime_get_sync()
> that will fail.
> 
> What you want is something like this in ->probe()
> 
>    sun6i_spi_runtime_resume();
>    /* now, device is always activated whether or not runtime PM is enabled */
>    pm_runtime_enable();
>    pm_runtime_set_active();  /* tells runtime PM core device is
> already active */

shouldn't this be done before pm_runtime_enable() ?

>    pm_runtime_get_sync();
> 
> This 'get' will increase the usecount, but not actually call the
> callbacks because we told the RPM core that the device was already
> activated with _set_active().
> 
> And then, in ->remove(), you'll want
> 
>    pm_runtime_put();

in ->remove() you actually want a put_sync() right ? You don't want to
schedule anything since you're just about to disable pm_runtime.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140130/eee0da03/attachment-0001.sig>
