From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 7 Jun 2016 13:21:00 -0700
Subject: [RESEND/PATCHv4 v4 1/3] firmware: Consolidate kmap/read/write
 logic
In-Reply-To: <20160607164741.31849-2-stephen.boyd@linaro.org>
References: <20160607164741.31849-1-stephen.boyd@linaro.org>
 <20160607164741.31849-2-stephen.boyd@linaro.org>
Message-ID: <20160607132100.dcc052bdf5affaab7cdc29ce@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Jun 2016 09:47:39 -0700 Stephen Boyd <stephen.boyd@linaro.org> wrote:

> We use similar structured code to read and write the kmapped
> firmware pages. The only difference is read copies from the kmap
> region and write copies to it. Consolidate this into one function
> to reduce duplication.
> 
> ...
>
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -691,6 +691,29 @@ out:
>  
>  static DEVICE_ATTR(loading, 0644, firmware_loading_show, firmware_loading_store);
>  
> +static void firmware_rw(struct firmware_buf *buf, char *buffer,
> +			loff_t offset, size_t count, bool read)
> +{
> +	while (count) {
> +		void *page_data;
> +		int page_nr = offset >> PAGE_SHIFT;
> +		int page_ofs = offset & (PAGE_SIZE-1);
> +		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
> +
> +		page_data = kmap(buf->pages[page_nr]);

fwiw, we could switch the code to kmap_atomic() here.  It is faster.

> +		if (read)
> +			memcpy(buffer, page_data + page_ofs, page_cnt);
> +		else
> +			memcpy(page_data + page_ofs, buffer, page_cnt);
> +
> +		kunmap(buf->pages[page_nr]);
> +		buffer += page_cnt;
> +		offset += page_cnt;
> +		count -= page_cnt;
> +	}
> +}
