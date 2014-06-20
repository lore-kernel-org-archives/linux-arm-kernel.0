From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Jun 2014 11:17:17 +0100
Subject: [PATCH 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <1403201268.17030.59.camel@smoke>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
 <1402950432.3708.22.camel@smoke>
 <20140618164927.GA9612@leverpostej>
 <1403116902.17030.15.camel@smoke>
 <20140619102526.GA22217@leverpostej>
 <1403201268.17030.59.camel@smoke>
Message-ID: <20140620101717.GE30188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 07:07:48PM +0100, Geoff Levand wrote:
> Hi Mark,
> 
> On Thu, 2014-06-19 at 11:25 +0100, Mark Rutland wrote:
> > I disagree that the bootloader _must_ have to deal with the endianness
> > of the kernel. If the user knows the endianness of the kernel and
> > provides a filesystem of the appropriate endianness, I don't see why the
> > bootloader should have to do anything differently. In most cases the
> > bootloader has no need to care.
> 
> As I mentioned, I don't really care how this is fixed, but there will be
> bootloaders built as both big and little endian (kexec based ones for
> example), and so no matter what, bootloaders will need to deal with
> converting values.

Sure, bootloaders will need to convert values in some cases.

By having a fixed endian header format, whether or not you need to
byteswap values becomes a fixed property of the bootloader (i.e. whether
it is BE or not) rather than a dynamic property of the kernel Image. So
you only require a single path through your loader for BE and LE
kernels.

If you have constructs like LE64_TO_CPU available to your loader, then
it becomes trivial to write an endian-clean loader. The only pain is
having to test if image_size is non-zero first, but that test is
independent of endiannness.

Mark.
