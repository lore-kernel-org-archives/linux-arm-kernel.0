From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 9 May 2013 15:01:21 -0700
Subject: [PATCH -v8 01/11] CPU hotplug: Provide a generic helper to
 disable/enable CPU hotplug
In-Reply-To: <1367937595-32241-2-git-send-email-holt@sgi.com>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
 <1367937595-32241-2-git-send-email-holt@sgi.com>
Message-ID: <20130509150121.8c3ef60b2fc748ce542a1a52@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 May 2013 09:39:45 -0500 Robin Holt <holt@sgi.com> wrote:

> From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> 
> There are instances in the kernel where we would like to disable
> CPU hotplug (from sysfs) during some important operation. Today
> the freezer code depends on this and the code to do it was kinda
> tailor-made for that.
> 
> Restructure the code and make it generic enough to be useful for
> other usecases too.
> 
> ...
>
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -141,6 +141,8 @@ static inline void unregister_cpu_notifier(struct notifier_block *nb)
>  }
>  #endif
>  
> +extern void cpu_hotplug_disable(void);
> +extern void cpu_hotplug_enable(void);
>  int cpu_up(unsigned int cpu);
>  void notify_cpu_starting(unsigned int cpu);
>  extern void cpu_maps_update_begin(void);
> @@ -148,6 +150,7 @@ extern void cpu_maps_update_done(void);
>  
>  #else	/* CONFIG_SMP */
>  
> +#define cpu_hotplug_disable()	do { } while (0)
>  #define cpu_notifier(fn, pri)	do { (void)(fn); } while (0)
>  

Breaks alpha allmodconfig because cpu_hotplug_disable() is absent from
vmlinux.

cpu_hotplug_disable() doesn't get compiled unless we've defined
CONFIG_PM_SLEEP_SMP.  I cannot begin to imagine what the logic is
behind that!

I'll stick this in there and see what happens.

--- a/include/linux/cpu.h~cpu-hotplug-provide-a-generic-helper-to-disable-enable-cpu-hotplug-fix
+++ a/include/linux/cpu.h
@@ -141,8 +141,6 @@ static inline void unregister_cpu_notifi
 }
 #endif
 
-extern void cpu_hotplug_disable(void);
-extern void cpu_hotplug_enable(void);
 int cpu_up(unsigned int cpu);
 void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
@@ -150,7 +148,6 @@ extern void cpu_maps_update_done(void);
 
 #else	/* CONFIG_SMP */
 
-#define cpu_hotplug_disable()	do { } while (0)
 #define cpu_notifier(fn, pri)	do { (void)(fn); } while (0)
 
 static inline int register_cpu_notifier(struct notifier_block *nb)
@@ -171,6 +168,15 @@ static inline void cpu_maps_update_done(
 }
 
 #endif /* CONFIG_SMP */
+
+#ifdef CONFIG_PM_SLEEP_SMP
+extern void cpu_hotplug_enable(void);
+extern void cpu_hotplug_disable(void);
+#else
+#define cpu_hotplug_enable()	do { } while (0)
+#define cpu_hotplug_disable()	do { } while (0)
+#endif
+
 extern struct bus_type cpu_subsys;
 
 #ifdef CONFIG_HOTPLUG_CPU
