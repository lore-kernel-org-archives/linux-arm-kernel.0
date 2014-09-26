From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 26 Sep 2014 12:04:46 +0200
Subject: [PATCH v5 00/11] PM / Domains: Generic OF-based support
In-Reply-To: <CAMuHMdUqHZWrQGx=y8_yEJ7G9H5C=Y14-qPCMVJC6mxS5Sdb6A@mail.gmail.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo> <7hppej8glk.fsf@deeprootsystems.com>
 <20140926073125.GB31106@ulmo>
 <CAMuHMdWq9ZySdt8sQpBFq=X7LR5a=vZkowNZoB8NHztTisG+NQ@mail.gmail.com>
 <20140926095647.GI31106@ulmo>
 <CAMuHMdUqHZWrQGx=y8_yEJ7G9H5C=Y14-qPCMVJC6mxS5Sdb6A@mail.gmail.com>
Message-ID: <20140926100445.GL31106@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 12:01:13PM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
> 
> On Fri, Sep 26, 2014 at 11:56 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >> > An alternative would be to make the power-domain controller look up the
> >> > clock within the user's device tree node. That could be problematic,
> >> > because while the module clock is always the first clock in current
> >> > device trees, there aren't ordering guarantees, so we'd have to rely on
> >> > the clock name.
> >>
> >> Or on some other way.
> >> Do you have a separate hardware block that controls all (and only) the
> >> module clocks?
> >
> > No, the "clock and reset controller" controls all clocks (and resets) on
> > the SoC.
> 
> Sorry, with "only the module clocks" I meant "not clocks that are not module
> clocks". Having a reset controller function in there is fine.
> 
> So it seems you do have a clock provider that provides module clocks,
> and can mark them CLK_RUNTIME_PM.
> 
> >> On shmobile SoCs, all module clocks are controlled using the MSTP
> >> (Module SToP) clocks.
> >>
> >> In my old RFC series "[PATCH/RFC 0/4] of: Register clocks for Runtime PM
> >> with PM core" (https://lkml.org/lkml/2014/4/24/1118) the MSTP clock driver
> >> advertised using a new CLK_RUNTIME_PM flag that its clocks are module
> >> clocks and thus suitable for runtime PM.
> >>
> >> There were some issues with that series, but the general idea of letting a
> >> clock driver advertise that all its clocks are module clocks could still be
> >> useful. Then the power domain driver knows which clocks to manage.
> >
> > That sounds interesting. Although it would still mean that we need a way
> > to associate a clock with the correct power domain. I guess the driver
> > could do that by iterating over all available clocks in the device's
> > clocks property and grab only those that are marked CLK_RUNTIME_PM.
> 
> Yes, that's the idea.

It sounds like this could work. Reading up on the thread you linked to
there's some resistance to merging what you propose, though. Given that
we may want to control the clocks and resets in the controller as well,
maybe duplicating the clock references would actually be the proper way
to do it.

I'll have to think a little bit more about it, or implement it to see
how it all fits. Thanks for the pointers.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/0df1770d/attachment-0001.sig>
