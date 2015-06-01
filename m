From: christian.koenig@amd.com (=?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=)
Date: Mon, 1 Jun 2015 10:20:10 +0200
Subject: [PATCH 05/98] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <20150530164655.GM2067@n2100.arm.linux.org.uk>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
 <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
 <20150530164655.GM2067@n2100.arm.linux.org.uk>
Message-ID: <556C15BA.7000909@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.05.2015 18:46, Russell King - ARM Linux wrote:
> On Sat, May 30, 2015 at 05:37:57PM +0200, Mikko Rapeli wrote:
>> Fixes userspace compilation error:
>>
>> drm/exynos_drm.h:30:2: error: unknown type name ?uint64_t?
>>
>> Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
> This is another thing which we need to address.  We should not be using
> unsigned int/unsigned long/uintXX_t/etc in here, but the __uXX and __sXX
> types.
>
> The lesson learned from other DRM developers is that using these types
> simplifies the API especially when it comes to the differences between
> 32-bit and 64-bit machines, and compat applications.
>
> Note that drm/drm.h is all that should need to be included - drm/drm.h
> takes care of including linux/types.h when building on Linux platforms.
> (note: if your compiler doesn't set __linux__ then you're probably not
> using the proper compiler...)
>

Using types that differs on 32-bit and 64-bit machines for a kernel 
interface is indeed a rather bad idea. This not only includes longs, but 
pointers as well.

But the int8_t, int16_t int32_t, int64_t and their unsigned counterparts 
are defined in stdint.h which is part of the ISO/IEC 9899:1999 standard, 
similar is true for size_t.

The __uXX, __sXX and _kernel_size_t types are linux specific as far as I 
know.

For best interoperability and standard conformance I think that 
definitions from the C standard we use should out-rule linux specific 
definitions.

Additional to that "linux/types.h" is not part of the uapi as far as I 
know, so including it in a header which is part of the uapi should be 
forbidden.

So this is a NAK from my side for the whole series, userspace programs 
should include <stdint.h> for the definition of the ISO/IEC 9899:1999 
standard types if necessary.

Regards,
Christian.
