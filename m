From: dsd@laptop.org (Daniel Drake)
Date: Wed, 14 Aug 2013 12:56:33 -0600
Subject: [PATCH v6 04/11] ARM: mmp: avoid to include head file in mach-mmp
In-Reply-To: <1374833133-21119-5-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-5-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CAMLZHHSky=keai-Ly53govnwWOKTYg_zn35WHVKH6C=GjVpVFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 4:05 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> pxa910_set_wake() & mmp2_set_wake() are both declared in head files
> of arch/arm/mach-mmp/include/mach directory. If we include these
> head files in irq-mmp driver, it blocks the multiplatform build.
> So adjust the code.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

This fails to build with CONFIG_PM=n, since mmp2_set_wake() is not
defined anywhere.
This is not a regression introduced by this patch, but now seems like
a good time to fix that minor problem.

Could this line
       icu_irq_chip.irq_set_wake = mmp2_set_wake;
be moved to mmp2_pm_init() in pm-mmp2.c (or is that too late)?
If so you could even make the mmp2_set_wake function static.

Thanks
Daniel
