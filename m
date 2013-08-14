From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 14 Aug 2013 17:43:22 +0100
Subject: [PATCH v3 07/10] xen: introduce XENMEM_get_dma_buf and
 xen_put_dma_buf
In-Reply-To: <20130809153606.GD5637@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1308051503190.4893@kaball.uk.xensource.com>
 <1375720256-8014-7-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130809153606.GD5637@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1308141719480.4470@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Aug 2013, Konrad Rzeszutek Wilk wrote:
> > + * requested. The new pages are going to be "pinned": it's guaranteed
> > + * that their p2m mapping won't be changed until explicitly "unpinned".
> 
> What if you try to balloon them out? What happens then? Does that
> unpin them automatically?
> 
> What if I use said "pin" page for grants? Can they be shared with another
> guest?

I'll mention that only normal guest r/w memory can be pinned.


> > + * If return code is zero then @out.extent_list provides the MFNs of the
> > + * newly-allocated memory.  Returns zero on complete success, otherwise
> > + * a negative error code.
> 
> Ahem. Which ones? I know you didn't like the existing grant code b/c it
> returned some general error. Would it make sense to say which are ones
> are expected?

I'll do that.


> > + * On complete success then always @nr_exchanged == @in.nr_extents.  On
> > + * partial success @nr_exchanged indicates how much work was done.
> 
> And no error?
> > + */
> > +struct xen_get_dma_buf {
> > +    /*
> > +     * [IN] Details of memory extents to be exchanged (GMFN bases).
> > +     * Note that @in.address_bits is ignored and unused.
> 
> Ohhhh, why? What if the user wants to be it under 2G?

As per the other email, that goes in out.address_bits. I'll add a note.


> > +     */
> > +    struct xen_memory_reservation in;
> > +
> > +    /*
> > +     * [IN/OUT] Details of new memory extents.
> > +     * We require that:
> > +     *  1. @in.domid == @out.domid
> > +     *  2. @in.nr_extents  << @in.extent_order == 
> > +     *     @out.nr_extents << @out.extent_order
> > +     *  3. @in.extent_start and @out.extent_start lists must not overlap
> > +     *  4. @out.extent_start lists GPFN bases to be populated
> > +     *  5. @out.extent_start is overwritten with allocated GMFN bases
> > +     */
> > +    struct xen_memory_reservation out;
> > +
> > +    /*
> > +     * [OUT] Number of input extents that were successfully exchanged:
> > +     *  1. The first @nr_exchanged input extents were successfully
> > +     *     deallocated.
> > +     *  2. The corresponding first entries in the output extent list correctly
> > +     *     indicate the GMFNs that were successfully exchanged.
> > +     *  3. All other input and output extents are untouched.
> > +     *  4. If not all input exents are exchanged then the return code of this
> > +     *     command will be non-zero.
> > +     *  5. THIS FIELD MUST BE INITIALISED TO ZERO BY THE CALLER!
> > +     */
> > +    xen_ulong_t nr_exchanged;
> > +};
> > +DEFINE_GUEST_HANDLE_STRUCT(xen_get_dma_buf);
> > +
> > +#define XENMEM_put_dma_buf             27
> > +/*
> > + * XENMEM_put_dma_buf unpins a set of pages, previously pinned by
> > + * XENMEM_get_dma_buf. After this call the p2m mapping of the pages can
> > + * be transparently changed by the hypervisor, as usual. The pages are
> > + * still accessible from the guest.
> 
> I don't understand what 'pinned' means. What is a 'pinned' page versus
> a normal page? Is this like the pagetables which must be _RO?

A pinned page is just a normal page that the hypervisor promises is
going to keep having the same machine address until unpinned.
