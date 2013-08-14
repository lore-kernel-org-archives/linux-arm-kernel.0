From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Aug 2013 11:11:04 +0200
Subject: [PATCH 0/29] simplify use of devm_ioremap_resource
Message-ID: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource often uses the result of a call to
platform_get_resource as its last argument.  devm_ioremap_resource does
appropriate error handling on this argument, so error handling can be
removed from the call site.  To make the connection between the call to
platform_get_resource and the call to devm_ioremap_resource more clear, the
former is also moved down to be adjacent to the latter.

In many cases, this patch changes the specific error value that is
returned on failure of platform_get_resource.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l;
@@

(
  res = platform_get_resource(pdev, IORESOURCE_MEM, n);
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  e = devm_ioremap_resource(e1, res);
|
- res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  e = devm_ioremap_resource(e1, res);
)
// </smpl>
