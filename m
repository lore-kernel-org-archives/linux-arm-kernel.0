From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 11:30:11 +0200
Subject: [PATCH] md: fix 32-bit build warning
In-Reply-To: <87fv1g1y34.fsf@notabene.neil.brown.name>
References: <5304496.D8N6u074t0@wuerfel>
 <87fv1g1y34.fsf@notabene.neil.brown.name>
Message-ID: <11281560.gJ28rX782P@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 15:59:27 Neil Brown wrote:
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 7fff1e6884d6..e13f72a3b561 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -8987,9 +8987,9 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
> >  
> >       /* recovery_cp changed */
> >       if (le64_to_cpu(sb->resync_offset) != mddev->recovery_cp) {
> > -             pr_info("%s:%d recovery_cp changed from %lu to %lu\n", __func__,
> > -                             __LINE__, mddev->recovery_cp,
> > -                             (unsigned long) le64_to_cpu(sb->resync_offset));
> > +             pr_info("%s:%d recovery_cp changed from %llu to %llu\n", __func__,
> > +                             __LINE__, (u64)mddev->recovery_cp,
> > +                             (u64) le64_to_cpu(sb->resync_offset));
> >               mddev->recovery_cp = le64_to_cpu(sb->resync_offset);
> >       }
> >  
> 
> Thanks, but is this really right?
> I think u64 is "unsigned long" on 64bit.
> I have always used (unsigned long long) when I want to use %llu on
> sector_t.
> 
> How confident are you of using "u64" ?

Very confident ;-)

This used to not work until some linux-2.6 version when we changed all
architectures to use asm-generic/int-ll64.h in the kernel, because
a lot of code relied on printing u64 variables using %lld.

I tend to use u64 for things like this because it's shorter than
'unsigned long long'.

	Arnd
