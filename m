From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 21 Aug 2014 09:19:35 +0200
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <CAOesGMjFGabNOk0ODjbDN5aaro5309t02+B+UZoM_+q5VE9Ltw@mail.gmail.com>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
 <53EF76CF.9050808@suse.de> <53F2255E.7090208@wwwdotorg.org>
 <CAL1qeaH-WfA-DLKwuXA_hBPHYuXksAibLq__zisrT9ALaRGdAw@mail.gmail.com>
 <53F28F90.3000004@wwwdotorg.org>
 <CAOesGMhBdQh_ddycZ-Y5dupR9hW74bogHtG3yyPUJ2tAgWi19A@mail.gmail.com>
 <20140820143201.GA3368@ulmo>
 <CAOesGMjFGabNOk0ODjbDN5aaro5309t02+B+UZoM_+q5VE9Ltw@mail.gmail.com>
Message-ID: <20140821071933.GG4486@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 08:40:33AM -0700, Olof Johansson wrote:
> On Wed, Aug 20, 2014 at 7:32 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Wed, Aug 20, 2014 at 06:29:14AM -0700, Olof Johansson wrote:
> >> On Mon, Aug 18, 2014 at 4:43 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > [...]
> >> > Again, this board *isn't* Nyan, so it should pretend that it is.
> >>
> >> It is a derivative design of the nyan reference platform, and it is
> >> compatible with it. It is perfectly fine to claim to be compatible
> >> with it. I'm sorry, but you're just wrong here.
> >
> > I guess that depends a little on how you define compatibility. I had
> > always assumed that the top-level compatible string would be a sort of
> > "checksum" over the rest of the content. Which, admittedly, makes it
> > kind of redundant. Compatibility could mean a lot of things. Does it
> > mean any kernel/DTB compatible with one device could run on any device
> > derived from it? Does compatibility mean it needs to provide full
> > functionality or is it still compatible if it runs at a reduced feature
> > set but doesn't "break" otherwise?
> 
> Consider:
>         compatible = "foo,x", "foo,y";
> 
> My interpretation is:  foo,x is compatible with foo,y if and only if:
> 
> foo,x can be driven by the same code as foo,y -- i.e. the driver
> doesn't need changes for basic things to work (and nothing should be
> broken).
> 
> foo,x _can_ be a superset though. It could have features that foo,y
> doesn't have, that needs driver changes to take advantage of. But
> using the foo,y driver with a foo,x device should give you the foo,y
> functionality.
> 
> The simple case is where foo,x is more or less identical to foo,y, but
> there might be some implementation-specific bugs that makes it useful
> to be able to, at some point in the future, tell if you're running on
> a foo,x or foo,y device even if the code is identical today.
> 
> 
> In this particular case, google,nyan and google,nyan-big are very
> similar. There are some differences in panels, etc, but it's described
> in the individual device trees already, but things will come up and be
> functional even if you boot with the wrong device tree (as far as I
> know). Andrew has done that in the past, as far as I know.

The problem with the above that it makes a bunch of assumptions about
drivers. It's perfectly possible for one OS to be implemented in a way
that matches your expectations above, while another OS would not work
the same way.

In particular since you point out panels being different: you typically
can't rely on a driver for one panel to support another panel as well.
While it's true that many panels provide an EDID for the display timings
it's equally well possible that some panels don't, therefore a driver
for one panel can't drive another (because the timings are wrong). There
are other things that can be incompatible between panels such as power
up/down sequences and power supplies. All those together mean that the
panels aren't compatible and I'd argue that the panel is one of the key
features of a Chromebook. Booting a "google,nyan" DTB on a
"google,nyan-big" device may (depending on OS) in fact break
functionality and hence be incompatible.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/59e857eb/attachment.sig>
