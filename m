From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 16 Apr 2012 22:05:44 +0800
Subject: Pinctrl crash on latest linux-next/master
In-Reply-To: <CACRpkdb9JOKK=XY0t3GcrOCxyfefi5nw08S4yv=bXREemOM10w@mail.gmail.com>
References: <4F8BFA3F.5030409@st.com>
 <CACRpkdb9JOKK=XY0t3GcrOCxyfefi5nw08S4yv=bXREemOM10w@mail.gmail.com>
Message-ID: <20120416140543.GC17173@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 02:50:47PM +0200, Linus Walleij wrote:
> On Mon, Apr 16, 2012 at 12:53 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> 
> > I don't know if the issue is in my patches or something else, but i was
> > able to boot it earlier. Till my V3 for pinctrl. And nothing much changed
> > since then, i just rebased on latest kernel.
> 
> Hm I haven't tested the pinctrl tree on v3.4-rc3 yet.
> 
Your for-next tree is ok since i'm working on it for pinctrl-imx driver. :-)
It seems it's based on v3.4-rc2.

Hi Viresh,
Some info for your reference:

You may want to check if you call platform_set_drvdata after pinctrl_register
like:
ipmx->pctl = pinctrl_register(&imx_pmx_desc, &pdev->dev, ipmx);
...
platform_set_drvdata(pdev, ipmx);

If that, you may need to change to:
platform_set_drvdata(pdev, ipmx);
..
ipmx->pctl = pinctrl_register(&imx_pmx_desc, &pdev->dev, ipmx);

Because during the registration, the get_group_count will be called which
may reply on platform_set_drvdata(pdev, ipmx);

Regards
Dong Aisheng

> Did you git bisect to figure out which patch broke it?
> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
