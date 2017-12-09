From: jolsa@redhat.com (Jiri Olsa)
Date: Sat, 9 Dec 2017 08:26:23 +0100
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <df2f2547-85b3-b522-4021-a2aa84333559@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133752.GB12508@krava>
 <f58001e9-86fa-c6e6-b9c7-fb748d340da1@huawei.com>
 <20171208123137.GF2799@krava>
 <df2f2547-85b3-b522-4021-a2aa84333559@huawei.com>
Message-ID: <20171209072623.GA14297@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 03:38:06PM +0000, John Garry wrote:

SNIP

> > > 
> > > Hi jirka,
> > > 
> 
> Hi jirka,
> 
> > > The linux kernel headers are not used for jevents tool. I would rather use
> > > them if possible...
> > 
> > should be as easy as adding  #include <linux/list.h> ;-)
> > 
> 
> Hi jirka,
> 
> I think the issue is that jevents is a "hostprogs", which does not use
> kernel headers.
> 
> FWIW, here is the symptom:
> pmu-events/jevents.c:51:24: fatal error: linux/list.h: No such file or
> directory
>  #include <linux/list.h>
>                         ^
> compilation terminated.
> mv: cannot stat ?pmu-events/.jevents.o.tmp?: No such file or directory
> 
> perf tool build is different.

yep, need additional in Bukld file, attached

jirka


---
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 999a4e878162..b7d2e0e9cbd0 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,5 +1,6 @@
 hostprogs := jevents
 
+CHOSTFLAGS      = -I$(srctree)/tools/include
 jevents-y	+= json.o jsmn.o jevents.o
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b578aa26e375..5b9b1fee3dfe 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -47,6 +47,7 @@
 #include "jsmn.h"
 #include "json.h"
 #include "jevents.h"
+#include <linux/list.h>
 
 int verbose;
 char *prog;
@@ -884,6 +885,7 @@ int main(int argc, char *argv[])
 	const char *output_file;
 	const char *start_dirname;
 	struct stat stbuf;
+	struct list_head krava __maybe_unused;
 
 	prog = basename(argv[0]);
 	if (argc < 4) {
