From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 5 Aug 2015 09:52:25 -0700
Subject: [PATCH v2 4/8] xen: Use the correctly the Xen memory terminologies
In-Reply-To: <alpine.DEB.2.02.1508051108100.11337@kaball.uk.xensource.com>
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1508051108100.11337@kaball.uk.xensource.com>
Message-ID: <20150805165225.GC3603@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 11:08:55AM +0100, Stefano Stabellini wrote:
> On Tue, 4 Aug 2015, Julien Grall wrote:
> > Based on include/xen/mm.h [1], Linux is mistakenly using MFN when GFN
> > is meant, I suspect this is because the first support for Xen was for
> > PV. This resulted in some misimplementation of helpers on ARM and
> > confused developers about the expected behavior.
> > 
> > For instance, with pfn_to_mfn, we expect to get an MFN based on the name.
> > Although, if we look at the implementation on x86, it's returning a GFN.
> > 
> > For clarity and avoid new confusion, replace any reference to mfn with
> > gfn in any helpers used by PV drivers. The x86 code will still keep some
> > reference of pfn_to_mfn but exclusively for PV (a BUG_ON has been added
> > to ensure this). No changes as been made in the hypercall field, even
> > though they may be invalid, in order to keep the same as the defintion
> > in xen repo.
> > 
> > Take also the opportunity to simplify simple construction such
> > as pfn_to_mfn(page_to_pfn(page)) into page_to_gfn. More complex clean up
> > will come in follow-up patches.
> > 
> > [1] http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=e758ed14f390342513405dd766e874934573e6cb
> > 
> > Signed-off-by: Julien Grall <julien.grall@citrix.com>
> > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: David Vrabel <david.vrabel@citrix.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: x86 at kernel.org
> > Cc: "Roger Pau Monn?" <roger.pau@citrix.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Wei Liu <wei.liu2@citrix.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: "James E.J. Bottomley" <JBottomley@odin.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: linux-input at vger.kernel.org
> > Cc: netdev at vger.kernel.org
> > Cc: linux-scsi at vger.kernel.org
> > Cc: linuxppc-dev at lists.ozlabs.org
> > Cc: linux-fbdev at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> 
> Aside from the x86 bits:
> 
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Not really important, but just in case anyone waits for my ack on input
bits:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
