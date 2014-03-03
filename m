From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 3 Mar 2014 16:00:59 +0800
Subject: change kmalloc into vmalloc for large memory allocations
In-Reply-To: <20140303030821.GA16732@kroah.com>
References: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
 <53104ECA.4010702@freescale.com>
 <35FD53F367049845BC99AC72306C23D102844605F38D@CNBJMBX05.corpusers.net>
 <20140228163304.GA15614@kroah.com>
 <35FD53F367049845BC99AC72306C23D102844605F38F@CNBJMBX05.corpusers.net>
 <20140303030821.GA16732@kroah.com>
Message-ID: <35FD53F367049845BC99AC72306C23D102844605F390@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  greg,

For 
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/input/evdev.c?h=master#n403

there have been a patch for kmalloc failed ,

for 
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/sound/soc/soc-core.c?h=master#n3772

I have not change it , need some more code to change in devm_kzalloc ..

I make a patch for netfilter part :

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_ftp.c?h=master#n603
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_h323_main.c?h=master#n1849
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_irc.c?h=master#n247
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_sane.c?h=master#n195

seems work well ,
these module will allocate 64KB large memory,
is it possible to be merged ?

Thanks 

-- >8 --
diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index b8a0924..0e92b0d 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -14,7 +14,7 @@
 #include <linux/moduleparam.h>
 #include <linux/netfilter.h>
 #include <linux/ip.h>
-#include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/ipv6.h>
 #include <linux/ctype.h>
 #include <linux/inet.h>
@@ -593,14 +593,14 @@ static void nf_conntrack_ftp_fini(void)
 		}
 	}
 
-	kfree(ftp_buffer);
+	vfree(ftp_buffer);
 }
 
 static int __init nf_conntrack_ftp_init(void)
 {
 	int i, j = -1, ret = 0;
 
-	ftp_buffer = kmalloc(65536, GFP_KERNEL);
+	ftp_buffer = vmalloc(65536, GFP_KERNEL);
 	if (!ftp_buffer)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index 70866d1..49ae092 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -18,7 +18,7 @@
 #include <linux/inet.h>
 #include <linux/in.h>
 #include <linux/ip.h>
-#include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
 #include <linux/skbuff.h>
@@ -1837,7 +1837,7 @@ static void __exit nf_conntrack_h323_fini(void)
 	nf_conntrack_helper_unregister(&nf_conntrack_helper_q931[1]);
 	nf_conntrack_helper_unregister(&nf_conntrack_helper_q931[0]);
 	nf_conntrack_helper_unregister(&nf_conntrack_helper_h245);
-	kfree(h323_buffer);
+	vfree(h323_buffer);
 	pr_debug("nf_ct_h323: fini\n");
 }
 
@@ -1846,7 +1846,7 @@ static int __init nf_conntrack_h323_init(void)
 {
 	int ret;
 
-	h323_buffer = kmalloc(65536, GFP_KERNEL);
+	h323_buffer = vmalloc(65536, GFP_KERNEL);
 	if (!h323_buffer)
 		return -ENOMEM;
 	ret = nf_conntrack_helper_register(&nf_conntrack_helper_h245);
@@ -1876,7 +1876,7 @@ err3:
 err2:
 	nf_conntrack_helper_unregister(&nf_conntrack_helper_h245);
 err1:
-	kfree(h323_buffer);
+	vfree(h323_buffer);
 	return ret;
 }
 
diff --git a/net/netfilter/nf_conntrack_irc.c b/net/netfilter/nf_conntrack_irc.c
index 0fd2976..b57df10 100644
--- a/net/netfilter/nf_conntrack_irc.c
+++ b/net/netfilter/nf_conntrack_irc.c
@@ -16,7 +16,7 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/netfilter.h>
-#include <linux/slab.h>
+#include <linux/vmalloc.h>
 
 #include <net/netfilter/nf_conntrack.h>
 #include <net/netfilter/nf_conntrack_expect.h>
@@ -244,7 +244,7 @@ static int __init nf_conntrack_irc_init(void)
 	irc_exp_policy.max_expected = max_dcc_channels;
 	irc_exp_policy.timeout = dcc_timeout;
 
-	irc_buffer = kmalloc(65536, GFP_KERNEL);
+	irc_buffer = vmalloc(65536);
 	if (!irc_buffer)
 		return -ENOMEM;
 
@@ -285,7 +285,7 @@ static void nf_conntrack_irc_fini(void)
 
 	for (i = 0; i < ports_c; i++)
 		nf_conntrack_helper_unregister(&irc[i]);
-	kfree(irc_buffer);
+	vfree(irc_buffer);
 }
 
 module_init(nf_conntrack_irc_init);
diff --git a/net/netfilter/nf_conntrack_sane.c b/net/netfilter/nf_conntrack_sane.c
index 4a2134f..a4c8bf3 100644
--- a/net/netfilter/nf_conntrack_sane.c
+++ b/net/netfilter/nf_conntrack_sane.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/netfilter.h>
-#include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/in.h>
 #include <linux/tcp.h>
 #include <net/netfilter/nf_conntrack.h>
@@ -185,14 +185,14 @@ static void nf_conntrack_sane_fini(void)
 		}
 	}
 
-	kfree(sane_buffer);
+	vfree(sane_buffer);
 }
 
 static int __init nf_conntrack_sane_init(void)
 {
 	int i, j = -1, ret = 0;
 
-	sane_buffer = kmalloc(65536, GFP_KERNEL);
+	sane_buffer = vmalloc(65536);
 	if (!sane_buffer)
 		return -ENOMEM;



-----Original Message-----
From: 'gregkh@linuxfoundation.org' [mailto:gregkh at linuxfoundation.org] 
Sent: Monday, March 03, 2014 11:08 AM
To: Wang, Yalin
Cc: 'Huang Shijie'; 'linux-kernel at vger.kernel.org'; 'linux-arm-msm at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-input at vger.kernel.org'; 'balbi at ti.com'; 'lrg at ti.com'; 'broonie at opensource.wolfsonmicro.com'; 'perex at perex.cz'; 'tiwai at suse.de'; 'pablo at netfilter.org'; 'kaber at trash.net'; 'davem at davemloft.net'; 'rostedt at goodmis.org'; 'fweisbec at gmail.com'; 'mingo at redhat.com'; 'dmitry.torokhov at gmail.com'; 'rydberg at euromail.se'; 'linux-usb at vger.kernel.org'; 'alsa-devel at alsa-project.org'; 'netfilter-devel at vger.kernel.org'; 'netfilter at vger.kernel.org'; 'coreteam at netfilter.org'; 'netdev at vger.kernel.org'
Subject: Re: change kmalloc into vmalloc for large memory allocations

On Mon, Mar 03, 2014 at 10:51:23AM +0800, Wang, Yalin wrote:
> Hi  greg,
> 
> I am sorry,
> I make a mistake ,
> You are right ,
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drive
> rs/usb/gadget/f_mass_storage.c?h=master#n2724
> 
> this one should not changed to use vmalloc, the buffer will be used by 
> DMA?

Which is why a wrapper function will never work.

> others should be safe to change:
> 
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/sound
> /soc/soc-core.c?h=master#n3772
> 
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/n
> etfilter/nf_conntrack_ftp.c?h=master#n603
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/n
> etfilter/nf_conntrack_h323_main.c?h=master#n1849
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/n
> etfilter/nf_conntrack_irc.c?h=master#n247
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/n
> etfilter/nf_conntrack_sane.c?h=master#n195
> 
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drive
> rs/input/evdev.c?h=master#n403

Then send individual patches for these and see what happens.

greg k-h
