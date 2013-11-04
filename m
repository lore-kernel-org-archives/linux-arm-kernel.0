From: neko@bakuhatsu.net (Matt Sealey)
Date: Mon, 4 Nov 2013 17:20:20 -0600
Subject: [PATCH v4] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAHCPf3v0G_551Oeq-dL61J0Ce-iUMv+ou8+q671S8=GEcNjv5w@mail.gmail.com>
References: <1383181127-12013-1-git-send-email-festevam@gmail.com>
 <5272BC59.1080109@boundarydevices.com>
 <5272BFE0.5040409@boundarydevices.com>
 <CAOMZO5C39JNVv0vz-38eOrKHXMqWHCeCknhSvfGFe5t0EGkDsg@mail.gmail.com>
 <20131031210053.GH16735@n2100.arm.linux.org.uk>
 <CAOMZO5DAAXg4wP2UuYCN6BgN5-q3sv0Lrqvk8xMDmEW_TXepXg@mail.gmail.com>
 <CAHCPf3v0G_551Oeq-dL61J0Ce-iUMv+ou8+q671S8=GEcNjv5w@mail.gmail.com>
Message-ID: <CAHCPf3tSdn=TJ86QEtL3r9iSP0j88WP-y2=z96ZUfW-7VecMbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 4:48 PM, Matt Sealey <neko@bakuhatsu.net> wrote:
> On Thu, Oct 31, 2013 at 4:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Thu, Oct 31, 2013 at 7:00 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>
>>>> Interesting. With the monitor I have tested I am not able to see this
>>>> magenta line.
>>>
>>> Monitor or TV?  Beware of overscans which will hide this effect.
>>
>> I used a PC monitor on my tests.
>>
>> I sent v5 using 4 as the number of loops according to Troy's results.
>
> Stop, stop, stop!
>
> Has nobody noticed this register isn't described in the reference manual?
>
> What does it even do? How can we quantify Troy's results by just
> throwing numbers at it and then saying "no magenta line here"?

Okay a little worry here is that the last time I kicked an HDMI
transmitter around a huge magenta line was basically a side effect of
doing the following things that weren't necessary to spec; either
enabling audio infoframes when in DVI mode (the transmitter doesn't
care if you're in DVI mode, it will shove audio out there anyway) or
some really weird timing effects, almost a race condition, if you're
generating infoframes at the wrong points (such as SPD or suchlike) -
sometimes the monitor will figure it out. Sometimes not.

The easiest case is enable "HDMI transmitter mode" on a monitor that
does not actually have an HDMI-spec-capable decoder on it. If you have
an HDMI to DVI cable, you have this. If you have an older or cheaper
monitor with no speakers, this can also be entirely possible. You
almost never see this on TVs, but you DO see it on maybe the "3rd"
HDMI port on some TVs (where audio mysteriously doesn't work, but it
works fine on the other two ports). I wrote a little treatise on this
about those Radeon HDMI->DVI dongles to the DRM list, it's the same
deal.

Essentially there's not a lot of point enabling HDMI mode if your
monitor doesn't support audio, and if you do enable it, you HAVE to
make sure your AVI InfoFrames are being sent (but, obviously, don't
send AVI InfoFrames in DVI mode or all you'll see is a magenta line if
it extends the blanking timings, and the monitor doesn't handle it).

I notice the register enums have DVI mode in there, also I saw a weird
case where the CEA modes in the kernel that got introduced with DRM
had a couple backwards polarities, and one or two of them on some
monitors that specified them would give the magenta line (and on
others that had the same VIC in their CEA list) would work fine.. I
guess they had more resilient logic to detect things like the wrong
HSYNC polarity.

What modes are being set here (are they derived from VIC codes or
actual detail timings?) that cause the magenta line? The actual fix
may be to go through the HDMI spec and fix the CEA mode definitions
that correspond to each VIC and be sure they're accurate.

Hammering the register 4 times probably just resolves it by
approaching what seems like a more correct waveform by constantly
re-starting the transmission path. That might explain why some values
work for some and some don't for others.

I'm concerned that the real problem isn't addressed (and I did see a
patch that fiddled a polarity value earlier..) and the actual effects
of these bits is not actually documented in the manuals.

Fabio, Shawn, could you go so far as to bring this up with the i.MX
guys responsible for documentation or find the original transmitter IP
specs, or find the two pages missing from the manual? This is a really
important register if the definition in the source code is to be
believed (do we believe it?) if working HDMI output is to be achieved.

Thanks,
Matt Sealey <neko@bakuhatsu.net>
