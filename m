From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 14:42:08 +0200
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160329120147.GA3551@yury-N73SV>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <4405408.txAtlZbTDH@wuerfel> <20160329120147.GA3551@yury-N73SV>
Message-ID: <4942019.FGzfTdnOaZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 15:01:47 Yury Norov wrote:
> On Tue, Mar 29, 2016 at 12:58:25PM +0200, Arnd Bergmann wrote:
> > On Saturday 26 March 2016 20:36:43 Zhangjian wrote:
> > > 
> > > I am a little bit confuse about off_t. In "[PATCH 08/33] 32-bit
> > > ABI: introduce ARCH_32BIT_OFF_T config option", it mentioned that all
> > > the new 32bit architecture should use 64bit off_t.
> > 
> > Ah, so it is part of the series. I had not checked that here.
> > 
> 
> I'm preparing new submission now. I can join off_t, s390 and ilp32
> patchsets. It seems, they will not be grabbed separately anyway, so
> this may decrease confusions like this.
> 
> Arnd?

Yes, that sounds good.

> > > Should we define off_t in aarch64(for both ilp32 and lp64) in
> > > typesize.h as following?
> > > 
> > > diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h b/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
> > > index 7073493..13b77c5 100644
> > > --- a/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
> > > +++ b/sysdeps/unix/sysv/linux/aarch64/bits/typesizes.h
> > > @@ -33,7 +33,7 @@
> > >   #define __INO64_T_TYPE         __UQUAD_TYPE
> > >   #define __MODE_T_TYPE          __U32_TYPE
> > >   #define __NLINK_T_TYPE         __U32_TYPE
> > > -#define __OFF_T_TYPE           __SLONGWORD_TYPE
> > > +#define __OFF_T_TYPE           __SQUAD_TYPE
> > >   #define __OFF64_T_TYPE         __SQUAD_TYPE
> > >   #define __PID_T_TYPE           __S32_TYPE
> > >   #define __RLIM_T_TYPE          __ULONGWORD_TYPE
> > > 
> > > Then we could remove the __USE_FILE_OFFSET64 in stat.h and fcnt.h in
> > > aarch64. And truncate and ftruncate is same as truncate64 and
> > > ftruncate64.
> > 
> > I don't know what the glibc developers prefer, but I think the
> > result needs to be something like that: either __OFF_T_TYPE is
> > defined as you write above as a 64-bit type, or the user-visible
> > off_t typedef unconditionally uses __OFF64_T_TYPE rather than
> > __OFF_T_TYPE.
> > 
> 
> I'm not the glibc developer as well, but I think it's OK.

Which of the two? I guess with the example that Bamvor gave
regarding struct stat, the latter is what we want, forcing the
use of __USE_FILE_OFFSET64 rather than changing the definition of
__OFF_T_TYPE.

	Arnd
