From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 09:14:32 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <3754277.KmO9Nk3XLD@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-15-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel>
Message-ID: <3999351.LDb9Xyt8Yk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 22:57:52 Arnd Bergmann wrote:
> > +#define compat_sys_open_by_handle_at   sys_open_by_handle_at
> 
> The only difference here is the forced O_LARGEFILE, but that
> is set by glibc anyway, right?
> 
> > +#define compat_sys_openat              sys_openat
> 
> same as open_by_handle_at
> 

I gave it some more thought, and I think we should actually stay
with sys_open_by_handle_at and sys_openat, but do it a little differently:

Forcing O_LARGEFILE is probably what we want for all architectures
going forward, so we should change asm-generic/unistd.h to use sys_openat
for compat mode, and override it for tile32 compat, which is the only
existing user of this table at the moment and which needs to
retain the existing behavior.

	Arnd
