From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 16 May 2018 04:18:51 -0700
Subject: [PATCH 01/14] orangefs: don't return errno values from ->fault
In-Reply-To: <20180516054348.15950-2-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
 <20180516054348.15950-2-hch@lst.de>
Message-ID: <20180516111851.GA20670@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 07:43:35AM +0200, Christoph Hellwig wrote:
> +	rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1, STATX_SIZE);
>  	if (rc) {
>  		gossip_err("%s: orangefs_inode_getattr failed, "
>  		    "rc:%d:.\n", __func__, rc);
> -		return rc;
> +		return VM_FAULT_SIGBUS;

Nope.  orangefs_inode_getattr can return -ENOMEM.

>  	}
>  	return filemap_fault(vmf);
>  }
> -- 
> 2.17.0
> 
