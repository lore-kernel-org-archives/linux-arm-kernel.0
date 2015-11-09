From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2015 16:01:37 +0000
Subject: [PATCH] arch:arm:mm:Correction in the boundary check for module
 end address.
In-Reply-To: <CAPP0e=POFR3BmH0jZvtcaWLM_zfLHG1eUcpkLX7dchrZxLigNA@mail.gmail.com>
References: <1447055848-28180-1-git-send-email-shailendra.v@samung.com>
 <CAPP0e=POFR3BmH0jZvtcaWLM_zfLHG1eUcpkLX7dchrZxLigNA@mail.gmail.com>
Message-ID: <20151109160137.GA8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 12:35:50AM +0900, Jungseung Lee wrote:
> Hi,
> 
> 2015-11-09 16:57 GMT+09:00 Shailendra Verma <shailendra.v@samung.com>:
> > From: Shailendra Verma <Shailendra.v@samsung.com>
> >
> > The module end boundary check is not proper.The out of bound value
> > of module end can produce undesired results.
> >
> > Signed-off-by: Shailendra Verma <Shailendra.v@samsung.com>
> > Reviewed-by: Ravikant Bijendra Sharma <ravikant.s2@samsung.com>
> > ---
> >  linux-4.3-rc6/arch/arm/mm/pageattr.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/linux-4.3-rc6/arch/arm/mm/pageattr.c b/linux-4.3-rc6/arch/arm/mm/pageattr.c
> > index cf30daf..be7fe4b 100644
> > --- a/linux-4.3-rc6/arch/arm/mm/pageattr.c
> > +++ b/linux-4.3-rc6/arch/arm/mm/pageattr.c
> > @@ -52,7 +52,7 @@ static int change_memory_common(unsigned long addr, int numpages,
> >         if (start < MODULES_VADDR || start >= MODULES_END)
> >                 return -EINVAL;
> >
> > -       if (end < MODULES_VADDR || start >= MODULES_END)
> > +       if (end < MODULES_VADDR || end >= MODULES_END)
> >                 return -EINVAL;
> >
> >         data.set_mask = set_mask;
> > --
> > 1.7.9.5
> >
> Same patch with proper format is already submitted by Hillf.
> https://lkml.org/lkml/2015/5/3/202

What happened to that patch?  It should at least have had a:

Fixes: f2ca09f381a5 ("ARM: 8311/1: Don't use is_module_addr in setting page attributes")

tag on it, and it needs to find its way into the patch system.  As
no one has reported a crash (I don't think it's crash-causing, but is
merely a correctness issue) I don't see any reason to backport it to
stable trees.

Other changes are needed here as well - the original commit creating
this contains:

+       if (!IS_ALIGNED(addr, PAGE_SIZE)) {
+               start &= PAGE_MASK;
+               end = start + size;
+               WARN_ON_ONCE(1);
+       }

which is truely amazing.  Fine, it may not be intended to work with
non-aligned addresses, but if we're going to round the start down,
then rounding the end down as well like that is also buggy.

	unsigned long start = addr;
	unsigned long size = PAGE_SIZE * numpages;
	unsigned long end = start + size;

	if (WARN_ON_ONCE(!IS_ALIGNED(addr, PAGE_SIZE)) {
		start &= PAGE_MASK;
		end = PAGE_ALIGN(end);
	}

would be much better - this will round 'end' up, so we encompass the
entire requested region.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
