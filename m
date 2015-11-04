From: jon.nettleton@gmail.com (Jon Nettleton)
Date: Wed, 4 Nov 2015 18:04:55 +0100
Subject: i.MX6: Increasing VPU frequency
In-Reply-To: <CAH-u=82M1yCmPjBg5qeiC8JiHjM8+WsP+utX_VPKfJwJsu0QFg@mail.gmail.com>
References: <CAH-u=82M1yCmPjBg5qeiC8JiHjM8+WsP+utX_VPKfJwJsu0QFg@mail.gmail.com>
Message-ID: <CALHpu366MPbxJinVL2QFM11gMHx-T=M9QXNoznOTh++oHGGmrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2015 at 5:52 PM, Jean-Michel Hautbois
<jean-michel.hautbois@veo-labs.com> wrote:
> Hi !
>
> I can see in FSL kernel that VPU is configurable to 352M (it defaults
> at 264MHz in mainline I think).
> In the TRM, it is even specified at 352MHz as a default frequency,
> with a maximum of 540MHz.
>
> Would it be possible to allow this clock rating modification if, for
> instance, we select a performance governor in cpufreq, or if a coda
> encoder is started with 1080p for instance ?
> If so, then how is it doable properly ?

For some reason the FSL kernel configures the VPU to run at 352Mhz in
a very odd way that requires limiting the min cpu-frequency to 792Mhz.
It also requires clocking down a bunch of devices on pll2_pfd2_396m to
352Mhz.

The simple solution to this is to instead parent the VPU to
pll2_pfd0_352m which is unused.  I have found by default it is stable
decoding but unstable encoding at 352Mhz, most likely due to the
voltage changes needed that limiting the min cpu-freq to 792Mhz
provides.  However everything seems to work quite reliably clocking
that pfd to 327Mhz, which still gives a boost of almost 24%

In my testing the performance gain in then going from 327 to 352 is
minimal.  Generally I think you hit AXI bus limitations rather than
VPU performance.

-Jon
