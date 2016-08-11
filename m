From: loic.pallardy@st.com (loic pallardy)
Date: Thu, 11 Aug 2016 09:51:00 +0200
Subject: [PATCH 6/9] remoteproc: core: Add function to append a new
 resource table entry
In-Reply-To: <20160804092153.23032-7-lee.jones@linaro.org>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-7-lee.jones@linaro.org>
Message-ID: <57AC2E64.9010209@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

I just tested your series and found issue with append mechanism.
There is no problem to add resources when working on Linux side, but the 
resource table is growing and when copying it at loaded location (ie 
overwriting existing prebuilt resource table of firmware), you have an 
overflow corrupting part of firmware code.

Moreover firmware code is in general tuned to a feature set. Resource 
table is created according to supported features. In most of the cases, 
new resource won't be handled by firmware.

Regards,
Loic


On 08/04/2016 11:21 AM, Lee Jones wrote:
> A new function now exists to pull in and amend and existing resource
> table entry.  But what if we wish to provide a new resource?  This
> function provides functionality to append a brand new resource entry
> onto the resource table.  All complexity related to shuffling parts
> of the table around, providing new offsets and incriminating number
> of entries in the resource table's top-level header is taken care of
> here.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/remoteproc/remoteproc_core.c | 55 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 3318ebd..111350e 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -980,6 +980,61 @@ static int rproc_update_resource_table_entry(struct rproc *rproc,
>   	return !updated;
>   }
>
> +static struct resource_table*
> +rproc_add_resource_table_entry(struct rproc *rproc,
> +			       struct rproc_request_resource *request,
> +			       struct resource_table *old_table, int *tablesz)
> +{
> +	struct resource_table *table;
> +	struct fw_rsc_hdr h;
> +	void *new_rsc_loc;
> +	void *fw_header_loc;
> +	void *start_of_rscs;
> +	int new_rsc_offset;
> +	int size = *tablesz;
> +	int i;
> +
> +	h.type = request->type;
> +
> +	new_rsc_offset = size;
> +
> +	/*
> +	 * Allocate another contiguous chunk of memory, large enough to
> +	 * contain the new, expanded resource table.
> +	 *
> +	 * The +4 is for the extra offset[] element in the top level header
> +	 */
> +	size += sizeof(struct fw_rsc_hdr) + request->size + 4;
> +	table = devm_kmemdup(&rproc->dev, old_table, size, GFP_KERNEL);
> +	if (!table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Shunt table by 4 Bytes to account for the extra offset[] element */
> +	start_of_rscs = (void *)table + table->offset[0];
> +	memmove(start_of_rscs + 4,
> +		start_of_rscs, new_rsc_offset - table->offset[0]);
> +	new_rsc_offset += 4;
> +
> +	/* Update existing resource entry's offsets */
> +	for (i = 0; i < table->num; i++)
> +		table->offset[i] += 4;
> +
> +	/* Update the top level 'resource table' header */
> +	table->offset[table->num] = new_rsc_offset;
> +	table->num++;
> +
> +	/* Copy new firmware header into table */
> +	fw_header_loc = (void *)table + new_rsc_offset;
> +	memcpy(fw_header_loc, &h, sizeof(h));
> +
> +	/* Copy new resource entry into table */
> +	new_rsc_loc = (void *)fw_header_loc + sizeof(h);
> +	memcpy(new_rsc_loc, request->resource, request->size);
> +
> +	*tablesz = size;
> +	return table;
> +}
> +
>   /*
>    * take a firmware and boot a remote processor with it.
>    */
>
