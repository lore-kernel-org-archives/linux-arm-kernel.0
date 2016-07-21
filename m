From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Jul 2016 11:31:21 +0100
Subject: [PATCH v1 3/4] arm64: Add arm64 kexec support
In-Reply-To: <1469042361.2977.90.camel@infradead.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej>
 <1469042361.2977.90.camel@infradead.org>
Message-ID: <20160721103120.GB20559@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 12:19:21PM -0700, Geoff Levand wrote:
> > > +static uint64_t read_sink(const char *command_line)
> > > +{
> > > +> > 	> > uint64_t v;
> > > +> > 	> > const char *p;
> > > +
> > > +> > 	> > if (arm64_opts.port)
> > > +> > 	> > 	> > return arm64_opts.port;
> > > +
> > > +#if defined(ARM64_DEBUG_PORT)
> > > +> > 	> > return (uint64_t)(ARM64_DEBUG_PORT);
> > > +#endif
> > > +> > 	> > if (!command_line)
> > > +> > 	> > 	> > return 0;
> > > +
> > > +> > 	> > if (!(p = strstr(command_line, "earlyprintk=")) &&
> > > +> > 	> > 	> > !(p = strstr(command_line, "earlycon=")))
> > > +> > 	> > 	> > return 0;
> > > +
> > > +> > 	> > while (*p != ',')
> > > +> > 	> > 	> > p++;
> > > +
> > > +> > 	> > p++;
> > > +
> > > +> > 	> > while (isspace(*p))
> > > +> > 	> > 	> > p++;
> > 
> > Why do we skip spaces? As far as I am aware, there should not be any
> > spaces in the option.
> 
> Sure, I can remove it.
> 
> > > +
> > > +> > 	> > if (*p == 0)
> > > +> > 	> > 	> > return 0;
> > > +
> > > +> > 	> > errno = 0;
> > > +
> > > +> > 	> > v = strtoull(p, NULL, 0);
> > > +
> > > +> > 	> > if (errno)
> > > +> > 	> > 	> > return 0;
> > > +
> > > +> > 	> > return v;
> > > +}
> > 
> > It looks like the purgatory code expects angel SWI as the earlycon,
> 
> Maybe you saw the debug_brk macro in entry.S?  I should remove
> that and just loop.

Ah, sorry. For some reason I got that confused with the sink code. My
bad.

Now I see that's assuming an 8-bit MMIO register.

> > whereas many other earlycons exist (with pl011 being extremely popular).
> > Regardless, if we assume a particular UART type, we should explicitly
> > verify that here. Otherwise the purgatory code will likely bring down
> > the system, and it will be very painful to debug.
> > 
> > Please explicitly check for the supported earlycon name.
> 
> Purgatory just writes bytes to the address given.  Are there
> UARTs that don't have TX as the first port?

I'm not sure, but it's certainly possible. The generic earlycon binding
doesn't guarantee that the first address is a TX register. Even if they
don't exist today, they could in a month's time, so I don't think we
should assume anything.

Additionally, the width of that TX register can differ (e.g.
uart8250,mmio vs uart8250,mmio32), and some UARTs aren't very forgiving
if accessed with the wrong width.

> To be safe, we could do a check when we get the address from
> an earlycon parameter. 

Yup. I think you need a whitelist of UARTs that can be handled, along
with parsing for their options (e.g. mmio vs mmio32), giving up if
unknown options are spotted.

> Here's what I found in the dts'.  The
> first three are OK, but I don't know about the others.  

I believe you can find the full set with:

$ git grep EARLYCON_DECLARE

[...]

> > > +> > 	> > if (result)
> > > +> > 	> > 	> > fprintf(stderr, "kexec: Warning: No device tree available.\n");
> > 
> > There are other reasons we'd return an error (e.g. mismatched enable
> > methods), so this is somewhat misleading.
> > 
> > I believe that in all cases we log the specific reason first anyway, so
> > perhaps it's best to jsut remove this warning.
> 
> Yes, this could be removed.
> 
> > Won't this also be very noisy in the case of ACPI with a stub DTB? In
> > that case ther are no cpu nodes, and may be no memory nodes.
> 
> Should we just remove check_cpu_nodes and everything associated with
> it?  It is a lot of code, and all it does now is issue warnings.
> It is still around from the early days of spin_table support.  

That sounds fine to me.

> As for memory nodes, we currently look at the dt, then fall back
> to iomem. We could switch the order, iomem then dt, but then
> those just issue dbgprintf's.

Sure.

> > > +int arm64_process_image_header(const struct arm64_image_header *h)
> > > +{
> > > +#if !defined(KERNEL_IMAGE_SIZE)
> > > +# define KERNEL_IMAGE_SIZE (768 * 1024)
> > > +#endif
> > > +
> > > +> > 	> > if (!arm64_header_check_magic(h))
> > > +> > 	> > 	> > return -EINVAL;
> > > +
> > > +> > 	> > if (h->image_size) {
> > > +> > 	> > 	> > arm64_mem.text_offset = le64_to_cpu(h->text_offset);
> > > +> > 	> > 	> > arm64_mem.image_size = le64_to_cpu(h->image_size);
> > > +> > 	> > } else {
> > > +> > 	> > 	> > /* For 3.16 and older kernels. */
> > > +> > 	> > 	> > arm64_mem.text_offset = 0x80000;
> > > +> > 	> > 	> > arm64_mem.image_size = KERNEL_IMAGE_SIZE;
> > > +> > 	> > }
> > > +
> > > +> > 	> > return 0;
> > > +}
> > 
> > A v3.16 defconfig Image with the Linaro 14.09 GCC 4.9 toolchain is
> > 6.3MB, so the chosen value for KERNEL_IMAGE_SIZE is far too small. I'm
> > not sure what to suggest as a better value, however, as I know that some
> > configurations are far bigger than that.
> 
> OK, I'll make it bigger, say 7.  When I set this up I expected
> the distro maintainer to choose KERNEL_IMAGE_SIZE to match their
> needs.

To give some headroom, bumping to 16 or so is probably a safer bet.

Perhaps it's worth logging a warning that we're guessing the effective
image size in this case? That could avoid a lot of head-scratching if
things do end up overlapping.

> > Do we expect to kexec to a v3.16 or earlier kernel, given we need a much
> > newer first kernel to have kexec in the first place? We could mandate
> > having a header with a non-zero image_size (i.e. the target kernel has
> > to be v3.16 or newer).
> 
> Kexec could be installed as a bootloader, and users may want the
> ability to boot older installations, so I think it worthwile to
> have.

Sure. I was under the impression that most distros had chosen v3.16 or
later, but I have no problem with trying to support earlier kernels.

Thanks,
Mark.
