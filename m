From: eric.engestrom@imgtec.com (Eric Engestrom)
Date: Fri, 3 Mar 2017 11:58:42 +0000
Subject: [RFC PATCH 04/12] staging: android: ion: Call dma_map_sg for
 syncing and mapping
In-Reply-To: <20170303110329.GA4132@mwanda>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <1488491084-17252-5-git-send-email-labbott@redhat.com>
 <20170303110329.GA4132@mwanda>
Message-ID: <20170303115841.2fxuhkzo5yazgvrd@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, 2017-03-03 14:04:26 +0300, Dan Carpenter wrote:
> On Thu, Mar 02, 2017 at 01:44:36PM -0800, Laura Abbott wrote:
> >  static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
> >  					enum dma_data_direction direction)
> >  {
> >  	struct dma_buf *dmabuf = attachment->dmabuf;
> >  	struct ion_buffer *buffer = dmabuf->priv;
> > +	struct sg_table *table;
> > +	int ret;
> > +
> > +	/*
> > +	 * TODO: Need to sync wrt CPU or device completely owning?
> > +	 */
> > +
> > +	table = dup_sg_table(buffer->sg_table);
> >  
> > -	ion_buffer_sync_for_device(buffer, attachment->dev, direction);
> > -	return dup_sg_table(buffer->sg_table);
> > +	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> > +			direction)){
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}

Actually, I think `ret` should be left uninitialised on success,
what's really missing is this return before the `err:` label:

+	return table;


> > +
> > +err:
> > +	free_duped_table(table);
> > +	return ERR_PTR(ret);
> 
> ret isn't initialized on success.
> 
> >  }
> >  
> 
> regards,
> dan carpenter
