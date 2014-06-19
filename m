From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Jun 2014 11:25:26 +0100
Subject: [PATCH 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <1403116902.17030.15.camel@smoke>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
 <1402950432.3708.22.camel@smoke>
 <20140618164927.GA9612@leverpostej>
 <1403116902.17030.15.camel@smoke>
Message-ID: <20140619102526.GA22217@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 07:41:42PM +0100, Geoff Levand wrote:
> Hi Mark,

Hi Geoff,

Thanks for raising the issue. I can see from Kevin's comments that the
kernel endianness is a useful piece of information, so I'll add a field
to the header to export that for v3.

> On Wed, 2014-06-18 at 17:49 +0100, Mark Rutland wrote:
> > On Mon, Jun 16, 2014 at 09:27:12PM +0100, Geoff Levand wrote:
> > While I initially considered having a field to specify byte order, it's
> > incredibly likely that bootloaders will not use it. Maintaining a fixed
> > endianness everywhere makes it simpler for bootloaders to do the right
> > thing, and matches what existing bootloaders are already doing. That's
> > less pain for loaders and less pain for the kernel, as things are less
> > likely to go wrong.
> > 
> > To me it makes more sense to ensure these fields have a consistent
> > endianness, rather than adding more room for possible mistakes.
> 
> I guess my view is that any software expected to support arm64 in both
> big and little endian configurations should be tested with such, and
> with this it is pretty simple to test and fix, so we shouldn't over
> engineer it, but I don't really care how we fix it.

I disagree that the bootloader _must_ have to deal with the endianness
of the kernel. If the user knows the endianness of the kernel and
provides a filesystem of the appropriate endianness, I don't see why the
bootloader should have to do anything differently. In most cases the
bootloader has no need to care.

IMO It's far better to export the fields in the kernel header in a
consistent endianness than it is to force every boot loader to inspect
the endianness of the kernel image.  I can imagine there are going to be
plenty of bootloaders which will not attempt to determine the endianness
and will blindly assume a particular case. Exporting the kernel
endianness does seem to make sense, but I think this should be in
addition to the information bootloaders require rather than being part
of the information bootloaders require.

Thanks,
Mark.
