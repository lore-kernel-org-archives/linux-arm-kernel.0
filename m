From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Nov 2018 10:06:15 +0000
Subject: [PATCH] arm64: mm: define NET_IP_ALIGN to 0
In-Reply-To: <CAKv+Gu-_gcpRaMK3CLh14-wyjYbYNbHZ6bBMPGHWx-fGyFmujw@mail.gmail.com>
References: <20181107171038.25281-1-ard.biesheuvel@linaro.org>
 <20181107181047.fx4zbpdunfpwivjc@lakrids.cambridge.arm.com>
 <CAKv+Gu-_gcpRaMK3CLh14-wyjYbYNbHZ6bBMPGHWx-fGyFmujw@mail.gmail.com>
Message-ID: <20181108100614.2otaqmz3hoe7wsax@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2018 at 12:18:33AM +0100, Ard Biesheuvel wrote:
> (+ Arnd)
> 
> On 7 November 2018 at 19:10, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Nov 07, 2018 at 06:10:38PM +0100, Ard Biesheuvel wrote:
> >> On arm64, there is no need to add 2 bytes of padding to the start of
> >> each network buffer just to make the IP header appear 32-bit aligned.
> >>
> >> Since this might actually adversely affect DMA performance some
> >> platforms, let's override NET_IP_ALIGN to 0 to get rid of this
> >> padding.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/processor.h | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> >> index 3e2091708b8e..6b0d4dff5012 100644
> >> --- a/arch/arm64/include/asm/processor.h
> >> +++ b/arch/arm64/include/asm/processor.h
> >> @@ -24,6 +24,14 @@
> >>  #define KERNEL_DS    UL(-1)
> >>  #define USER_DS              (TASK_SIZE_64 - 1)
> >>
> >> +/*
> >> + * On arm64 systems, unaligned accesses by the CPU are cheap, and so there is
> >> + * no point in shifting all network buffers by 2 bytes just to make some IP
> >> + * header fields appear aligned in memory, potentially sacrificing some DMA
> >> + * performance on some platforms.
> >> + */
> >> +#define NET_IP_ALIGN 0
> >
> > Might it be better for core code to do this based on
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS?
> 
> In general, yes. But that will cause performance issues on ARMv6+,
> since we will end up using ldrd instructions that require alignment
> fixups.

Ok.

> In my opinion, CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS should signify
> that unaligned accessors are cheap, not that they are not required at
> all.

I'm not sure I follow the distinction you're trying to make.

I do see that *certain* unaligned accesses may be cheap while others are not,
so maybe that's worth addressing (e.g. HAVE_EFFICIENT_UNALIGNED_32BIT_ACCESS),
but that is a more general thing.

FWIW, for this as-is:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
