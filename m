From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 Apr 2016 11:10:54 +0100
Subject: [Question] refcount of DT node
In-Reply-To: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
References: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
Message-ID: <20160414101053.GC10273@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 04:47:57PM +0900, Masahiro Yamada wrote:
> Hi experts.
> 
> My understanding of refcount of DT node is poor.
> Please help me understand it correctly.
> 
> Sorry if I am asking stupid questions.
> 
> 
> [1] Does this reference count exist for Overlay?
>     Is a node freed when its refcount becomes zero?

I'm not familiar with the way that overlays are intended to work, but
generally this is true, and I believe the same applies.

Pantelis, please correct me if I am wrong on that front.

> [2] When of_node_put() should be called,
>      or should not be called?
> 
> 
> Shouldn't of_node_put() be called
> when we are still referencing to any of its properties?
> 
> For example,  cpu_read_enable_method()
> in arch/arm64/kernel/cpu_ops.c
> returns a pointer to the property value
> instead of creating a copy of it.
> 
> In this case, of_node_put() should not be called
> because we are still referencing the DT property
> (in other words, referencing to the DT node indirectly).
> 
> Am I right?

Yes, the node should not be freed while its data is referred to.

We are leaking a ref there, though, as we no longer refer to that data
after cpu_read_ops().

Fixing that will require some restructuring. We don't expect a CPU node
to need to disappear, so while it's currently not strictly correct the
code shouldn't lead to any adverse behaviour.

> [3] Is the following code correct?
> 
>    np = of_find_compatible_node(NULL, NULL,"foo-node");
>    of_node_put(np);
>    ret = of_address_to_resource(np, 0, &res);
>    if (ret) {
>             pr_err("failed to get resource\n");
>             return ret;
>    }
> 
> Actually I wrote the code above, and it was applied.
> 
> But, the node is still referenced while of_address_to_resource() is being run.
> 
> So the correct code should be as follows?
> 
>    np = of_find_compatible_node(NULL, NULL,"foo-node");
>    ret = of_address_to_resource(np, 0, &res);
>    of_node_put(np);
>    if (ret) {
>             pr_err("failed to get resource\n");
>             return ret;
>    }

It is correctly balanced, yes.

If you don't need to keep the node for future use, this is fine.

Mark.
