From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Aug 2018 10:10:27 +0100
Subject: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <f2723578-f39d-27ac-b376-0f06905caa67@gmail.com>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu>
 <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <f2723578-f39d-27ac-b376-0f06905caa67@gmail.com>
Message-ID: <20180801091027.GC14438@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 04:29:56PM -0400, Alex Bounine wrote:
> On 2018-07-31 08:54 AM, Alex Bounine wrote:
> >On 2018-07-31 04:41 AM, Will Deacon wrote:
> >>On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
> >>>Platforms with a PCI bus will be offered the RapidIO menu since they may
> >>>be want support for a RapidIO PCI device. Platforms without a PCI bus
> >>>that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> >>>in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> >>>
> >>>Tested that kernel builds for arm64 with RapidIO subsystem and
> >>>switch drivers enabled, also that the modules load successfully
> >>>on a custom Aarch64 Qemu model.
> >>>
> >>>Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>Cc: Russell King <linux@armlinux.org.uk>
> >>>Cc: John Paul Walters <jwalters@isi.edu>
> >>>Cc: linux-arm-kernel at lists.infradead.org
> >>>Cc: linux-kernel at vger.kernel.org,
> >>>Signed-off-by: Alexei Colin <acolin@isi.edu>
> >>>---
> >>>? arch/arm64/Kconfig | 2 ++
> >>>? 1 file changed, 2 insertions(+)
> >>
> >>Thanks, this looks much cleaner than before:
> >>
> >>Acked-by: Will Deacon <will.deacon@arm.com>
> >>
> >>The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
> >>unconditionally in the arm64 Kconfig. Does selecting only that option
> >>actually pull in new code to the build?
> >>
> >HAS_RAPIDIO option is intended for SOCs that have built in SRIO
> >controllers, like TI KeyStoneII or FPGAs. Because RapidIO subsystem core
> >is required during RapidIO port driver initialization, having separate
> >option allows us to control available build options for RapidIO core and
> >port driver (bool vs. tristate) and disable module option if port driver
> >is configured as built-in.
> 
> I am thinking about where HAS_RAPIDIO option can be set for arm64 branch.
> Having it set globally is too broad. For example we have Xilinx Zinq US
> board with SRIO IP on it. Having it globally in arm64 branch - bad. Probably
> having it set in drivers/soc/... is the best place.

Why is selecting HAS_RAPIDIO globally a bad thing to do? The way these
normally work is, if some subsystem requires arch support, then there's
an ARCH_HAS_xxxx option which the architecture selects when it implements
that support. Once you've enabled that, then that allows other sub-options
to be selected, such as specific drivers or what-not. Look at the Kconfig
files under drivers/soc/ -- you don't see anybody selecting ARCH_HAS_*
options.

Now, if HAS_RAPIDIO alone is pulling in a whole load of code to the build,
then it sounds like a misnomer.

Confused.

Will
