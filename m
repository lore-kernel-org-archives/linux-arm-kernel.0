From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 16 Feb 2012 14:52:19 -0800
Subject: [PATCH v5 00/27] irq_domain generalization and rework
In-Reply-To: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
Message-ID: <20120216145219.0f1c1b98.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Feb 2012 02:09:01 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> 
> This series generalizes the "irq_host" infrastructure from powerpc
> so that it can be used by all architectures and renames it to "irq_domain".

drivers/mfd/twl-core.c is fairly horked on i386 allmodconfig:

drivers/mfd/twl-core.c: In function 'twl_probe':
drivers/mfd/twl-core.c:1218: error: implicit declaration of function 'irq_alloc_descs'
drivers/mfd/twl-core.c:1226: error: implicit declaration of function 'irq_domain_add_legacy'
drivers/mfd/twl-core.c:1227: error: 'irq_domain_simple_ops' undeclared (first use in this function)
drivers/mfd/twl-core.c:1227: error: (Each undeclared identifier is reported only once
drivers/mfd/twl-core.c:1227: error: for each function it appears in.)


This is today's linux-next so it has rmk's "ARM: omap: fix broken
twl-core dependencies and ifdefs" in there, which looks like it
attempts to repair this stuff.

It's looking for things which are in both linux/irq.h and in
linux/irqdomain.h.



btw, Russell, regarding this comment in include/linux/irq.h:

/*
 * Please do not include this file in generic code.  There is currently
 * no requirement for any architecture to implement anything held
 * within this file.
 *
 * Thanks. --rmk
 */

A quick grep indicates that we've lost this battle ;) Is the comments
still true?  Should we stop discouraging inclusion of linux/irq.h? 
Does anyone even know that it's discouraged ;)
