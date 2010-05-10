From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Mon, 10 May 2010 15:55:49 +0300
Subject: [PATCHv4 1/4] procfs: Introduce socinfo under /proc
In-Reply-To: <20100510123902.GA15293@linux-sh.org>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com>
	<20100510111259.GA14680@linux-sh.org>
	<20100510123514.GA11804@besouro.research.nokia.com>
	<20100510123902.GA15293@linux-sh.org>
Message-ID: <20100510125548.GB11804@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 02:39:02PM +0200, ext Paul Mundt wrote:
> On Mon, May 10, 2010 at 03:35:14PM +0300, Eduardo Valentin wrote:
> > On Mon, May 10, 2010 at 01:13:00PM +0200, ext Paul Mundt wrote:
> > > On Mon, May 10, 2010 at 01:37:34PM +0300, Eduardo Valentin wrote:
> > > > + */
> > > > +#include <linux/fs.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/proc_fs.h>
> > > > +#include <linux/seq_file.h>
> > > > +
> > > > +extern const struct seq_operations socinfo_op;
> > > 
> > > This doesn't look promising..
> > 
> > Right.. as stated in patch description (maybe not that clear), this was
> > basically same thing which you see under fs/proc/cpuinfo.c
> > 
> The cpuinfo case is a bit more complex since you have actual real work to
> do in the ->start op and you will iterate over the ->show op for each
> CPU. In your socinfo case you're just following the single_xxx()
> semantics so using those helpers there simplifies things quite a bit.

Yeah,

> 
> Architectures that do not support SMP technically employ single_open()
> semantics, but the fs/proc/cpuinfo.c abstraction requires the
> architecture to provide seq ops regardless.

OK.

> 
> Note that in the cpuinfo case there is often special handling for the
> single (or boot CPU) case, such as printing out a descriptor for the
> machine type and so on. You might be better off just extending cpuinfo
> rather than introducing another /proc abstraction, presumably your
> socinfo string will be fixed regardless of whether it's SMP or not.

Yeah, I wouldn't expect it to change if it SMP or not. It should be fixed.
Previous version of this change was actually extending ARM cpuinfo. The previous
thread starts here:
http://marc.info/?l=linux-omap&m=127304890312365&w=2

But, the point of moving that to specific file was that soc info is not really cpu info.


BR,

--
Eduardo Valentin
