From: Bo.Liu@windriver.com (Tonyliu)
Date: Tue, 24 Nov 2009 10:45:37 +0800
Subject: Linux on ARM926EJ: Software reset problems
In-Reply-To: <56948FFAC219492B8923C0852A8AC413@teltronic.es>
References: <56948FFAC219492B8923C0852A8AC413@teltronic.es>
Message-ID: <4B0B48D1.8080809@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ricardo Mart?nez wrote:
> Hi!
>  
> I'm trying to soft reset an ARM926EJ.
>  
> I'm using
>     cpu_arm926_reset(ulong address) function which:
>            - flushes I/D caches
>             - jumps to "address", whose value in my case is NOR flash 
> base addres where U-Boot stays (after remapping).
>  
>     But it sometimes work, but most times hangs. Can this be caused by 
> MMU not being switched off?
Probably yes but not exactly.  After reset by hardware signal generated 
by Watchdog or something else, all SoC modules are in default
certain state besides ARM core, but in your case, it's not sure.

>  
> Any other hints?
>  
> If you think it might be caused by MMU, how can MMU be disabled?
use "MCR p15, 0, Rd, c1, c0, 0" to write CP15 register 1 for MMU 
enable/disable.

>  
> Is there any other prefered method to soft reboot ARM926 from Linux? 
> I've taken a look at some PXA, OMAP & AT91 code about soft rebooting. 
> It seems they use Watchdog timer to reset, but my CPU does not have a 
> watchdog.
You can try cpu_reset(addr), refer to cpu_arm926_reset() in 
arch/arm/mm/proc-arm926.S.

Tony
>  
> Thanks in advance,
> Ricardo Martinez
>  
>  
> ------------------------------------------------------------------------
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>   


-- 
Tony Liu | Liu Bo
-------------------------------------------------------------
WIND RIVER | China Development Center
Tel: 86-10-8477-8542 ext: 8542 |  Fax: 86-10-64790367
(M): 86-136-7117-3612
Address: 15/F, Wangjing TowerB, Chaoyang District, Beijing, P.R.China
