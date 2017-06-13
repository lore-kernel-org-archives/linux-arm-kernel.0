From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 13 Jun 2017 14:04:11 +0300
Subject: [PATCH 02/20] 32-bit ABI: introduce ARCH_32BIT_OFF_T config option
In-Reply-To: <20170608150950.iqq4xgxu6zsa7m52@localhost>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-3-ynorov@caviumnetworks.com>
 <20170608150950.iqq4xgxu6zsa7m52@localhost>
Message-ID: <20170613110411.rijis4m2z5cdfdo4@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 04:09:50PM +0100, Catalin Marinas wrote:
> On Sun, Jun 04, 2017 at 02:59:51PM +0300, Yury Norov wrote:
> > All new 32-bit architectures should have 64-bit off_t type, but existing
> > architectures has 32-bit ones.
> > 
> > To handle it, new config option is added to arch/Kconfig that defaults
> > ARCH_32BIT_OFF_T to be disabled for non-64 bit architectures. All existing
> > 32-bit architectures enable it explicitly here.
> > 
> > New option affects force_o_largefile() behaviour. Namely, if off_t is
> > 64-bits long, we have no reason to reject user to open big files.
> > 
> > Note that even if architectures has only 64-bit off_t in the kernel
> > (arc, c6x, h8300, hexagon, metag, nios2, openrisc, tile32 and unicore32),
> > a libc may use 32-bit off_t, and therefore want to limit the file size
> > to 4GB unless specified differently in the open flags.
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> [...]
> > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > index 1b48d9c9a561..297993c92490 100644
> > --- a/include/linux/fcntl.h
> > +++ b/include/linux/fcntl.h
> > @@ -11,7 +11,7 @@
> >  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> >  
> >  #ifndef force_o_largefile
> > -#define force_o_largefile() (BITS_PER_LONG != 32)
> > +#define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
> >  #endif
> 
> I may have confused myself with which off_t is 64-bit here for new
> 32-bit architectures. Are we referring to the glibc definition, the
> kernel one or simply that force_o_largefile() is true by default.
> Because the type off_t for 32-bit kernel builds is still, well, 32-bit.
> 
> Otherwise it seems that the first paragraph in the description above
> should read "all new 32-bit ABIs on a 64-bit kernel..." but then
> AArch64/ILP32 is no longer the same as a new, pure 32-bit architecture.
 
This is all about userspace off_t types, like Arnd told in the comment
to patch 13. I'll underline it in the comment to the patch. If it's
not enough, I can also rename the config option to
CONFIG_ARCH_32BIT_USER_OFF_T or similar. For me it's too much, but if
you find it reasonable, I'll do it. Just let me know.

Yury
