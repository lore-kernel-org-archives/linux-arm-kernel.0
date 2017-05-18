From: ybzhao1989@gmail.com (Zhao Yibin)
Date: Thu, 18 May 2017 16:25:12 +0800
Subject: PROBLEM: ARM Cache policy on single armv7 processor lead to low
 DRAM performance
In-Reply-To: <20170516082922.GY22219@n2100.armlinux.org.uk>
References: <CAOEkoLw3Y5h2P_aFeMKgHYyKZpQvsQsOPOLOuvaYZGOe+rHJWQ@mail.gmail.com>
 <20170516082922.GY22219@n2100.armlinux.org.uk>
Message-ID: <CAOEkoLziLQ4z1L=wdMF_5tcm3ETbSwLm-tvreB6uSFxobE8gjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell,

I traced the page table of TTBR0,  and the map descriptor of the page
allocated from share ram,
TEX[0]-C-B is 0-1-1, LPAE is not enable, the TRE is 1, so TEX[0]-C-B
is mapped to the 3rd index of PRRR and NMRR.
PRRR register is 0xFF0A81A8, NMRR register is 0x40E040E0.
So the memory type is normal, and IR/OR is "Region is Write-Back, no
Write-Allocate." according to armv7 TRM

I don't know what read-allocate can be, if cortex-a7 is simliar to
cortex-a15, then write-back read-allocate means
"Write-Back Read-Allocate  => Write-Back Read-Write-Allocate",
according to this page:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0438c/BABJDDBC.html
Is my guess right?

I tried change the value of TTB_FLAGS_UP to  the same as TTB_FLAGS_SMP
in arch/arm/mm/proc-v7-2level.S.
but kernel fail to boot-up, fail in cgroup_init_early() called by
start_kernel().

Thanks
Bob

2017-05-16 16:29 GMT+08:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Tue, May 16, 2017 at 11:59:30AM +0800, Zhao Yibin wrote:
>> We met some DDR performance issue caused by armv7 cache policy, hope you
>> can help.
>> On a single armv7(Cortex-A7) processor system, the arm linux kernel,
>> without CONFIG_SMP, the cache policy is set to write-back no-allocate,
>
> It should be write-back read-allocate.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
