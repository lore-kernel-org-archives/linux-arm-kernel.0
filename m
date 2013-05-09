From: horms@verge.net.au (Simon Horman)
Date: Thu, 9 May 2013 12:44:11 +0900
Subject: [PATCH] irqchip: Add irqchip_init dummy function
In-Reply-To: <518A9EBA.6070609@cogentembedded.com>
References: <1368019204-24448-1-git-send-email-hechtb+renesas@gmail.com>
 <518A6C05.9030303@cogentembedded.com>
 <201305081833.03716.arnd@arndb.de>
 <518A9EBA.6070609@cogentembedded.com>
Message-ID: <20130509034410.GD13994@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 10:51:38PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/08/2013 08:33 PM, Arnd Bergmann wrote:
> 
> >
> >>>--- a/include/linux/irqchip.h
> >>>+++ b/include/linux/irqchip.h
> >>>@@ -11,6 +11,10 @@
> >>>   #ifndef _LINUX_IRQCHIP_H
> >>>   #define _LINUX_IRQCHIP_H
> >>>
> >>>+#ifdef CONFIG_IRQCHIP
> >>>   void irqchip_init(void);
> >>>+#else
> >>>+void irqchip_init(void) {};
> >>     Semicolon not needed here.
> >>
> >>>+#endif
> >More importantly, the function should be marked as "static inline", otherwise
> >you get a link error if this header is included in more than one place.
> 
>     Right, I should have noticed that too. :-)
> 
> >	Arnd

Thanks, I will queue-up the following in the intc-external-irq branch.


From: Bastian Hecht <hechtb@gmail.com>

irqchip: Add irqchip_init dummy function

We add an empty irqchip_init dummy function for cases in which
CONFIG_IRQCHIP is not used. In these cases irqchip.c is not compiled,
but a funtion call may still be present in architecture code, that in
runtime doesn't get hit.

E.g. this is needed in the arch/arm/mach-shmobile/intc-r8a7740.c
interrupt setup code where OF use and non OF us is both handled in one
file.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
[horms+renesas at verge.net.au: Make non-CONFIG_IRQCHIP version static inline
and remove trailing ';'.]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index e0006f1..14d7913 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -11,6 +11,10 @@
 #ifndef _LINUX_IRQCHIP_H
 #define _LINUX_IRQCHIP_H
 
+#ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
+#else
+static inline void irqchip_init(void) {}
+#endif
 
 #endif
