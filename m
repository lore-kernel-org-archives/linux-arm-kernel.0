From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 28 Aug 2012 01:02:54 +0300
Subject: [PATCH] arm: omap: ratelimit omap_l3_smx error log spam
In-Reply-To: <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com>
References: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
 <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com>
Message-ID: <20120827220254.GA783@harshnoise.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 27, 2012 at 02:35:57PM -0700, Shilimkar, Santosh wrote:
> > -       pr_err("%s seen by %s %s at address %x\n",
> > +       pr_err_ratelimited("%s seen by %s %s at address %x\n",
> >                         omap3_l3_code_string(code),
> >                         omap3_l3_initiator_string(initid),
> >                         multi ? "Multiple Errors" : "", address);
> > -       WARN_ON(1);
> > +       WARN_ON_ONCE(1);
> >
> The issue needs to be fixed instead of WARN_ON_ONCE() and then
> just moving ahead. Interconnect in bad states is really bad state and you
> won't have reliable operations post that on SOC.

How printing megabytes of identical stack traces helps anything?

This has been there always (since the L3 driver was added) on every boot
with N950/N9 (which BTW are HS devices, not sure if that has anything
to do with it). There is no apparent effect on device functionality,
at least nothing unusual has been observed...

Is there any documentation how to interpret and debug this error report?

A.
