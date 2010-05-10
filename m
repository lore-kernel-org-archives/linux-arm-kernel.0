From: lethal@linux-sh.org (Paul Mundt)
Date: Mon, 10 May 2010 20:13:00 +0900
Subject: [PATCHv4 1/4] procfs: Introduce socinfo under /proc
In-Reply-To: <1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com>
Message-ID: <20100510111259.GA14680@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 01:37:34PM +0300, Eduardo Valentin wrote:
> + */
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
> +
> +extern const struct seq_operations socinfo_op;

This doesn't look promising..

> +static int socinfo_open(struct inode *inode, struct file *file)
> +{
> +	return seq_open(file, &socinfo_op);
> +}
> +
If you use single_open() ..

> +static const struct file_operations proc_socinfo_operations = {
> +	.open		= socinfo_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= seq_release,
> +};
> +
.. and single_release(), then none of the seq_operations are necessary.

> +static int __init proc_socinfo_init(void)
> +{
> +	proc_create("socinfo", 0, NULL, &proc_socinfo_operations);
> +	return 0;
> +}
> +module_init(proc_socinfo_init);

proc_create() can fail, so some error handling here would be nice.

On Mon, May 10, 2010 at 01:37:35PM +0300, Eduardo Valentin wrote:
> +static int c_show(struct seq_file *m, void *v)
> +{
> +	seq_printf(m, "SoC\t: %s\n", socinfo);
> +
> +	return 0;
> +}
> +
> +static void *c_start(struct seq_file *m, loff_t *pos)
> +{
> +	return *pos < 1 ? (void *)1 : NULL;
> +}
> +
> +static void *c_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	++*pos;
> +	return NULL;
> +}
> +
> +static void c_stop(struct seq_file *m, void *v)
> +{
> +}
> +
> +const struct seq_operations socinfo_op = {
> +	.start	= c_start,
> +	.next	= c_next,
> +	.stop	= c_stop,
> +	.show	= c_show
> +};

You'll still need the show function, but all of the rest of this is just
duplicating what single_open() already does. If the socinfo string is
static you may also want to rework this a bit so you can just stash the
string in the proc_dir_entry private data. Combine this with something
like kstrdup() and you'll save yourself a bit of stack while you're at
it.
