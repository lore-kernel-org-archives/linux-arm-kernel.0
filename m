From: bhe@redhat.com (Baoquan He)
Date: Sat, 28 May 2016 19:33:54 +0800
Subject: [PATCH kexec-tools 07/32] kexec: fix warnings caused by
 selecting 64-bit file IO on 32-bit platforms
In-Reply-To: <E1axXSV-0004hZ-CH@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSV-0004hZ-CH@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <20160528113354.GB2429@x1.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/16 at 11:21am, Russell King wrote:
> Fix warnings caused by selecting 64-bit file IO on 32-bit platforms.
> 
> kexec/kexec.c:710:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'off_t' [-Wformat]
> kexec/zlib.c:63:4: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'off_t' [-Wformat]
> kexec/kexec-uImage.c:85:3: warning: format '%ld' expects argument of type 'long
> int', but argument 2 has type 'off_t' [-Wformat]
> 
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
> ---
>  kexec/kexec-uImage.c | 3 ++-
>  kexec/kexec.c        | 4 ++--
>  kexec/zlib.c         | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
> index 9df601b..5e24629 100644
> --- a/kexec/kexec-uImage.c
> +++ b/kexec/kexec-uImage.c
> @@ -82,7 +82,8 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
>  	if (be32_to_cpu(header.ih_size) > len - sizeof(header)) {
>  		printf("uImage header claims that image has %d bytes\n",
>  				be32_to_cpu(header.ih_size));
> -		printf("we read only %ld bytes.\n", len - sizeof(header));
> +		printf("we read only %lld bytes.\n",
> +		       (long long)len - sizeof(header));

With "D_FILE_OFFSET_BITS=64" adding, off_t is identical to off64_t, is
that necessary to still take a type conversion here?

Is that OK to be like this:

		printf("we read only %lld bytes.\n", len - sizeof(header));
