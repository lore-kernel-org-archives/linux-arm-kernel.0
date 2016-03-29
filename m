From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 29 Mar 2016 15:01:47 +0300
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <4405408.txAtlZbTDH@wuerfel>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <6653982.FK62mVSCZO@wuerfel> <56F6825B.7000906@huawei.com>
 <4405408.txAtlZbTDH@wuerfel>
Message-ID: <20160329120147.GA3551@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 12:58:25PM +0200, Arnd Bergmann wrote:
> On Saturday 26 March 2016 20:36:43 Zhangjian wrote:
> > Hi, Arnd
> > 
> > On 2016/3/21 17:43, Arnd Bergmann wrote:
> > > On Monday 21 March 2016 10:07:49 Andreas Schwab wrote:
> > >> This patch may fix a few LTP tests.
> > >>
> > >
> > > Thanks for analyzing.
> > >
> > >> diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h b/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
> > >> index 3631903..d1010db 100644
> > >> --- a/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
> > >> +++ b/sysdeps/unix/sysv/linux/aarch64/bits/fcntl.h
> > >> @@ -25,18 +25,29 @@
> > >>   #define __O_NOFOLLOW	0100000
> > >>   #define __O_DIRECT	0200000
> > >>
> > >> -#define __O_LARGEFILE	0
> > >> +#ifdef __ILP32__
> > >> +# define __O_LARGEFILE	0400000
> > >> +#else
> > >> +# define __O_LARGEFILE	0
> > >> +#endif
> > >>
> > >
> > > I guess this means I screwed up when I said I'd merged the kernel patch
> > > that Yury did to fix it, sorry about that.
> > >
> > > We need the patch to make all new architecture in the kernel default to
> > > O_LARGEFILE, and not do this in user space. I'd suggest now to keep the
> > > patches as part of the ILP32 series after all, to make sure they are
> > > merged at the point when they are needed.
> > 
> > I am a little bit confuse about off_t. In "[PATCH 08/33] 32-bit
> > ABI: introduce ARCH_32BIT_OFF_T config option", it mentioned that all
> > the new 32bit architecture should use 64bit off_t.
> 
> Ah, so it is part of the series. I had not checked that here.
> 

I'm preparing new submission now. I can join off_t, s390 and ilp32
patchsets. It seems, they will not be grabbed separately anyway, so
this may decrease confusions like this.

Arnd?

> > Should we define off_t in aarch64(for both ilp32 and lp64) in
> > typesize.h as following?
> > 
> > diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h b/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
> > index 7073493..13b77c5 100644
> > --- a/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
> > +++ b/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
> > @@ -33,7 +33,7 @@
> >   #define __INO64_T_TYPE         __UQUAD_TYPE
> >   #define __MODE_T_TYPE          __U32_TYPE
> >   #define __NLINK_T_TYPE         __U32_TYPE
> > -#define __OFF_T_TYPE           __SLONGWORD_TYPE
> > +#define __OFF_T_TYPE           __SQUAD_TYPE
> >   #define __OFF64_T_TYPE         __SQUAD_TYPE
> >   #define __PID_T_TYPE           __S32_TYPE
> >   #define __RLIM_T_TYPE          __ULONGWORD_TYPE
> > 
> > Then we could remove the __USE_FILE_OFFSET64 in stat.h and fcnt.h in
> > aarch64. And truncate and ftruncate is same as truncate64 and
> > ftruncate64.
> 
> I don't know what the glibc developers prefer, but I think the
> result needs to be something like that: either __OFF_T_TYPE is
> defined as you write above as a 64-bit type, or the user-visible
> off_t typedef unconditionally uses __OFF64_T_TYPE rather than
> __OFF_T_TYPE.
> 

I'm not the glibc developer as well, but I think it's OK.

> > Otherwise we need to handle the pad like yury do it in
> > stat.h, and we need to handle the bigendian as well:
> 
> I see.
> 
> > @@ -35,12 +35,21 @@ struct stat
> >     {
> >       __dev_t st_dev;			/* Device.  */
> >   #ifdef __ILP32__
> > +
> > +#if !defined(__AARCH64EB__)
> >       unsigned int __st_ino_pad;
> > +#endif
> > +
> >   # ifndef __USE_FILE_OFFSET64
> >       __ino_t st_ino;			/* File serial number.	*/
> >   # else
> >       __ino_t __st_ino;			/* 32bit file serial number.	*/
> >   # endif
> > +
> > +#if defined(__AARCH64EB__)
> > +    unsigned int __st_ino_pad;
> > +#endif
> > +
> >   #else
> 
> This would indeed be silly, we really don't want anyone
> to access the old __st_ino field or the 32-bit version of
> the offset here.
> 
> 	Arnd
