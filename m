From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 29 Sep 2014 14:40:38 +0800
Subject: mfd_add_devices() doesn't check whether nodes are "diabled" in dts
Message-ID: <CAGsJ_4yqumj3=54HwxuzVffPjHdQZrCP2wYc2TSumKsg0-wm7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Samuel, Lee,
the current mfd_add_devices() doesn't check whether nodes are diabled
in dts, so even though we put status = "disabled" in dts for a MFD
subnode, it will still create the platform_device. this will cause the
platform_driver to execute probe() entry.

mfd-core is doing:

mfd_add_device()

alloc platform_device no matter it is disabled or not:

92         pdev = platform_device_alloc(cell->name, id + cell->id);
 93         if (!pdev)
 94                 goto fail_alloc;

....
extend all nodes:

112         if (parent->of_node && cell->of_compatible) {
113                 for_each_child_of_node(parent->of_node, np) {
114                         if (of_device_is_compatible(np,
cell->of_compatible)) {
115                                 pdev->dev.of_node = np;
116                                 break;
117                         }
118                 }
119         }

it seems it doesn't match with the general behavior like
of_platform_populate(), in which we only extend available nodes.

how do you think if we do a fix for the behaviour of mfd_add_devices()
and mfd_remove_devices()?

-barry
