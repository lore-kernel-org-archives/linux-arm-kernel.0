From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 15 Oct 2013 09:53:17 +1030
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <20131014171022.GA13807@redhat.com>
References: <525BF656.7020207@arm.com> <20131014140527.GB5106@redhat.com>
 <525BFBF9.5010804@arm.com> <8C68DB9E-8391-4CF2-BB82-A49BDA26998B@suse.de>
 <525C0514.5030103@arm.com> <525C0622.8040504@redhat.com>
 <525C09D1.8060103@arm.com> <525C0C21.2070001@redhat.com>
 <525C0F99.8030909@arm.com> <525C20E8.6080409@redhat.com>
 <20131014171022.GA13807@redhat.com>
Message-ID: <874n8jbfoa.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Mon, Oct 14, 2013 at 06:50:48PM +0200, Paolo Bonzini wrote:
>> Il 14/10/2013 17:36, Marc Zyngier ha scritto:
>> >> > 
>> >> > Devices are fine in QEMU, it's only the "generic" parts (rings) that are
>> >> > missing AFAICT.
>> > So if I understand correctly how it works, target endianness is set at
>> > compile time, and you have a BE specific QEMU?
>> 
>> Yes.  Though as Alex said, this will have to change for PPC
>> little-endian support.
>> 
>> Paolo
>
> Or we'll just say that this platform requires virtio 1.0.

To come full circle, I have implemented virtio support for BE PPC in
qemu :) And we'll be supporting pre-1.0 for the moment. I'm awaiting
some ppc-specific hooks, but it could be merged without them.

It's icky: we don't really want to use the current endianness of the
CPU, since in theory a BE kernel could be running an LE process.  So at
the time of virtio device reset (the first thing the Linux drivers do)
we read the endianness of the interrupt entry point, which is presumably
the OS endianness.

The result looks like this.  In virtio_reset(void *opaque):

        /* We assume all devices are the same endian. */
        virtio_byteswap = virtio_get_byteswap();

And accessors like this are used in all virtio devices and routines:

	/* Initialized by virtio_get_byteswap() at any virtio device reset. */
	extern bool virtio_byteswap;
	
	static inline uint16_t virtio_lduw_phys(hwaddr pa)
	{
	    if (virtio_byteswap) {
	        return bswap16(lduw_phys(pa));
	    }
	    return lduw_phys(pa);
	    
	}
	
	static inline uint32_t virtio_ldl_phys(hwaddr pa)
	{
	    if (virtio_byteswap) {
	        return bswap32(ldl_phys(pa));
	    }
	    return ldl_phys(pa);
	}
	
	static inline uint64_t virtio_ldq_phys(hwaddr pa)
	{
	    if (virtio_byteswap) {
	        return bswap64(ldq_phys(pa));
	    }
	    return ldq_phys(pa);
	}
	
	static inline void virtio_stw_phys(hwaddr pa, uint16_t value)
	{
	    if (virtio_byteswap) {
	        stw_phys(pa, bswap16(value));
	    } else {
	        stw_phys(pa, value);
	    }
	}
	
	static inline void virtio_stl_phys(hwaddr pa, uint32_t value)
	{
	    if (virtio_byteswap) {
	        stl_phys(pa, bswap32(value));
	    } else {
	        stl_phys(pa, value);
	    }
	}
	
	static inline void virtio_stw_p(void *ptr, uint16_t v)
	{
	    if (virtio_byteswap) {
	        stw_p(ptr, bswap16(v));
	    } else {
	        stw_p(ptr, v);
	    }
	}
	
	static inline void virtio_stl_p(void *ptr, uint32_t v)
	{
	    if (virtio_byteswap) {
	        stl_p(ptr, bswap32(v));
	    } else {
	        stl_p(ptr, v);
	    }
	}
	
	static inline void virtio_stq_p(void *ptr, uint64_t v)
	{
	    if (virtio_byteswap) {
	        stq_p(ptr, bswap64(v));
	    } else {
	        stq_p(ptr, v);
	    }
	}
	
	static inline int virtio_lduw_p(const void *ptr)
	{
	    if (virtio_byteswap) {
	        return bswap16(lduw_p(ptr));
	    } else {
	        return lduw_p(ptr);
	    }
	}
	
	static inline int virtio_ldl_p(const void *ptr)
	{
	    if (virtio_byteswap) {
	        return bswap32(ldl_p(ptr));
	    } else {
	        return ldl_p(ptr);
	    }
	}
	
	static inline uint64_t virtio_ldq_p(const void *ptr)
	{
	    if (virtio_byteswap) {
	        return bswap64(ldq_p(ptr));
	    } else {
	        return ldq_p(ptr);
	    }
	}
	
	static inline uint32_t virtio_tswap32(uint32_t s)
	{
	    if (virtio_byteswap) {
	        return bswap32(tswap32(s));
	    } else {
	        return tswap32(s);
	    }
	}
	
	static inline void virtio_tswap32s(uint32_t *s)
	{
	    tswap32s(s);
	    if (virtio_byteswap) {
	        *s = bswap32(*s);
	    }
	}

There are obvious optimizations to this, such as making virtio_byteswap
a compile time constant on non-endian-ambivalent targets, but this is
the current approach.

Cheers,
Rusty.
