From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Jan 2015 13:22:59 -0200
Subject: using DMA-API on ARM
In-Reply-To: <20141209102904.GJ11285@n2100.arm.linux.org.uk>
References: <5481794E.4050406@broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01901765@SJEXCHMB15.corp.ad.broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01902076@SJEXCHMB15.corp.ad.broadcom.com>
 <2863746.4sUSEYqahB@wuerfel>
 <20141208160316.GM16185@e104818-lin.cambridge.arm.com>
 <5485D97D.1040404@broadcom.com> <5486CCBC.3@broadcom.com>
 <20141209102904.GJ11285@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5ADUvWPYVJhKtou-jDrRiiobZ5e=w+FiTX7-Lv+OvbkwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Dec 9, 2014 at 8:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 09, 2014 at 11:19:40AM +0100, Arend van Spriel wrote:
>> The issue did not trigger overnight so it seems setting bit 22 <Shared
>> Attribute _Override_ Enable> solves the issue over here. Now the question is
>> how to move forward with this. As I understood from Catalin this patch was
>> not included as it was not considered responsibility of the linux kernel.
>
> It is preferable for firmware to configure the L2 cache appropriately,
> which includes things like the prefetch offsets as well as feature bits
> like bit 22.
>
> I think what I'll do is queue up a patch which adds a warning if bit 22
> is not set, suggesting that firmware is updated to set this bit.

Do you mean something like this?

--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -943,6 +943,10 @@ static int __init __l2c_init(const struct
l2c_init_data *data,
     pr_info("%s: CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",
         data->type, cache_id, aux);

+    if (!(aux & L2C_AUX_CTRL_SHARED_OVERRIDE))
+        pr_warn("%s: L2C_AUX_CTRL_SHARED_OVERRIDE needs to be set by
the bootloader\n",
+            data->type);
+
     return 0;
 }
