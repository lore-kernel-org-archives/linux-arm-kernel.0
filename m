From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 10 Jan 2018 11:52:47 +0100
Subject: [BUG] sleeping function called from invalid context in
 perf_pmu_register()
In-Reply-To: <20171229085904.GC18393@Red>
References: <20171229085904.GC18393@Red>
Message-ID: <20180110105247.GA25103@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 09:59:04AM +0100, Corentin Labbe wrote:

SNIP

> [    1.494884] Exception stack(0xee845fb0 to 0xee845ff8)
> [    1.499933] 5fa0:                                     00000000 00000000 00000000 00000000
> [    1.508100] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.516267] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    1.522871]  r5:c06c2528 r4:00000000
> 
> This is due to get_cpu() in cci_pmu_probe() in drivers/bus/arm-cci.c which disable preemption.
> But now I do not know how to fix it.
> My .config is below.

yep, looks like cci_pmu_probe needs to be fixed.. can't
call perf_pmu_register with preemption disabled

jirka
