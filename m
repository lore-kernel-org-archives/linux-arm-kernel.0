From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Aug 2014 15:24:59 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <CAGRGNgWy=ijkakoKtXiEnFuVQpQT6WXW45-nL4x9DvfTKoA1OA@mail.gmail.com>
References: <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
 <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
 <CAGRGNgWy=ijkakoKtXiEnFuVQpQT6WXW45-nL4x9DvfTKoA1OA@mail.gmail.com>
Message-ID: <20140827132459.GU15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julian,

On Wed, Aug 27, 2014 at 10:45:14PM +1000, Julian Calaby wrote:
> Hi All,
> 
> On Wed, Aug 27, 2014 at 6:37 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Hi Maxime,
> >
> > On Wed, Aug 27, 2014 at 10:22 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> >> On Wed, Aug 27, 2014 at 08:40:57AM +0100, Mark Brown wrote:
> >>> On Tue, Aug 26, 2014 at 08:40:09PM +0200, Henrik Nordstr?m wrote:
> >>>
> >>> > It is not clear to me where the hardware resources should be listed in
> >>> > DT, being it a simplefb node or part of the actual hardware device node
> >>> > properly marked as dynamic boot defaults or something else? It's
> >>> > somewhere inbetween hardware and virtual device, and somewhat volatile.
> >>> > As far as simplefb is concerned it is a hardware desription of the
> >>> > framebuffer, but for a kms driver it's no more than firmware handover of
> >>> > boottime settings and ceases to exists once the kms driver have
> >>> > reconfigured the hardware.
> >>>
> >>> Is simplefb something that should be in the device tree distinctly in
> >>> the first place - shouldn't it be a subset of the functionality of the
> >>> video nodes?  It's the same hardware being driven differently.
> >>
> >> Therorically, yes, but that would mean knowing beforehand what the
> >> final binding will look like, even before submitting the driver. Since
> >> the bindings are always reviewed, and most of the time changed
> >> slightly, that wouldn't work very well with the DT as a stable ABI
> >> policy I guess.
> >
> > If you don't know how the bindings for a device will look like at the time of
> > writing your DTS, you're always screwed, whether you add a simpefb
> > node or not.
> >
> > If you know how the bindings look like, just add the device, with an extra
> > "linux,simplefb" compatibility value.
> > If you don't know how the bindings look like, do your utter best in
> > guessing. Your DTS must be amended later anyway, either because
> > you guessed wrong[*] (in case you added a node to have simplefb
> > working), or because you have to add a real device node (in case you
> > didn't add one for simplefb).
> >
> > [*] Actually you may have guessed right, in which case it'll continue
> >     working as-is, and everybody will be happy.
> >     Whether you want to keep backwards-compatibility in your future driver
> >     with the "guessed wrong" node is up to you.
> 
> I apologise if I'm stepping on anyone's toes or horribly
> misrepresenting device tree's capabilities, but couldn't we start out
> with something like:
> 
> disp at whatever {
>     compatible = "sunxi,sun4i-disp";
>     clocks = <&stuff 1>, <&stuff 2>, <&stuff 3>;

Unfortunately, it's slightly more complicated than that, since there
is several clocks involved, that feed several different IPs that need
to stay on.

In this patch, and given the current code we have, we need to have the
gates for the HDMI controller, the LCD controller and the display
backend, which are three different IPs, with one clock each, that
would be described by three different nodes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/a190f9d6/attachment.sig>
