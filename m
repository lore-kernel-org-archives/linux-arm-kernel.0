From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 6 Nov 2018 13:51:21 -0800
Subject: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
In-Reply-To: <FD1082D9-916E-47A4-95D3-59F308AD6D55@oracle.com>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
 <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
 <FD1082D9-916E-47A4-95D3-59F308AD6D55@oracle.com>
Message-ID: <20181106135121.dd015f188709c4ccb2bff52c@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Nov 2018 18:41:33 -0600 William Kucharski <william.kucharski@oracle.com> wrote:

> 
> 
> > On Nov 1, 2018, at 3:47 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > -	count = count > PAGE_SIZE ? PAGE_SIZE : count;
> > +	count = min_t(size_t, count, PAGE_SIZE);
> > 	kbuf = kmalloc(count, GFP_KERNEL);
> > 	if (!kbuf)
> > 		return -ENOMEM;
> 
> Is the use of min_t vs. the C conditional mostly to be more self-documenting?

Yup.  It saves the reader from having to parse the code to figure out
"this is a min operation".
