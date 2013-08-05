From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Aug 2013 00:25:13 -0400 (EDT)
Subject: [PATCH 11/13] ARM: bL_switcher: veto CPU hotplug requests when
 the switcher is active
In-Reply-To: <20130731103025.GC6583@e102568-lin.cambridge.arm.com>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-12-git-send-email-nicolas.pitre@linaro.org>
 <20130731103025.GC6583@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1308050014540.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, Lorenzo Pieralisi wrote:

> On Tue, Jul 23, 2013 at 04:31:27AM +0100, Nicolas Pitre wrote:
> > Trying to support both the switcher and CPU hotplug at the same time
> > is quickly becoming very complex due to ambiguous semantics.  So let's
> > simply veto any hotplug requests when the switcher is active for now.
> > 
> > This restriction might be loosened eventually.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  arch/arm/common/bL_switcher.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> > index 704c4b4ef3..2fe3911601 100644
> > --- a/arch/arm/common/bL_switcher.c
> > +++ b/arch/arm/common/bL_switcher.c
> > @@ -528,6 +528,25 @@ static int __init bL_switcher_sysfs_init(void)
> >  
> >  #endif  /* CONFIG_SYSFS */
> >  
> > +/*
> > + * Veto any CPU hotplug operation while the switcher is active.
> > + * We're just not ready to deal with that given the trickery involved.
> > + */
> > +static int bL_switcher_hotplug_callback(struct notifier_block *nfb,
> > +					unsigned long action, void *hcpu)
> > +{
> > +	switch (action) {
> > +	case CPU_UP_PREPARE:
> > +	case CPU_DOWN_PREPARE:
> > +		if (bL_switcher_active)
> > +			return NOTIFY_BAD;
> 
> This is a bit of a sledgehammer. It implies that S2R can't be implemented when
> the switcher is active. Are we really sure that hotplug, given MCPM HW
> CPUs awareness, is incompatible with the switcher as it stands ?
> 
> What are the main issues that have to be tackled ?

It's about semantics.  Let's say the switcher pairs CPU0 with CPU2 and 
CPU1 with CPU3, effectively keeping only logical CPUS 0 and 1 active.

Obviously, we must disallow hotplugging CPUs 2 and 3.

But what if CPU0 is removed, and then the switcher is disabled?  Should 
we bring up CPU2 or not?  What if right before the disabling of the 
switcher, logical CPU0 was switched to CPU2?  Etc.

So I decided that there is no right answer, and maybe we shouldn't care 
that much about those semantic issues around the runtime disabling of 
the switcher.

So I've replaced this patch with the following one:

----- >8
[PATCH] ARM: bL_switcher: filter CPU hotplug requests when the switcher is active

Trying to support both the switcher and CPU hotplug at the same time
is tricky due to ambiguous semantics.  So let's at least prevent users
from messing around with those logical CPUs the switcher has removed
and those which were not active when the switcher was activated.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 0e4fb3e5e9..335ff76d4c 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -554,6 +554,26 @@ static int __init bL_switcher_sysfs_init(void)
 
 #endif  /* CONFIG_SYSFS */
 
+/*
+ * Veto any CPU hotplug operation on those CPUs we've removed
+ * while the switcher is active.
+ * We're just not ready to deal with that given the trickery involved.
+ */
+static int bL_switcher_hotplug_callback(struct notifier_block *nfb,
+					unsigned long action, void *hcpu)
+{
+	if (bL_switcher_active) {
+		int pairing = bL_switcher_cpu_pairing[(unsigned long)hcpu];
+		switch (action & 0xf) {
+		case CPU_UP_PREPARE:
+		case CPU_DOWN_PREPARE:
+			if (pairing == -1)
+				return NOTIFY_BAD;
+		}
+	}
+	return NOTIFY_DONE;
+}
+
 static bool no_bL_switcher;
 core_param(no_bL_switcher, no_bL_switcher, bool, 0644);
 
@@ -566,6 +586,8 @@ static int __init bL_switcher_init(void)
 		return -EINVAL;
 	}
 
+	cpu_notifier(bL_switcher_hotplug_callback, 0);
+
 	if (!no_bL_switcher) {
 		ret = bL_switcher_enable();
 		if (ret)
