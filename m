From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 5 Nov 2013 17:29:24 -0600
Subject: [PATCH v4] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAOMZO5DU9y2tvgkEbastQdhJvtLGLJ-b49WY8RsvpbmJhzMxLA@mail.gmail.com>
References: <1383181127-12013-1-git-send-email-festevam@gmail.com>
 <5272BC59.1080109@boundarydevices.com>
 <5272BFE0.5040409@boundarydevices.com>
 <CAOMZO5C39JNVv0vz-38eOrKHXMqWHCeCknhSvfGFe5t0EGkDsg@mail.gmail.com>
 <20131031210053.GH16735@n2100.arm.linux.org.uk>
 <CAOMZO5DAAXg4wP2UuYCN6BgN5-q3sv0Lrqvk8xMDmEW_TXepXg@mail.gmail.com>
 <CAHCPf3v0G_551Oeq-dL61J0Ce-iUMv+ou8+q671S8=GEcNjv5w@mail.gmail.com>
 <CAHCPf3tSdn=TJ86QEtL3r9iSP0j88WP-y2=z96ZUfW-7VecMbQ@mail.gmail.com>
 <CAOMZO5DU9y2tvgkEbastQdhJvtLGLJ-b49WY8RsvpbmJhzMxLA@mail.gmail.com>
Message-ID: <CAHCPf3s-dxzqAGHhOaemJeCW0LmxOhYThrtif+QpGb4LzeWDpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 4, 2013 at 7:13 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Nov 4, 2013 at 9:20 PM, Matt Sealey <neko@bakuhatsu.net> wrote:
>
>> Fabio, Shawn, could you go so far as to bring this up with the i.MX
>> guys responsible for documentation or find the original transmitter IP
>> specs, or find the two pages missing from the manual? This is a really
>
> The multiple writes comes from the following erratum:
> ERR005173 HDMI: Clarification on HDMI programming procedure to avoid
> FIFO overflow

I know about that one. BTW this isn't in the MX6SDL errata
documentation, but it is in the MX6QD errata. If this actually affects
the Solo etc. as Russell dictates, isn't the errata document missing
some info here?

Also the patch doesn't ACTUALLY do what the erratum states you should
do - nobody is checking audio FIFO status here before retrying.

What I am more curious about is the net effect of every bit in this 8
bit undocumented register which seems to have a major errata around
it.

I noticed a couple which have very abstract definitions which could
mean a couple things regarding packetizing information. What does
R_V_BLANK_IN_OSC mean? It's being set when the VIC selected is 39,
which makes sense in that there is a magic interlace timing for this
VIC if it also exists in the EDID DTDs. However, no check for this is
made, it just sets it outright. In fact, it doesn't even make sense
since in theory it would not be being told to set the VIC timing, it
would be passed the DTD timing, which need to match a very specific
set of values, and if they match you need to, instead, fix up the
timing used based on the fact that VIC 39 was also listed in the CEA
extension block...

If you don't follow the CEA-861-E specs or HDMI 1.3a specs *at least*
when configuring a mode, and packetizing your infoframes, and the
content of those infoframes, then you're going to end up with magenta
lines regardless of esoteric audio FIFO underflows.

What I don't understand here is how a FIFO underflow in the audio
packetizer is causing this magenta line. What you should get is a pop
or crackle in the audio (or silence..) or just zero effect on the
display if the packetizer can't put valid data in there. There aren't
any reasons why a FIFO underflow would somehow change mode timings to
cause a magenta line.

That said, I got the same thing accidentally enabling audio on a DVI
monitor, although this was an SPDIF connection to an external
transmitter (not an internal IP block) - even if you didn't enable
audio and it was in DVI mode, it caused enough "drag" on the logic to
sample audio and be getting nothing over the audio link to put a huge
pink line down the side of at least 2 monitors. There doesn't seem to
be any audio setup going on in the driver, so I would suggest trying
to just force DVI mode and see if the line goes away or gets worse
with those different values for retrying, and then forcing HDMI mode..
same test.


Matt Sealey <neko@bakuhatsu.net>
