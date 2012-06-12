From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 12 Jun 2012 13:26:22 -0400 (EDT)
Subject: [PATCH v2] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <20120612191804.4211462a@tukaani.org>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
 <20120612191804.4211462a@tukaani.org>
Message-ID: <alpine.LFD.2.02.1206121316190.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jun 2012, Lasse Collin wrote:

> On 2012-06-11 T Makphaibulchoke wrote:
> > +#ifndef __HAVE_PREBOOT_ARCH_MEMMOVE
> > +void *memmove(void *__dest, __const void *__src, size_t count)
> > +{
> > +	unsigned char *d = __dest;
> > +	const unsigned char *s = __src;
> > +
> > +	if (__dest == __src)
> > +		return __dest;
> > +
> > +	if (__dest < __src)
> > +		return memcpy(__dest, __src, count);
> > +
> > +	while (count--)
> > +		d[count] = s[count];
> > +	return __dest;
> > +}
> > +#endif
> 
> The use of memcpy when __dest < __src is OK with some memcpy
> implementations, but in a generic case it isn't guaranteed to work.

Of course, if the memcpy implementation is also provided along with this 
memmove code, as it was the case on ARM before this patch, then you can 
guarantee it.  And if that memcpy() happens to be slightly more 
optimized then this is a win.

> I think it would be better to just copy memmove from lib/string.c.

Instead of copying, maybe this would be much better to make the content 
of lib/string.c usable in a pre-boot environment.


Nicolas
