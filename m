From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri, 14 Jan 2011 06:31:31 +0800
Subject: mmaping a fixed address fails on ARM
In-Reply-To: <19758.51555.797311.465295@pilspetsen.it.uu.se>
References: <AANLkTin0jjxLTWzkLHnJ+sGQz=jdDDL94R9o1gh-rO9P@mail.gmail.com>
	<AANLkTim1MOB+r1shuJDvqJexerFo3wQ_o1wQpiaALW=0@mail.gmail.com>
	<19758.51555.797311.465295@pilspetsen.it.uu.se>
Message-ID: <AANLkTikBho6eU_LLtvWOrks6+eP2a32K0ZSS5p+WJg++@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 5:44 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> Bryan Wu writes:
> ?> Let me add Andre here
> ?>
> ?> Thanks,
> ?> -Bryan
> ?>
> ?> On Thu, Jan 13, 2011 at 5:58 AM, Bryan Wu <bryan.wu@canonical.com> wrote:
> ?> > Hi Russell,
> ?> >
> ?> > Andre posted a mmap testcase [1] and a bug report [2] for Ubuntu
> ?> > kernel on OMAP4 system, since he is porting some applications from x86
> ?> > to ARM. He testcase works fine on x86, but always fail on ARM. I've
> ?> > tested it on OMAP3/OMAP4/i.MX51.
> ?> >
> ?> > Basically what he want to do is get a mapping on a specific virtual
> ?> > address. But AFAIK, mmap doesn't make sure we can get the mapping
> ?> > address as we want. On x86, it works fine. So if this fails, the
> ?> > application can't run on ARM.
> ?> >
> ?> > The implementation of arch_get_unmapped_area() is different from ARM
> ?> > and x86, that might makes mmap behavior different between ARM and x86.
> ?> > Andre said 2.6.28-versatile. I'm not sure whether it is a regression.
> ?> >
> ?> > [1]: http://launchpadlibrarian.net/61588086/main.c
> ?> > [2]: https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/697004
>
> mmap() with a non-NULL hint referring to a currently unmapped area,
> but without MAP_FIXED, isn't even remotely portable or reliable
> (I've tried it myself in the context of JITs). ?It may work on
> Linux/x86, but that doesn't allow you to assume it should work
> on other OS/CPU combinations (and I know of several where it
> emphatically doesn't work).
>

Exactly. I also think the mmap() behavior is correct in this test
scenario. The address location was mapped by some LD libraries, so
mmaping those address won't get the address we expected.

> If you want a fixed address then use MAP_FIXED. ?If you don't want
> MAP_FIXED to clobber an existing mapping then you have to keep track
> of existing mappings yourself and avoid them.
>
> What is that "some application"?
>

I guess it is 'wine', don't be surprise. -:)

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
