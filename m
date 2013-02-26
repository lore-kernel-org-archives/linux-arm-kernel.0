From: dsterba@suse.cz (David Sterba)
Date: Tue, 26 Feb 2013 15:00:51 +0100
Subject: [RFC PATCH v2 2/4] lib: Add support for LZ4-compressed kernel
In-Reply-To: <1361859870-15751-3-git-send-email-kyungsik.lee@lge.com>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <1361859870-15751-3-git-send-email-kyungsik.lee@lge.com>
Message-ID: <20130226140051.GX27541@twin.jikos.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 03:24:28PM +0900, Kyungsik Lee wrote:
> +config KERNEL_LZ4
> +	bool "LZ4"
> +	depends on HAVE_KERNEL_LZ4
> +	help
> +	  Its compression ratio is worse than LZO. The size of the kernel
> +	  is about 8% bigger than LZO. But the decompression speed is
> +	  faster than LZO.
> +

Can you please add a sentence what lz4 actually is before you start
comparing it with the current competitor(s)?

> --- /dev/null
> +++ b/lib/decompress_unlz4.c
> @@ -0,0 +1,190 @@
> +#define LZ4_CHUNK_SIZE (8<<20)

Please use a less cryptic way of representing a value of 8 MB. Also,
this is a hardcoded value that must be used on the compressor side. It's
an upper limit, so anything below 8MB does not break decompresssion, but
this must be somehow checked or saved along in the binary stream. You
seem to use the lz4demo.c on the userspace side for compression, but
this is not a standard tool nor the output format is well-defined or
stabilized.

For proper use I would like to see a commandline tool similar to
gzip/bzip2/lzop that can be packaged and shipped by distros, and the
output format defintion.

Yann has some ideas for the format
http://fastcompression.blogspot.cz/2012/04/file-container-format-for-lz4.html

For kernel, the minimum of meta information is total compressed length,
total uncompressed length and chunk size. I don't know if the first two
aren't stored elsewhere in the generic kernel image headers, but chunk
size must be specified.


david
