From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Apr 2014 17:56:14 +0800
Subject: [PATCH 00/15] ARM: sunxi: add A31 PL pins support
In-Reply-To: <20140410081031.GM28585@lukather>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <CAGb2v66XCN2ar1wj+a1+ZwdcdJ3gzJ+nDiO9bu52OwK+mBB_Hg@mail.gmail.com>
 <20140409151747.GH28585@lukather>
 <CAGb2v67+YNhw2MXSu9DTKSUfXH=v+uD7KEaxyiPezyf9CYtmPw@mail.gmail.com>
 <20140410081031.GM28585@lukather>
Message-ID: <CAGb2v65xhEHS_qETZUWcjeaVQK1V84J4h1LzA7uTrtWS=7P8+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 4:10 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Apr 10, 2014 at 12:27:32AM +0800, Chen-Yu Tsai wrote:
>> >> > Let me know if these changes are too intrusive.
>> >>
>> >> I wonder if we should do a separate driver for the new PIO controller.
>> >> Clearly it's a separate IP block, with it's own clock and reset controls.
>> >
>> > It's been merged together in the A23, hence why we did it like that.
>>
>> I'm not sure I understand. The clock gate and reset control are still separate,
>> are they not?
>
> On the A31 the "regular" port controler handles PA to PH banks, while
> the R_PIO handles the PL and PM banks.
>
> On the A23, the regular port controler handles PA to PL banks, and the
> R_PIO and PM bank doesn't exist.

On closer inspection of the user manual and the SDK code,
there is no reset control for R_PIO in the A23, but there is
still a APB0 gate. Also the register space is still at 0x01f02c00,
the address space for R_PIO.

I know the user manual lists the PL pins under the PIO controller,
however the section doesn't list registers for them. It would seem
they are still separate blocks. Also the kernel code never bothers
to enable the R_PIO clock, possibly because it was enabled by U-boot.

> So we're not quite in the same situation. The A31 is troublesome,
> while the A23 (except for the external interrupts), is pretty much
> what we've seen so far with the A10/A20/...
