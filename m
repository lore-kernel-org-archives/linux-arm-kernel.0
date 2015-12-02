From: geoff@infradead.org (Geoff Levand)
Date: Wed, 02 Dec 2015 11:03:48 -0800
Subject: arm64 boot requirements
In-Reply-To: <20151201110159.GA4757@leverpostej>
References: <565BAA2E.5090102@cog.systems> <20151201110159.GA4757@leverpostej>
Message-ID: <1449083028.6139.25.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2015-12-01 at 11:02 +0000, Mark Rutland wrote:
> Pratyush, Geoff, I understood you were loading the kernel vmlinux for
> kexec. Do you parse the Image header to figure out where to place
> things?

Yes, in the kexec user tools we use text_offset to make
enough room for the kernel, but there is also the need for
page_offset.

We need to know the page_offset to be able to do virtual to
physical address conversions.  We can calculate the page_offset
for a vmlinux image as page_offset = phdr->p_vaddr - text_offset.

The binary Image currently has no info about page_offset or
virtual addressing.  We have a kexec-tools option for the
user to specify a page_offset.  If that option is not provided
we try to look at the running kernel's symbols, and if that
fails, fall back to a default page_offset.  This is less than
ideal, and certainly makes the binary Image less appealing to
use with kexec.

-Geoff
