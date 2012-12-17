From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 17 Dec 2012 15:06:10 +0100
Subject: ARM realview breakages w/ 3.7 under qemu
In-Reply-To: <20121217134246.GE11558@mudshark.cambridge.arm.com>
References: <50CA0FC1.5090009@openwrt.org>
 <20121213174817.GB12946@mudshark.cambridge.arm.com>
 <20121214094012.GG14363@n2100.arm.linux.org.uk>
 <50CB0150.1000901@openwrt.org>
 <20121217134246.GE11558@mudshark.cambridge.arm.com>
Message-ID: <50CF26D2.1040008@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/17/12 14:42, Will Deacon a ?crit :
> On Fri, Dec 14, 2012 at 10:37:04AM +0000, Florian Fainelli wrote:
>> Le 12/14/12 10:40, Russell King - ARM Linux a ?crit :
>>> On Thu, Dec 13, 2012 at 05:48:17PM +0000, Will Deacon wrote:
>>>> On Thu, Dec 13, 2012 at 05:26:25PM +0000, Florian Fainelli wrote:
>>>>> - PBX A9: booting with less than 1024MBytes of RAM causes this:
>>>>> [    0.000000] Truncating RAM at 20000000-3fffffff to -3f7fffff (vmalloc
>>>>> region overlap).
>>>>> [    0.000000] Ignoring RAM at 80000000-8fffffff (vmalloc region overlap).
>>>>>
>>>>> Do these issues sounds familiar to any of you? The kernel config is
>>>>> attached in case that helps.
>>> I don't have the original email to reply to (so I don't have the .config
>>> either) but my guess for the above would be that HIGHMEM is disabled.
>> The original mail containing the .config file was actually rejected by
>> the mailing-list manager. I have uploaded it here:
>> http://alphacore.org/~florian/openwrt/realview-eb-config
>>
>> You are right, HIGHMEM is disabled. Even though enabling HIGHMEM does
>> not allow me booting either without at least 1Gbyte of RAM:
>>
>> [    0.000000] Memory policy: ECC disabled, Data cache writealloc
>> and we are stuck.
> I just dusted off my pbx and it boots fine with your .config and a 3.7
> kernel when passing mem=128M on the command line.
Ok, there must be something specific to qemu, can you also try with it?

>
> For EB, can you try the following diff please?

Works for me, thank you! I realized that I had this patch for 3.3 
already, but not in 3.7. This means that Realview EB has been broken 
since 3.3-rc and specifically commit 34ae6c96 (ARM: 7298/1: realview: 
fix mapping of MPCore private memory region).

>
> Will
>
> --->8
>
> diff --git a/arch/arm/mach-realview/include/mach/board-eb.h b/arch/arm/mach-realview/include/mach/board-eb.h
> index 124bce6..a301e61 100644
> --- a/arch/arm/mach-realview/include/mach/board-eb.h
> +++ b/arch/arm/mach-realview/include/mach/board-eb.h
> @@ -47,7 +47,7 @@
>   #define REALVIEW_EB_USB_BASE           0x4F000000      /* USB */
>   
>   #ifdef CONFIG_REALVIEW_EB_ARM11MP_REVB
> -#define REALVIEW_EB11MP_PRIV_MEM_BASE  0x1F000000
> +#define REALVIEW_EB11MP_PRIV_MEM_BASE  0x10100000
>   #define REALVIEW_EB11MP_L220_BASE      0x10102000      /* L220 registers */
>   #define REALVIEW_EB11MP_SYS_PLD_CTRL1  0xD8            /* Register offset for MPCore sysctl */
>   #else
