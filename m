From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 May 2011 13:56:37 +0900
Subject: [PATCH] ARM: S5PV210: Fix possible null pointer dereference.
In-Reply-To: <4DCD197A.9020900@ru.mvista.com>
References: <1305270186-7722-1-git-send-email-kgene.kim@samsung.com>
	<4DCD197A.9020900@ru.mvista.com>
Message-ID: <000c01cc1385$a60782f0$f21688d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> 
> Hello.
> 
Hi ;)

> On 13-05-2011 11:03, Kukjin Kim wrote:
> 
> > From: Jonghwan Choi<jhbird.choi@samsung.com>
> 
> > Signed-off-by: Jonghwan Choi<jhbird.choi@samsung.com>
> > Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> > ---
> >   arch/arm/mach-s5pv210/cpufreq.c |    4 +++-
> >   1 files changed, 3 insertions(+), 1 deletions(-)
> 
> > diff --git a/arch/arm/mach-s5pv210/cpufreq.c b/arch/arm/mach-
> s5pv210/cpufreq.c
> > index 22046e2..58340ee 100644
> > --- a/arch/arm/mach-s5pv210/cpufreq.c
> > +++ b/arch/arm/mach-s5pv210/cpufreq.c
> > @@ -105,8 +105,10 @@ static void s5pv210_set_refresh(enum
> s5pv210_dmc_port ch, unsigned long freq)
> >   		reg = (S5P_VA_DMC0 + 0x30);
> >   	else if (ch == DMC1)
> >   		reg = (S5P_VA_DMC1 + 0x30);
> > -	else
> > +	else {
> >   		printk(KERN_ERR "Cannot find DMC port\n");
> > +		return;
> > +	}
> 
>     According to CodingStyle, other branches should now have {} too.
> 
Yes, you're right.

I updated its commit in my tree like following.

---
diff --git a/arch/arm/mach-s5pv210/cpufreq.c
b/arch/arm/mach-s5pv210/cpufreq.c
index 22046e2..153af8b 100644
--- a/arch/arm/mach-s5pv210/cpufreq.c
+++ b/arch/arm/mach-s5pv210/cpufreq.c
@@ -101,12 +101,14 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port
ch, unsigned long freq)
        unsigned long tmp, tmp1;
        void __iomem *reg = NULL;

-       if (ch == DMC0)
+       if (ch == DMC0) {
                reg = (S5P_VA_DMC0 + 0x30);
-       else if (ch == DMC1)
+       } else if (ch == DMC1) {
                reg = (S5P_VA_DMC1 + 0x30);
-       else
+       } else {
                printk(KERN_ERR "Cannot find DMC port\n");
+               return;
+       }

        /* Find current DRAM frequency */
        tmp = s5pv210_dram_conf[ch].freq;
---

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
