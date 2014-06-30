From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 15:06:04 +0200
Subject: [PATCH v7 6/9] ARM: miscellaneous vdso infrastructure, preparation
In-Reply-To: <53B157CF.1040204@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <201406301211.43359.arnd@arndb.de> <53B157CF.1040204@mentor.com>
Message-ID: <4924024.rTPP3FKi53@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 June 2014 07:27:59 Nathan Lynch wrote:
> On 06/30/2014 05:11 AM, Arnd Bergmann wrote:
> > On Monday 23 June 2014, Nathan Lynch wrote:
> >> +struct vdso_data {
> >> +       u32 seq_count;          /* sequence count - odd during updates */
> >> +       u16 use_syscall;        /* whether to fall back to syscalls */
> >> +       u16 cs_shift;           /* clocksource shift */
> >> +       u32 xtime_coarse_sec;   /* coarse time */
> >> +       u32 xtime_coarse_nsec;
> > 
> > Note that we will at some point have to introduce 64-bit time_t in user space
> > in some form. We will have to add new system calls for anything dealing with
> > time on the kernel boundary, but it would be good to be prepared here.
> > 
> > Is vdso_data an ABI-relevant data structure? If so, I think all you need here
> > is to make xtime_coarse_sec a u64 type for now, so we can add the other functions
> > later. The code can of course for now access only the lower half (keeping
> > endianess in mind), so there should not be any performance impact.
> > 
> > If the structure is not part of the ABI, there probably isn't much we can
> > do here.
> 
> In short, no, vdso_data is not ABI-relevant.
> 
> The vdso_data structure may be accessed legitimately only through the
> entry points (gettimeofday, clock_gettime) that the VDSO provides, and
> it is my intent that we should be able to change the structure as
> needed, just like other architectures.  vdso_data should not show up in
> any exported header and I'll double-check to make sure it does not.
> 
> So, when the time comes, we should be able to change it to accommodate
> 64-bit time_t by (I imagine) making any field that stores seconds 64
> bits and adding new entry points (clock_gettime64 or whatever).

Ok, very good.

	Arnd
