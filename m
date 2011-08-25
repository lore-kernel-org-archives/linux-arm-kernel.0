From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Aug 2011 14:16:37 +0100
Subject: [PATCH v4 0/8] MMU disabling code and kexec fixes
In-Reply-To: <20110824174537.GW32688@e102144-lin.cambridge.arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1108232120590.20358@xanadu.home>
	<20110824105848.GE32688@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108241035400.20358@xanadu.home>
	<20110824165938.GT32688@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108241323540.20358@xanadu.home>
	<20110824174537.GW32688@e102144-lin.cambridge.arm.com>
Message-ID: <20110825131637.GE27143@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Aug 24, 2011 at 06:45:37PM +0100, Will Deacon wrote:
> On Wed, Aug 24, 2011 at 06:30:07PM +0100, Nicolas Pitre wrote:
> > Hmmm... The kexec user space tools know how to manipulate a device tree 
> > for the next kernel, right?  So it's only a matter for it to ask the 
> > current kernel what the physical address for that page is and stuff it 
> > into the FDT it is preparing already.
> 
> oo-er, it seems a bit odd telling userspace about that address but it does
> fix the problem. I can't think of a better idea, so I'll start looking for a
> sane interface for passing this address back.

I had a look at the kexec-tools source for PPC (unfortunately all the fdt
stuff is under there, so adding this for ARM is going to be a pain) and
here's what they do:

  If a .dtb file is passed to kexec, that is passed to the new kernel. It is
  fixed up by the kexec tool so that things like the command-line can be
  modified. There is a device tree property called "cpu-release-addr" which
  specifies the pen address for each CPU and this property is actually read
  from the device tree and added to the list of reserved regions so that the
  next kernel doesn't clobber it.

  If a .dtb file is not passed, kexec looks at /proc/device-tree/ and
  constructs a new blob from that.

Note that PPC doesn't make an attempt to allocate the pen dynamically. If we
want to do that, I guess we could emit a dummy "cpu-release-addr" property
via /proc/, but this has a couple of downsides:

  1.) People might try and use this property (and it would allow bootloaders
      to specify pens to non-kexec'd kernels, which would likely end in
      disaster)

  2.) We would have to allocate the pen during boot and leave it allocated
      for any CONFIG_KEXEC kernels.

Thinking about the concerns you had about bootloaders using the pen if it's
at a known physical location, I realised that we don't actually need to
populate the pen until a kexec is in progress. Although the pen page will
always be reserved, we can just copy the pen code into it on the
kexec_prepare path and that way prevent it being abused by anybody else.

So, do you still reckon we should push forward with the dynamic allocation
and ATAG/FDT interface or lazily populate at a known address instead?

Thanks,

Will
