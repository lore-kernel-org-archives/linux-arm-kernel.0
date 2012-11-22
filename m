From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Thu, 22 Nov 2012 09:56:30 +0100
Subject: Order of clock multiplexer registrations
Message-ID: <50ADE8BE.1000707@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I notice that currently (3.7-rc6) the behaviour of clock multiplexers 
depends on their registration order.

Suppose the hardware has a 2 bit clock select field with
00 => srcA
01 => srcB
10 => unused
11 => srcC

If the multiplexer is registered after the sources:

     static const char *sel[] = { "srcA", "srcB", "dummy", "srcC" };

     clk_register_fixed(NULL, "dummy", ...);
     clk_register_fixed(NULL, "srcA", ...);
     clk_register_fixed(NULL, "srcB", ...);
     clk_register_fixed(NULL, "srcC", ...);
     child = clk_register_mux(NULL, "child",  sel, ARRAY_SIZE(sel), ...);

Then all works as expected and child's parent will depend on the value 
in the hardware clock select register.

However, if the multiplexer is registered before the sources:

     child = clk_register_mux(NULL, "child",  sel, ARRAY_SIZE(sel), ...);
     clk_register_fixed(NULL, "dummy", ...);
     clk_register_fixed(NULL, "srcA", ...);
     clk_register_fixed(NULL, "srcB", ...);
     clk_register_fixed(NULL, "srcC", ...);

Then child's parent will always be the first registered parent clock 
("dummy" in this case) regardless of the
value in the hardware clock select register.

This occurs because of the reparenting code in drivers/clk/clk.c 
__clk_init():

     /*
      * walk the list of orphan clocks and reparent any that are children of
      * this clock
      */
     hlist_for_each_entry_safe(orphan, tmp, tmp2, &clk_orphan_list, 
child_node)
         for (i = 0; i < orphan->num_parents; i++)
             if (!strcmp(clk->name, orphan->parent_names[i])) {
                 __clk_reparent(orphan, clk);
                 break;
             }


Is this a bug or are multiplexers supposed to always be registered after 
their parents?

Currently this occurs for some i.MX53 clocks:
|-- dummy
|   |-- emi_fast_gate
|   |-- gpc_dvfs
|   `-- ipu_di0_sel


Regards,

Martin
