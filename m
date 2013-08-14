From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 14 Aug 2013 17:41:49 +0100
Subject: [PATCH v3 07/10] xen: introduce XENMEM_get_dma_buf and
 xen_put_dma_buf
In-Reply-To: <20130809155050.GA8462@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1308051503190.4893@kaball.uk.xensource.com>
 <1375720256-8014-7-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130809153606.GD5637@phenom.dumpdata.com>
 <20130809155050.GA8462@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1308141740400.4470@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Aug 2013, Konrad Rzeszutek Wilk wrote:
> > > +struct xen_get_dma_buf {
> > > +    /*
> > > +     * [IN] Details of memory extents to be exchanged (GMFN bases).
> > > +     * Note that @in.address_bits is ignored and unused.
> > 
> > Ohhhh, why? What if the user wants to be it under 2G?
> 
> Looking a bit more at the code revealed that we stick that in the
> @out.address_bits
> > 
> > > +     */
> > > +    struct xen_memory_reservation in;
> > > +
> > > +    /*
> > > +     * [IN/OUT] Details of new memory extents.
> > > +     * We require that:
> > > +     *  1. @in.domid == @out.domid
> > > +     *  2. @in.nr_extents  << @in.extent_order == 
> > > +     *     @out.nr_extents << @out.extent_order
> > > +     *  3. @in.extent_start and @out.extent_start lists must not overlap
> > > +     *  4. @out.extent_start lists GPFN bases to be populated
> > > +     *  5. @out.extent_start is overwritten with allocated GMFN bases
> 
> .. which you should document, otherwise the hypervisor might try to give
> you pages under 2^0..

Yes, you are right. I'll add a note about out.address_bits.


> > > +     */
> > > +    struct xen_memory_reservation out;
> > > +
> > > +    /*
> > > +     * [OUT] Number of input extents that were successfully exchanged:
> > > +     *  1. The first @nr_exchanged input extents were successfully
> > > +     *     deallocated.
> > > +     *  2. The corresponding first entries in the output extent list correctly
> > > +     *     indicate the GMFNs that were successfully exchanged.
> > > +     *  3. All other input and output extents are untouched.
> > > +     *  4. If not all input exents are exchanged then the return code of this
> > > +     *     command will be non-zero.
> > > +     *  5. THIS FIELD MUST BE INITIALISED TO ZERO BY THE CALLER!
> 
> as this says the initial value is zero.

This is referring to nr_exchanged.
