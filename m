From: horms@verge.net.au (Simon Horman)
Date: Mon, 12 Oct 2015 09:16:34 +0900
Subject: [PATCH 3/5] ARM: shmobile: R-Mobile: add missing of_node_put
In-Reply-To: <1444480254-14399-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20151012001634.GE20025@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 02:30:52PM +0200, Julia Lawall wrote:
> for_each_child_of_node performs an of_node_get on each iteration, so
> a break out of the loop requires an of_node_put.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> @@
> 
>  for_each_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> (
>    return child;
> |
> +  of_node_put(child);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks, I have queued this up as a cleanup for v4.4.
