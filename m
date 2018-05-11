From: steve.capper@arm.com (Steve Capper)
Date: Fri, 11 May 2018 11:11:05 +0100
Subject: [PATCH v3 6/8] arm64: module-plts: Extend veneer to address
 52-bit VAs
In-Reply-To: <CAKv+Gu_unCnhqE_Ort0zOjBj_ZmWja5unGON6KBuRxJzdhc5jA@mail.gmail.com>
References: <20180510162347.3858-1-steve.capper@arm.com>
 <20180510162347.3858-7-steve.capper@arm.com>
 <CAKv+Gu_unCnhqE_Ort0zOjBj_ZmWja5unGON6KBuRxJzdhc5jA@mail.gmail.com>
Message-ID: <20180511101104.6cv5mvqc6juh2mgt@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 12:01:05AM +0200, Ard Biesheuvel wrote:
> On 10 May 2018 at 18:23, Steve Capper <steve.capper@arm.com> wrote:
> > From: Ard Bieusheuval <ard.biesheuvel@linaro.org>
> >
> > In preparation for 52-bit VA support in the Linux kernel, we extend the
> > plts veneer to support 52-bit addresses via an extra movk instruction.
> >
> > [Steve: code from Ard off-list, changed the #ifdef logic to inequality]
> > Signed-off-by: Steve Capper <steve.capper@arm.com>
> >
> > ---
> >
> > New in V3 of the series.
> >
> > I'm not sure if this is strictly necessary as the VAs of the module
> > space will fit within 48-bits of addressing even when a 52-bit VA space
> > is enabled.
> 
> What about the kernel text itself? Is that also guaranteed to have
> bits [51:48] of its VAs equal 0xf, even under randomization?
> 
> If so, I agree we don't need the patch.
> 

Hi Ard,
The kernel modules and text are guaranteed to have addresses greater
than or equal to KASAN_SHADOW_END (same for both 48, 52-bit VAs) or
_VA_START(VA_BITS_MIN) (same for both 48, 52-bit VAs). Also, IIUC, the
KASLR displacemnt is always non-negative?

So I think we're safe in that modules and kernel text will be 48-bit
addressable in 52-bit configurations.

I'll have a think about a BUILD_BUG to capture any change to the above.

Cheers,
-- 
Steve
