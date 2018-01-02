From: ak@linux.intel.com (Andi Kleen)
Date: Tue, 2 Jan 2018 09:48:14 -0800
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <edd01090-755e-fd73-434b-b910272c625a@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133607.GA12508@krava>
 <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
 <20171208122918.GE2799@krava>
 <afd7bf2a-4d94-0db0-640d-b1c93c8ba230@huawei.com>
 <20171209073104.GB14297@krava>
 <5d322353-2785-a99f-bcd8-b948bd6cb09a@huawei.com>
 <20171216184701.GB25156@tassilo.jf.intel.com>
 <edd01090-755e-fd73-434b-b910272c625a@huawei.com>
Message-ID: <20180102174814.GT25156@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Can you describe how you autogenerate the JSONs? Do you have some internal
> proprietary HW file format describing events, with files supplied from HW
> designer, which you can just translate into a JSON? Would the files support
> deferencing events to improve scalability?

For Intel JSON is an official format, which is maintained for each CPU.
It is automatically generated from an internal database
https://download.01.org/perfmon/

I have some python scripts to convert these Intel JSONs into the perf
format (which has some additional headers, and is split into
different categories, and add metrics).  

They have some Intel specifics, so may not be useful for you. 

There's no support for dereference, each CPU gets its own unique file.

But you could do the a merge simply with the attached script which merges
two JSON files. 

-Andi
-------------- next part --------------
#!/usr/bin/python
# merge json event files
# merge-json file1.json file2... > merged.json
import sys
import json

all = []

for fn in sys.argv[1:]:
    jf = json.load(open(fn))
    for n in jf:
	all.append(n)

print json.dumps(all, sort_keys=True, indent=4, separators=(',', ': '))
