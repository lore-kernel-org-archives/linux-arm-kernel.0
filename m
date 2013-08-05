From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 05 Aug 2013 16:30:56 +0200
Subject: [PATCH v4 2/4] drivers: of: add function to scan fdt nodes given
 by path
In-Reply-To: <1375275119-12787-3-git-send-email-m.szyprowski@samsung.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
 <1375275119-12787-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <xa1ttxj4us4f.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31 2013, Marek Szyprowski wrote:
> Add a function to scan the flattened device-tree starting from the
> node given by the path. It is used to extract information (like reserved
> memory), which is required on ealy boot before we can unflatten the
                                ^^^^ early
> tree.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

Some minor comments inline.

> +static int __init fdt_scan_node_by_path(unsigned long node, const char *uname,
> +					int depth, void *data)
> +{
> +	struct fdt_scan_status *st = data;
> +
> +	/*
> +	 * if scan at the requested fdt node has been completed,
> +	 * return -ENXIO to abort further scanning
> +	 */
> +	if (depth <= st->depth)
> +		return -ENXIO;
> +
> +	/* requested fdt node has been found, so call iterator function */
> +	if (st->found)
> +		return st->iterator(node, uname, depth, st->data);
> +
> +	/* check if scanning automata is entering next level of fdt nodes */
> +	if (depth == st->depth + 1 &&
> +	    strncmp(st->name, uname, st->namelen) == 0) {

+	    strncmp(st->name, uname, st->namelen) == 0 &&
+	    uname[st->namelen] == 0) {

> +		st->depth += 1;
> +		if (st->name[st->namelen] == 0) {
> +			st->found = 1;
> +		} else {
> +			const char *next = st->name + st->namelen + 1;
> +			const char *p = next;
> +			while (*p != '/' && *p != 0)
> +				p++;
> +			st->name = next;
> +			st->namelen = p - next;

+			st->namelen = strcspn(next, "/");

except this might be slightly slower since the second argument is looped
over, but something to consider I guess since it get rid of few of the
lines of code.

> +		}
> +		return 0;
> +	}
> +
> +	/* scan next fdt node */
> +	return 0;
> +}
> +
> +/**
> + * of_scan_flat_dt_by_path - scan flattened tree blob and call callback on each
> + *			     child of the given path.
> + * @path: path to start searching for children
> + * @it: callback function
> + * @data: context data pointer
> + *
> + * This function is used to scan the flattened device-tree starting from the
> + * node given by path. It is used to extract information (like reserved
> + * memory), which is required on ealy boot before we can unflatten the tree.
> + */
> +int __init of_scan_flat_dt_by_path(const char *path,
> +	int (*it)(unsigned long node, const char *name, int depth, void *data),
> +	void *data)
> +{
> +	struct fdt_scan_status st = {path, 0, -1, 0, it, data};
> +	int ret = 0;
> +
> +	if (initial_boot_params)
> +		ret = of_scan_flat_dt(fdt_scan_node_by_path, &st);
> +
> +	if (st.found && ret == -ENXIO)	/* scan has been completed */
> +		return 0;
> +	else
> +		return -ENOENT;

Perhaps propagate ret:

+	if (!st.found)
+		return -ENOENT;
+	else if (ret == -ENXIO)
+		return 0;
+	else
+		return ret;

> +}
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  /**
>   * early_init_dt_check_for_initrd - Decode initrd location from flat tree

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/6cec4a65/attachment.sig>
