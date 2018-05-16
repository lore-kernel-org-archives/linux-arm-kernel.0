From: james.morse@arm.com (James Morse)
Date: Wed, 16 May 2018 14:38:38 +0100
Subject: [PATCH] ghes_edac: enable HIP08 platform edac driver
In-Reply-To: <20180514164720.GH23049@pd.tnic>
References: <1526039543-180996-1-git-send-email-zhengqiang10@huawei.com>
 <20180511121901.GA12705@pd.tnic> <5AF90C70.408@huawei.com>
 <20180514094709.GC23049@pd.tnic>
 <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
 <20180514164720.GH23049@pd.tnic>
Message-ID: <da776696-ddbf-c35e-1dd4-b6e0ce91aed6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav, Zhengqiang

On 14/05/18 17:47, Borislav Petkov wrote:
> On Mon, May 14, 2018 at 04:12:08PM +0100, James Morse wrote:
>> I'm afraid I'd like to keep both doors open. Kernel-first handling will require
>> some ACPI-table/DT property as some aspects of the CPU extensions aren't
>> discover-able. Can't we use this to pick up whether the platform supports
>> firmware-first (HEST and GHES entries) or kernel-first via some as-yet-undefined
>> HEST bits?
> 
> So how you detect those platforms is largely undefined as we're walking
> new grounds here with the FF crap on the one hand and platform-specific
> drivers on the other. So whatever works for you and as long as the
> ugliness is nicely hidden. :-)

>> Without GHES entries this code would never be run. So we 'just' need to catch
>> systems that are describing both. (which can be the platform specific kernel
>> first bits problem to do)
> 
> So the reason why we're doing this on x86 is that the majority of
> GHES-advertizing platforms out there are a serious turd when it comes
> to functioning fw.
> 
> So we've opted for known-good platforms list where there's backing from
> the vendor to have firmware which is getting fixes and is being tested
> properly.

Okay, so the question is whether we need a white/blacklist. The two older
platforms that describes GHES in their HEST tables are AMD-Seattle and APM-XGene.

XGene has its own edac driver, but it doesn't probe when booted via ACPI so
won't conflict with ghes_edac. On XGene:
|  ghes_edac: GOT 2 DIMMS
| EDAC MC0: Giving out device to module ghes_edac.c controller ghes_edac: DEV
ghes (INTERRUPT)

On Seattle:
[    6.119586] ghes_edac: GOT 4 DIMMS
[    6.127294] EDAC MC0: Giving out device to module ghes_edac.c controller ghes
_edac: DEV ghes (INTERRUPT)

The thing has 4 dimm slots, but only two are populated. I swapped them round and
the table was regenerated, so I don't think its faking it.


So I think we're good to make the whitelist x86 only.
Your diff-hunk makes 'idx=-1', so we always get the 'Unfortunately' warning. I'd
like to suppress this unless force_load has been used.


> Anyway, this is the story in x86 land. JFYI guys in case it helps making
> some decisions.

Thanks!

What is the history behind the fake thing here? It predates 32fa1f53c2d
"ghes_edac: do a better job of filling EDAC DIMM info", was it to support a
valid system, or just to ease merging the driver when not all systems had the
dmi table?

It looks like even the oldest Arm64 ACPI systems have dmi tables, so we can
probably require DMI or the 'force' flag.


Thanks,

James
