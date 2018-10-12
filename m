From: james.morse@arm.com (James Morse)
Date: Fri, 12 Oct 2018 18:17:48 +0100
Subject: [PATCH v6 05/18] ACPI / APEI: Make estatus queue a Kconfig symbol
In-Reply-To: <20181004173416.GC5149@zn.tnic>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-6-james.morse@arm.com> <20181001175956.GF7269@zn.tnic>
 <a562d7c4-2e74-3a18-7fb0-ba8f40d2dce4@arm.com>
 <20181004173416.GC5149@zn.tnic>
Message-ID: <52228145-f024-0ee1-01c7-da92023d53cc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 04/10/2018 18:34, Borislav Petkov wrote:
> On Wed, Oct 03, 2018 at 06:50:36PM +0100, James Morse wrote:
>> I'm all in favour of letting the compiler work it out, but the existing ghes
>> code has #ifdef/#else all over the place. This is 'keeping the style'.
> 
> Yeah, but this "style" is not the optimal one and we should
> simplify/clean up and fix this thing.
> 
> Swapping the order of your statements here:
> 
>> The ACPI spec has four ~NMI notifications, so far the support for
>> these in Linux has been selectable separately.
> 
> Yes, but: distro kernels end up enabling all those options anyway and
> distro kernels are 90-ish% of the setups. Which means, this will get
> enabled anyway and this additional Kconfig symbol is simply going to be
> one automatic reply "Yes".
> 
> So let's build it in by default and if someone complains about it, we
> can always carve it out. But right now I don't see the need for the
> unnecessary separation...

Ripping out the existing #ifdefs and replacing them with IS_ENABLED() would let
the compiler work out the estatus stuff is unused, and saves us describing the
what-uses-it logic in Kconfig.

But this does expose the x86 nmi stuff on arm64, which doesn't build today.
Dragging NMI_HANDLED and friends up to the 'linux' header causes a fair amount
of noise under arch/x86 (include the new header in 22 files). Adding dummy
declarations to arm64 fixes this, and doesn't affect the other architectures
that have an asm/nmi.h

Alternatively we could leave {un,}register_nmi_handler() under
CONFIG_HAVE_ACPI_APEI_NMI. I think we need to keep the NOTIFY_NMI kconfig symbol
around, as its one of the two I can't work out how to fix without the TLBI-IPI.


Thanks,

James
