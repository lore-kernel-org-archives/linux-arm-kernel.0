From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jan 2014 20:36:34 +0100
Subject: [RFC PATCH V2 1/4] pci: APM X-Gene PCIe controller driver
In-Reply-To: <CACoXjcnTnhWS-5yOgiHA5yVaBjdH1DVzmSsknEBJLB+CFR0EyA@mail.gmail.com>
References: <1389742458-7693-1-git-send-email-tinamdar@apm.com>
 <5086198.ZOWZ5xuyna@wuerfel>
 <CACoXjcnTnhWS-5yOgiHA5yVaBjdH1DVzmSsknEBJLB+CFR0EyA@mail.gmail.com>
Message-ID: <201401292036.34501.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 January 2014, Tanmay Inamdar wrote:
> On Sat, Jan 25, 2014 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 24 January 2014 13:28:22 Tanmay Inamdar wrote:
> >> On Thu, Jan 16, 2014 at 5:10 PM, Tanmay Inamdar <tinamdar@apm.com> wrote:
> >> > On Wed, Jan 15, 2014 at 4:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> On Wednesday 15 January 2014, Tanmay Inamdar wrote:
> >> >>
> >> >> Maybe another msleep() in the loop? It seems weird to first do an
> >> >> unconditional sleep but then busy-wait for the result.
> >> >
> >> > ok.
> >>
> >> This loop can execute for maximum 4 msec. So putting msleep(1) won't
> >> get us much.
> >
> > 4 msec is still quite a long time for a busy loop that can be spent doing
> > useful work in another thread.
> >
> 
> Right. If 'msleep(1)' is used, then 'checkpatch' throws a warning
> saying that it can actually sleep for 20ms in some cases. I will check
> if 'usleep_range' is useful here.

Sound good. This is really a false positive from checkpatch though,
with the timeout handling in place, everything's fine even with
msleep(1).

> >> >>
> >> >> Another general note: Your "compatible" strings are rather unspecific.
> >> >> Do you have a version number for this IP block? I suppose that it's related
> >> >> to one that has been used in other chips before, or will be used in future
> >> >> chips, if it's not actually licensed from some other company.
> >> >
> >> > I will have to check this.
> >> >
> >>
> >> We have decided to stick with current compatible string for now.
> >
> > Can you elaborate on your reasoning? Does this mean X-Gene is a one-off
> > product and you won't be doing any new chips based on the same hardware
> > components?
> 
> The current convention is to key upon the family name - X-Gene. Future
> chips will also be a part of X-Gene family. Right now it is unclear if
> there are any obvious feature additions to be done in Linux PCIe
> driver. Until then same driver is expected to work as is in future
> chips.

This is not enough for me. Of course you hope that things keep working,
but experience shows that sometimes hardware has slight differences that
you need to work around later. It's better to always be specific and
at least as a secondary identifier list the exact model of the component,
or if that is not know, the model of the SoC. The driver can bind to
the most generic string, but in DT you should have a specific one as
well.

You could for instance have something like

	compatible = "apm,xgene-1234w78-pcie", "thirdparty,pcie-1.23", "apm,xgene-pcie", "thirdparty,pcie";

as an example where you licensed the pcie block version 1.23 from a company
named thirdparty and integrated it into the xgene variant with product
code 1234w78.

	Arnd
