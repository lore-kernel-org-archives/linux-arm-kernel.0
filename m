From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 14:31:41 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410104002.GF14496@n2100.arm.linux.org.uk>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
Message-ID: <20130418133141.GS14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 11:40:02AM +0100, Russell King - ARM Linux wrote:
> I have just committed a patch to remove the arch/arm/nwfpe code from
> the kernel, and the VFP code emulating the FP operations.

It's time for a status update on this.

There appears to be some confusion over the license under which *our*
version of the softfloat code is licensed under.

The first point to ensure that everyone understands is that the license
which applies to any code is the applicable license at the point the code
was obtained, not *any* subsequent license updates.  If the license is
changed on a code base, it creates a license "fork" - new copies of the
code base are licensed under the new license terms, but older copies
obtained before the fork point remain under the old license terms.

Our version of softfloat was integrated into the kernel a long time ago,
maybe back in December 2000 - it was certainly in mainline in kernel
version 2.2.19.  This work was done as part of Corel's Netwinder team,
hence the name "nw-fpe" or "netwinder fpe".

This version was derived from the version which could be found at:
	http://HTTP.CS.Berkeley.EDU/~jhauser/arithmetic/softfloat.html
which was licensed as per the documentation within the files you find
in your kernel source today.  Indeed, the license header in these
softfloat files remained untouched until commit 50a23e6eec6f20d55 -
more on that below.

Sometime later, softfloat moved to a different URL:
	http://www.jhauser.us/arithmetic/SoftFloat-2b/SoftFloat-source.txt
and the original URL became invalid.  It is not clear when this happened,
but dates on the new site suggest 2010.  Also, the softfloat license was
changed (maybe around the same time), with the addition of an
indemnification clause.  This indemnification clause *may* make the new
license incompatible with the GPLv2.  However, this clause only applies
to a new copy of the code, and can not be applied retrospectively to
older versions - even though the text of the code may in fact be
identical.

However, certain folk who like to ensure that all URLs in the kernel point
at valid sites decided to fix any broken URLs - including the softfloat
URLs.  So, commit 50a23e6eec6f20d55 (Update broken web addresses in arch
directory.) changed the URLs in our softfloat files to point at the new
URL.  This, on the face of it, is not a problem.  However, the version it
now points at has a different license.

As our version pre-dates the version at the new URL and the license change,
the license under which *our* version remains is the original license which
does *not* have the indemnification cause, and thus our copy of the code
remains GPLv2 compatible.

Therefore, there is no need to remove this softfloat code from the kernel;
there is no license conflict.
