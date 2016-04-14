From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 14 Apr 2016 16:47:57 +0900
Subject: [Question] refcount of DT node
Message-ID: <CAK7LNATFUW2KXUpFas6C_SJ0C7Qb1DWU0njLg-FCYciK2U6Oag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi experts.

My understanding of refcount of DT node is poor.
Please help me understand it correctly.

Sorry if I am asking stupid questions.


[1] Does this reference count exist for Overlay?
    Is a node freed when its refcount becomes zero?


[2] When of_node_put() should be called,
     or should not be called?


Shouldn't of_node_put() be called
when we are still referencing to any of its properties?

For example,  cpu_read_enable_method()
in arch/arm64/kernel/cpu_ops.c
returns a pointer to the property value
instead of creating a copy of it.

In this case, of_node_put() should not be called
because we are still referencing the DT property
(in other words, referencing to the DT node indirectly).

Am I right?


[3] Is the following code correct?

   np = of_find_compatible_node(NULL, NULL,"foo-node");
   of_node_put(np);
   ret = of_address_to_resource(np, 0, &res);
   if (ret) {
            pr_err("failed to get resource\n");
            return ret;
   }

Actually I wrote the code above, and it was applied.

But, the node is still referenced while of_address_to_resource() is being run.

So the correct code should be as follows?

   np = of_find_compatible_node(NULL, NULL,"foo-node");
   ret = of_address_to_resource(np, 0, &res);
   of_node_put(np);
   if (ret) {
            pr_err("failed to get resource\n");
            return ret;
   }



-- 
Best Regards
Masahiro Yamada
