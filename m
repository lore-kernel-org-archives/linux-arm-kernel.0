From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 25 Feb 2010 12:36:25 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267045954.23523.1692.camel@pasglop>
References: <1266445892.16346.306.camel@pasglop>
	<201002192153.22159.oliver@neukum.org>
	<1266979689.23523.1669.camel@pasglop>
	<201002240816.10178.oliver@neukum.org>
	<1267045954.23523.1692.camel@pasglop>
Message-ID: <1267101385.2902.8.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-02-25 at 08:12 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2010-02-24 at 08:16 +0100, Oliver Neukum wrote:
> > I don't know. The issue seems quite complex. It would seem better to
> > centralize it as far as practical. Do you have a wrapper drivers could
> > call?
> 
> flush_dcache_page() ? :-)

Actually, that can be wrong depending on the implementation.  The
problem is incoherency of the kernel page (dirty) with respect to user
space aliases (clean).  What has to happen on parisc is that the kernel
alias needs flushing.  We can guarantee the userspace aliases to be
clean (and not moved in).  We wouldn't want to incur the expense of
flushing the user space pages as well.

> Now, the subsystem might be the one to know whether something is mapped
> into userspace or not (v4l in our case) in which case a wrapper could be
> created.

Right, so it's the responsibility of the API used by the subsystem.
Thus Caitlin's pio_kmap seems the right one ... I don't understand what
the additional problems are.

James
