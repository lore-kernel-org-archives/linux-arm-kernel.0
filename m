From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Jun 2017 09:31:51 +0200
Subject: [PATCH v2 03/11] drm: sun4i: ignore swapped mixer<->tcon
 connection for DE2
In-Reply-To: <CAGb2v66NPY0hDL+sTmyfAQq+cpR6rGtVriXTyDG2CRHjoMMEDw@mail.gmail.com>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-4-icenowy@aosc.io>
 <20170607093512.rfvpefmyskgjw3ik@flea.lan>
 <01A7F22E-C4FF-4B4B-A9BC-FF0C96B996B9@aosc.io>
 <20170607143827.4ng5gedvzn3f5pyx@flea.lan>
 <66881eac1dd06d918692482bdb1ea9e6@aosc.io>
 <20170609144649.67i3zscq26jt5hhe@flea.home>
 <03e5cb4ada3e19ed3476e1d562450f6f@aosc.io>
 <20170613094347.nlvxcaopd5qyq3tb@flea.lan>
 <CAGb2v66NPY0hDL+sTmyfAQq+cpR6rGtVriXTyDG2CRHjoMMEDw@mail.gmail.com>
Message-ID: <20170623073151.p5ubvf6u6htfbggk@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 13, 2017 at 06:05:57PM +0800, Chen-Yu Tsai wrote:
> > That's not true. DE1's can output to several TCONs (or rather, TCONs
> > can select multiple engines as their input). The A31 for example is in
> > this case.
> 
> Actually that's not true. The TCON is bound to the backend. I don't see
> any controls for muxing that. So the TCON-backend search routine is very
> simple for DE1. The frontends are free to feed either backend though.

I think it does, look at the lower bits of TCON0_CTL_REG and
TCON1_CTL_REG in the A31 datasheet. It clearly seems used to control
from which DE you fetch your data from, and you have both options.

> >> For example, if we enabled mixer0, tcon0 and tcon1, tcon1 shouldn't
> >> be bound at all. However in BFS situation tcon1 will also be bound
> >> and then fail to be bound if the backward engine searching is fixed.
> >
> > Short term view: we shouldn't be in that case in the first place.
> > Long term view: there's no reason it shouldn't work.
> 
> Maybe I missed something? TCONs and everything before them should always
> be enabled. There's no reason not to. This is especially true for TCON0
> which holds the mux register on some SoCs.

If we're not able to use anything connected to TCON1, disabling it
still seems like a good stop-gap measure.

> About Maxime's long term view: there's no reason we can't just silently
> ignore a component if its supposed companion is missing, like a TCON
> missing its backend, or the other way around.

It's a bit more complicated than that. TCON0 is probably mandatory,
and even if TCON1 is missing, we can entirely route around it in
hardware, and I think it's the case for all the stages in our
pipelines. There's no reason we could not operate that way.

But this is clearly something that we should aim for, not something
that needs to be done today.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170623/3b50ae2e/attachment.sig>
