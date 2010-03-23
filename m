From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 24 Mar 2010 09:30:05 +1300
Subject: [PATCH 0/2] arm: add a /proc/cpuinfo platform extension
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F377@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F377@mi8nycmail19.Mi8.com>
Message-ID: <4BA924CD.1010201@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Add an optional platform specific extension to /proc/cpuinfo.
> 
> Many platforms have custom cpu information that could be exposed
> to user space using /proc/cpuinfo.
> 
> Patch 1/2 adds the necessary core support to allow a platform
> specific callback to dump this information.
> 
> Patch 2/2 adds a callback to mach-ep93xx and hooks up all the
> edb93xx platforms.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

I think this is unlikely to get merged in its current state. Russell has
mentioned issues with breaking userspace by changing /proc/cpuinfo. The
other problem I see is that you have a single callback for registering
the arch specific information. In you ep93xx example, each of the ep93xx
boards must add:

  .arch_cpuinfo = ep93xx_cpuinfo,

If one of the boards has some additional information to make available,
it would need to reimplement the entire callback, which gets messy.

I think a better approach would be to have a separate file (say
/proc/archinfo) and use a list approach for displaying data. I'm
guessing that the data displayed in the archinfo file would be
immutable, so something like this (very rough, this would be
kernel/archinfo.c, or arch/arm/kernel/archinfo.c, or whatever):

struct archinfo_entry {
	const char 		*name;
	const char 		*value;
	struct list_head 	list;
};

static LIST_HEAD(archinfo_entries);

int archinfo_add_entry(const char *name, const char *value)
{
	struct archinfo_entry *entry;

	entry = kzalloc(sizeof(struct archinfo_entry), GFP_KERNEL);
	if (!entry)
		return -ENOMEM;

	entry->name = kzalloc(strlen(name) + 1), GFP_KERNEL);
	if (!entry->name) {
		kfree(entry);
		return -ENOMEM;
	}
	strcpy(entry->name, name);
		
	entry->value = kzalloc(strlen(value) + 1, GFP_KERNEL);
	if (!entry->value) {
		kfree(entry->name);
		kfree(entry);
		return -ENOMEM;
	}

	list_add(&entry->list, &archinfo_entries);
	return 0;	
}

static int archinfo_show(struct seq_file *s, void *v)
{
	struct archinfo_entry *entry;

	list_for_each_entry(entry, &archinfo_entries, list)
		seq_printf(s, "%-20s: %s\n", entry->name, entry->value);

	return 0;
}

static int archinfo_open(struct inode *inode, struct file *file)
{
	return single_open(file, archinfo_show, NULL);
}

static const struct file_operations archinfo_ops = {
	.open		= archinfo_open,
	.read		= seq_read,
	.llseek		= seq_lseek,
	.release	= single_release,
};

static int __init init_archinfo(void)
{
	struct proc_dir_entry *proc;

	if (list_empty(&archinfo_entries))
		return 0;

	proc = proc_create("archinfo", 0444, NULL, &archinfo_ops);
	if (!proc)
		return -ENOMEM;
	return 0;
}

lateinit_call(init_archinfo);

A given board/arch can then have something like the following in its
init function:

static void __init myboard_init_archinfo(void)
{
	char buffer[64];

	snprintf(buffer, sizeof(buffer), "some stuff %d, %d\n",
		 val1, val2);
	archinfo_add_entry("stuff", buffer);
}

That way, the arch core (eg arch/arm/mach-ep93xx/core.c) can create a
base set of entries, and the individual platforms/board files can append
additional information to it.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
