From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 23 Jun 2015 10:16:15 -0500
Subject: build failure with VDSO on non-glibc based systems
In-Reply-To: <55893659.80607@arm.com>
References: <55893659.80607@arm.com>
Message-ID: <5589783F.6040605@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2015 05:35 AM, Szabolcs Nagy wrote:
> if the host toolchain is not glibc based then the arm kernel build fails with
> 
>  arch/arm/vdso/vdsomunge.c:53:19: fatal error: error.h: No such file or directory
> 
> error.h is a glibc only header (ie not available in musl, newlib and bsd libcs).

Thanks for the report and the patch.  I agree it is inappropriate to
unnecessarily depend on glibc features in host programs.


> i attached a patch that fixes the build failure for me.

A few issues with the patch prevent me from accepting it as-is.

The patch lacks the required Signed-off-by: line; see part 11 in
Documentation/SubmittingPatches.

The body of your email would suffice as the commit log; please include
it in the patch itself.


>  
> +#define fail(...) ( \
> +	failed = 1, \
> +	fprintf(stderr, "%s: ", argv0), \
> +	fprintf(stderr, __VA_ARGS__), \
> +	exit(EXIT_FAILURE))
> +

It would be more in keeping with Linux coding style to write this as a
do { ... } while (0) block (Chapter 12 of Documentation/CodingStyle).

Writing it as a function, if possible, would be best.

Please attend to these issues and resubmit.  Alternatively, I have a
musl installation I can test with and develop an equivalent fix
(crediting you with the initial report, of course).
