From: james.morse@arm.com (James Morse)
Date: Mon, 14 May 2018 16:12:08 +0100
Subject: [PATCH] ghes_edac: enable HIP08 platform edac driver
In-Reply-To: <20180514094709.GC23049@pd.tnic>
References: <1526039543-180996-1-git-send-email-zhengqiang10@huawei.com>
 <20180511121901.GA12705@pd.tnic> <5AF90C70.408@huawei.com>
 <20180514094709.GC23049@pd.tnic>
Message-ID: <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

(CC: +linux-arm list, just in case there is wider discussion)

On 14/05/18 10:47, Borislav Petkov wrote:
> On Mon, May 14, 2018 at 12:11:28PM +0800, Zhengqiang wrote:
>> In ARM64 defconfig, ghes_edac is default load. memory error report to
>> user space rasdaemon tool through function ghes_edac_report_mem_error,
>> we need it.
> 
> So depending on whether there will be an ARM64 edac driver, we can do

I'm afraid there could be a mix: The v8.2 CPU RAS Extensions mean the kernel can
do kernel first. (I agree for those systems there should only be one edac driver).
For systems without the v8.2 CPU RAS Extensions firmware-first is the only way
of doing it.


> the platform whitelisting on x86 only if ARM prefers to do the reporting
> through ghes_edac. James?

I'm afraid I'd like to keep both doors open. Kernel-first handling will require
some ACPI-table/DT property as some aspects of the CPU extensions aren't
discover-able. Can't we use this to pick up whether the platform supports
firmware-first (HEST and GHES entries) or kernel-first via some as-yet-undefined
HEST bits?

Without GHES entries this code would never be run. So we 'just' need to catch
systems that are describing both. (which can be the platform specific kernel
first bits problem to do)


Thanks,

James
