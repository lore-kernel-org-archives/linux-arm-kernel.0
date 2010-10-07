From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Thu, 7 Oct 2010 14:16:49 -0500
Subject: [RFC] tidspbridge: use a parameter to allocate shared memory
In-Reply-To: <AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>	<201010070940.14208.laurent.pinchart@ideasonboard.com>	<4CADFCEB.4030008@ti.com>
	<AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>
Message-ID: <4CAE1CA1.4050006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/7/2010 1:22 PM, Felipe Contreras wrote:
...
>
> Note that the "shared memory" described in the document you share has
> nothing to do with the SHM pool. AFAIK that memory is used for other
> things, like MMU PTEs, and storing the base image and socket-nodes,
> thus it needs to be contiguous.

hmmm, no. it is the same memory. i.e.: we propagate the current opp 
through the shared memory so the dsp can read it if it went to sleep, 
with the proper offset you can read that variable starting from the 
mempool base address.

"storing the base image and socket-nodes" symbols is also donde in the 
shared memory but this is done in different sections of the SHM.

>
> Right now allocating contiguous memory can only be done with memblock
> (bootmem), but in the future it could be done with CMA/VCMM. But the
> cacheability is a separate issue.

yes

>
> I don't see any problem flushing the SHM area when needed, which
> probably has performance implications when mmaping/unmapping buffers,
> at which point you need to flush bigger memory areas anyway, so that's
> not an issue.

well, you would have to flush when loading the base image, or allocating 
a socket node, but also minor flushes for opp propagation, SHM messages 
to DSP, chnl params, those are the ones I can quickly think of.

>
> Anyway, we will not know for sure until we try... Right?

yes we can try, at least we now for sure arm side can be done.

Regards,

omar
