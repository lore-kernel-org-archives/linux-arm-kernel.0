From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Wed, 27 Feb 2013 13:38:24 +0900
Subject: [RFC PATCH v2 1/4] decompressor: Add LZ4 decompressor module
In-Reply-To: <20130226131206.GW27541@twin.jikos.cz>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <1361859870-15751-2-git-send-email-kyungsik.lee@lge.com>
 <20130226131206.GW27541@twin.jikos.cz>
Message-ID: <20130227043824.GA5652@Corona>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 02:12:06PM +0100, David Sterba wrote:
> On Tue, Feb 26, 2013 at 03:24:27PM +0900, Kyungsik Lee wrote:
> > This patch adds support for LZ4 decompression in the Linux Kernel.
> > LZ4 Decompression APIs for kernel are based on LZ4 implementation
> > by Yann Collet.
> > 
> > LZ4 homepage : http://fastcompression.blogspot.com/p/lz4.html
> > LZ4 source repository : http://code.google.com/p/lz4/
> 
> What SVN version did you use?
It's based on r88.

> > +/*
> > + * LZ4_COMPRESSBOUND()
> > + * Provides the maximum size that LZ4 may output in a "worst case" scenario
> > + * (input data not compressible)
> > + */
> > +#define LZ4_COMPRESSBOUND(isize) (isize + ((isize)/255) + 16)
> 
> For safety reasons I suggest to add a temporary variable to avoid double
> evaluation of isize.
Yes, Good point.
> > --- /dev/null
> > +++ b/lib/lz4/lz4_decompress.c
> > +	}
> > +	cpy = op + length - (STEPSIZE - 4);
> > +	if (cpy > oend - COPYLENGTH) {
> > +
> > +		/* Error: request to write beyond destination buffer */
> > +		if (cpy > oend)
> > +			goto _output_error;
> > +		LZ4_SECURECOPY(ref, op, (oend - COPYLENGTH));
> > +		while (op < cpy)
> > +			*op++ = *ref++;
> > +		op = cpy;
> > +		/*
> > +		 * Check EOF (should never happen, since last 5 bytes
> > +		 * are supposed to be literals)
> > +		 */
> > +		if (op == oend)
> > +			goto _output_error;
> > +		continue;
> > +	}
> > +		LZ4_SECURECOPY(ref, op, cpy);
> > +		op = cpy; /* correction */
> > +	}
> 
> Does this compile? The } is an extra one, and does not match the
> original sources.
>
It's about indent errors. The } is a pair of braces regarding
"while (1) {". However it compiled. It will be fixed.
 
> > +#define LZ4_COPYPACKET(s, d)	\
> > +	do {			\
> > +		LZ4_COPYSTEP(s, d);	\
> > +		LZ4_COPYSTEP(s, d);	\
> > +	} while (0)
> > +
> > +#define LZ4_SECURECOPY	LZ4_WILDCOPY
> > +#endif
> > +
> > +#define LZ4_READ_LITTLEENDIAN_16(d, s, p) \
> > +	(d = s - get_unaligned_le16(p))
> > +#define LZ4_WILDCOPY(s, d, e)	\
> > +	do {				\
> > +		LZ4_COPYPACKET(s, d);	\
> > +	} while (d < e)
> 
> All the \ at the ends of lines would look better aligned in one column.
>
Yes, right. It looks better if it's aligned.

Thanks,
Kyungsik
