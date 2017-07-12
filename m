From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 12 Jul 2017 16:28:33 -0700
Subject: [PATCH 1/2] remoteproc: Add remote processor coredump support
In-Reply-To: <0c2fe4e0-2aee-fcf4-0a49-5651241e1f9e@ti.com>
References: <1497463616-19868-1-git-send-email-spjoshi@codeaurora.org>
 <0c2fe4e0-2aee-fcf4-0a49-5651241e1f9e@ti.com>
Message-ID: <20170712232833.GI20973@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 15 Jun 11:48 PDT 2017, Suman Anna wrote:
[..]
> > +static int rproc_coredump_add_header(struct rproc *rproc)
> > +{
> > +	struct rproc_dump_segment *entry;
> > +	struct elf32_phdr *phdr;
> > +	struct elf32_hdr *ehdr;
> > +	int nsegments = 0;
> > +	size_t offset;
> > +
> > +	list_for_each_entry(entry, &rproc->dump_segments, node)
> > +		nsegments++;
> > +
> > +	rproc->dump_header_size = sizeof(*ehdr) + sizeof(*phdr) * nsegments;
> > +	ehdr = kzalloc(rproc->dump_header_size, GFP_KERNEL);
> > +	rproc->dump_header = (char *)ehdr;
> > +	if (!rproc->dump_header)
> > +		return -ENOMEM;
> > +
> > +	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> > +	ehdr->e_ident[EI_CLASS] = ELFCLASS32;
> > +	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> > +	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> > +	ehdr->e_ident[EI_OSABI] = ELFOSABI_NONE;
> > +	ehdr->e_type = ET_CORE;
> > +	ehdr->e_version = EV_CURRENT;
> > +	ehdr->e_phoff = sizeof(*ehdr);
> > +	ehdr->e_ehsize = sizeof(*ehdr);
> > +	ehdr->e_phentsize = sizeof(*phdr);
> > +	ehdr->e_phnum = nsegments;
> > +
[..]
> 
> This is not generic, remoteproc core can support non-ELF images, and the
> choice of fw_ops is left to individual platform drivers. The dump logic is
> dependent on the particular format being used, and so whatever ELF coredump
> support you are adding should be added through a fw_ops. You can add a
> default one for regular ELFs, and platform drivers can always customized
> based on thier own fw_ops.
> 

I do not see the need for the coredump file format to match the firmware
file format.

There are a few cases where the remoteproc driver slaps a single raw
blob into a single memory location and adding a single-segment ELF
header to this might be considered overkill, but in the generic case we
have some number of chunks loaded into some number of memory regions and
ELF is a reasonable representation of this list.

The purpose of the output is to be loaded in a debugger and I think ELF
is a sane generic option for this.


Perhaps we're missing some data/information by selecting ELF as
container format?

Regards,
Bjorn
