From: joe@perches.com (Joe Perches)
Date: Thu, 24 Mar 2011 15:49:05 -0700
Subject: [PATCH 0/2] Fix resource size miscalculations
In-Reply-To: <cover.1300909445.git.joe@perches.com>
References: <cover.1300909445.git.joe@perches.com>
Message-ID: <1301006945.29444.15.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-23 at 12:55 -0700, Joe Perches wrote:
> Use resource_size a few places

Perhaps this relatively common error is too common.
It seems to be poor style.  A possible better style for
struct resource uses could be inline function(s) like:

static inline void __iomem *resource_ioremap(struct resource *r)
{
	return ioremap(r->start, resource_size(r));
}

and maybe

static inline struct resource *
resource_request_region(struct resource *r, const char *name)
{
	return __request_region(&ioport_resource, r->start, resource_size(r), name, 0);
}
