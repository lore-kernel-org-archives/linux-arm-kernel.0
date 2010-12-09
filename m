From: carmelo.amoroso@st.com (Carmelo AMOROSO)
Date: Thu, 9 Dec 2010 16:56:26 +0100
Subject: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
In-Reply-To: <20101208044052.GA31508@linux-sh.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<201012071515.25418.vapier@gentoo.org>
	<20101208044052.GA31508@linux-sh.org>
Message-ID: <4D00FC2A.8040309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/8/2010 5:40 AM, Paul Mundt wrote:
> On Tue, Dec 07, 2010 at 03:15:23PM -0500, Mike Frysinger wrote:
>  > On Tuesday, December 07, 2010 05:20:53 Filippo ARCIDIACONO wrote:
>  > > Add stack smashing suppurt for SH architecture. This is based on work
>  > > from Nicolas Pitre for ARM (c743f38013aeff58ef6252601e397b5ba281c633).
>  > > Use the ARM boot_init_stack_canary function to initialize the guard
>  > > canary. It has been placed under asm-generic to allow archtectures
>  > > based on __stack_chk_guard to use a common implementation.
>  > > Update the __stack_chk_guard global variable with the value stored in
>  > > the task struct whenever a task switch occurs to allow for different
>  > > canary values per task. This cannot work on SMP where the initial
>  > > canary value is always used.
>  > >
>  > > arch/sh/Kconfig | 13 +++++++++++
>  > > arch/sh/Makefile | 4 +++
>  > > arch/sh/include/asm/stackprotector.h | 10 ++++++++
>  > > arch/sh/kernel/process_32.c | 9 +++++++
>  > > include/asm-generic/stackprotector.h | 39
>  >
>  > if you're starting asm-generic stuff, why not go the distance and do it all in
>  > common code ? your sh/Kconfig and sh/Makefile changes arent specific to
>  > SuperH, nor is the symbol in process_32.c.
> 
> Indeed. It would be nice to simply shove this in to lib/ with the
> Makefile bits in the top-level Makefile.
> 

Hi Paul, Mike
thanks for your feedback.

I agree with you that the Kconfig and Makefile changes are not arch
specific, so these changes can be moved to a common code (even if I
don't know if other archs do support SSP).
In the current kernel, only x86 and ARM added this support, so I'm
wondering if, moving SSP to the common Makefile, it needs to depend on
x86, ARM, SH being configured ?

Regarding the __stack_chk_guard symbol defined in process[_32].c, I
don't know if all archs need to define this global variable to implement
SSP. For sure x86 does not need it. It depends on how the gcc implements
this feature. This was mainly the reason for which we defined it
specifically in an arch specific code.

What is your opinion ?

Thanks,
Carmelo & Filippo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0A/CoACgkQoRq/3BrK1s/slgCg2GVWo/uuURyvmu1401rQWP74
L3UAoNwppj1eZFpReEe0wCIbalZ7ksMs
=kDGH
-----END PGP SIGNATURE-----
