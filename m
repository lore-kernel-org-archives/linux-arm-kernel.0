From: panand@redhat.com (Pratyush Anand)
Date: Thu, 9 Jul 2015 19:23:35 +0530
Subject: [PATCH 1/2] arm64: Blacklist non-kprobe-able symbols
In-Reply-To: <20150706114920.GB17305@dhcppc13.redhat.com>
References: <cover.1436158027.git.panand@redhat.com>
 <9994841a0b0a8194a6dcc1b6af148ba358488c62.1436158027.git.panand@redhat.com>
 <559A6257.60608@hitachi.com>
 <20150706114920.GB17305@dhcppc13.redhat.com>
Message-ID: <20150709135335.GC16331@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2015:05:19:20 PM, Pratyush Anand wrote:
> On 06/07/2015:08:11:19 PM, Masami Hiramatsu wrote:
> > On 2015/07/06 14:03, Pratyush Anand wrote:
> > > Add all function symbols which are called from do_debug_exception under
> > > NOKPROBE_SYMBOL, as they can not kprobed.
> > 
> > Could you tell me how you checked that? from the code?
> 
> Well.. I found out that some of the symbol like single_step_handler
> does not allow kprobing, and then it seemed logical to me that we
> should not allow kprobing of any symbols which are called in the path
> of do_debug_exception. So, manually :( I reviewed the code and put
> NOKPROBE_SYMBOL across all those.
> 
> However, now I am doing some more tests  and as I said in previous
> reply, there are still few symbols like (_mcount) which is creating
> problem with following simple test and I need to look into that. In
> case of _mcount, I do not see any print and its complete freeze.
> 

Once these two patches are applied, I do not see any issue (at least)
in enabling kprobes for all the symbols of /proc/kallsyms, except
_mcount. Blacklisting _mcount seems reasonable to me, as this is
called from every function and so from do_debug_exception as well.

There might still be some path which can create issue if a kprobe is
inserted there, but I do not see any way to find them. So,
I will send V2 with following updates.Please let me know if there is
any other concern.

--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -26,6 +26,7 @@
#include <linux/syscalls.h>
#include <linux/uaccess.h>
#include <linux/io.h>
+#include <linux/kprobes.h>
    
#include <asm/checksum.h>
      
@@ -64,4 +65,5 @@ EXPORT_SYMBOL(test_and_change_bit);
       
#ifdef CONFIG_FUNCTION_TRACER
EXPORT_SYMBOL(_mcount);
+NOKPROBE_SYMBOL(_mcount);
#endif

~Pratyush

PS:
Some related details are here:
http://marc.info/?l=linux-kernel&m=143644472722751
