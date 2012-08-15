From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 15 Aug 2012 18:58:16 -0400
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <CADhrpJ4kqpxJrBFPD4o=B3ni=ZUX3EdjBW30k9HxazEB75RMPg@mail.gmail.com>
References: <20120814235653.GA22226@titan.lakedaemon.net>
 <95D5BE56-A79F-4422-B1CE-7AD010A9D70E@gmail.com>
 <20120815111209.GB22226@titan.lakedaemon.net>
 <CAMW5Ufb-8NrWu6vsJ+RezrLEGj-Wfm5Tc+0BK9_2qzn671FrpQ@mail.gmail.com>
 <20120815121145.GC22226@titan.lakedaemon.net>
 <CADhrpJ4-4n15yfttBBFQOdOkKag0gaeqYgB4DFre3aG+R4Vq+Q@mail.gmail.com>
 <20120815135427.GF22226@titan.lakedaemon.net>
 <CADhrpJ5JEGQWAjwu5+=Hy_gFjWLkkrzj9E0dZ-vxMk9x+M5uCA@mail.gmail.com>
 <20120815201949.GI22226@titan.lakedaemon.net>
 <CADhrpJ4kqpxJrBFPD4o=B3ni=ZUX3EdjBW30k9HxazEB75RMPg@mail.gmail.com>
Message-ID: <20120815225816.GJ22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 08:56:29PM +0000, alan butler wrote:
...
> >> +     gpio_keys {
> >> +             compatible = "gpio-keys";
> >> +             #address-cells = <1>;
> >> +             #size-cells = <0>;
> >> +             button at 1 {
> >> +                     label = "OTB Button";
> >> +                     linux,code = <0x00>;
> >> +                     gpios = <&gpio1 4 1>;
> >> +                     debounce-interval = <100>;
> >> +             };
> >> +             button at 2 {
> >> +                     label = "Reset";
> >> +                     linux,code = <0x01>;
> >> +                     gpios = <&gpio0 12 1>;
> >> +                     debounce-interval = <100>;
> >> +             };
> >> +             button at 3 {
> >> +                     label = "Power";
> >> +                     linux,code = <0x028>;
> >> +                     gpios = <&gpio0 14 1>;
> >> +                     debounce-interval = <100>;
> >> +             };
> >> +     };
> >> +};
...
> As far as i can tell from looking at the iconnect button definition's
> that part is correct (except for the proper codes to do what the
> buttons should actually do) the error i get is:
> 
> [    5.976074] Key type dns_resolver registered
> [    5.981782] Unable to handle kernel NULL pointer dereference at
> virtual address 00000004
> [    5.989932] pgd = c0004000
> [    5.992649] [00000004] *pgd=00000000
> [    5.996247] Internal error: Oops: 805 [#1] ARM
> [    6.000707] Modules linked in:
> [    6.003780] CPU: 0    Not tainted  (3.6.0-rc1-next-20120814 #13)
> [    6.009822] PC is at gpio_keys_probe+0x110/0x6d4
> [    6.014471] LR is at of_get_named_gpio_flags+0x90/0xb4
> [    6.019634] pc : [<c02e3190>]    lr : [<c0191a80>]    psr: 60000013
> [    6.019634] sp : cf82feb8  ip : 00000001  fp : cf867400
> [    6.031158] r10: cf867408  r9 : 00000028  r8 : 00000000
> [    6.036400] r7 : c07ebde0  r6 : c07ebe64  r5 : 00000000  r4 : ceff7600
> [    6.042958] r3 : 00000001  r2 : c042e57c  r1 : 00000000  r0 : 00000023
> [    6.049516] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment kernel
> [    6.056857] Control: 0005397f  Table: 0eff8000  DAC: 00000017
> [    6.062629] Process swapper (pid: 1, stack limit = 0xcf82e270)
> [    6.068481] Stack: (0xcf82feb8 to 0xcf830000)
> [    6.072851] fea0:
>     00000000 cefff380
> [    6.081071] fec0: cf865b40 c00e88f8 cf84e080 00000000 cf808bac
> 00000003 cf865b40 00000001
> [    6.089286] fee0: cf86743c cf867408 cf86743c c04476cc c04476cc
> 00000034 c041d318 c03fb208
> [    6.097500] ff00: 00000000 c01c7ccc c01c7cb8 c01c6dc4 00000000
> cf867408 cf86743c c04476cc
> [    6.105713] ff20: 00000000 c01c6f5c c04476cc cf82ff38 c01c6efc
> c01c58b4 cf808b8c cf8641b0
> [    6.113928] ff40: c04476cc c04476cc ceffe300 c0442d18 00000000
> c01c654c c03aa8b2 c03aa8b3
> [    6.122141] ff60: c04476cc c0412e40 00000000 c0451300 00000034
> c01c7208 00000000 00000007
> [    6.130355] ff80: c0412e40 00000000 c0451300 00000034 c03fb208
> c0008554 00000007 00000007
> [    6.138570] ffa0: 00000000 00000007 c0419614 00000007 c0419618
> c04195f8 c0451300 00000034
> [    6.146784] ffc0: c041d318 c03fb894 00000007 00000007 c03fb208
> 00000000 00000000 c03fb77c
> [    6.154999] ffe0: c000a004 00000013 00000000 00000000 00000000
> c000a004 80040038 08040038
> [    6.163226] [<c02e3190>] (gpio_keys_probe+0x110/0x6d4) from
> [<c01c7ccc>] (platform_drv_probe+0x14/0x18)
> [    6.172676] [<c01c7ccc>] (platform_drv_probe+0x14/0x18) from
> [<c01c6dc4>] (driver_probe_device+0xb8/0x1f0)
> [    6.182385] [<c01c6dc4>] (driver_probe_device+0xb8/0x1f0) from
> [<c01c6f5c>] (__driver_attach+0x60/0x84)
> [    6.191827] [<c01c6f5c>] (__driver_attach+0x60/0x84) from
> [<c01c58b4>] (bus_for_each_dev+0x4c/0x78)
> [    6.200922] [<c01c58b4>] (bus_for_each_dev+0x4c/0x78) from
> [<c01c654c>] (bus_add_driver+0xa8/0x21c)
> [    6.210017] [<c01c654c>] (bus_add_driver+0xa8/0x21c) from
> [<c01c7208>] (driver_register+0x9c/0x138)
> [    6.219112] [<c01c7208>] (driver_register+0x9c/0x138) from
> [<c0008554>] (do_one_initcall+0x90/0x168)
> [    6.228294] [<c0008554>] (do_one_initcall+0x90/0x168) from
> [<c03fb894>] (kernel_init+0x118/0x1d8)
> [    6.237215] [<c03fb894>] (kernel_init+0x118/0x1d8) from
> [<c000a004>] (kernel_thread_exit+0x0/0x8)
> [    6.246130] Code: e5945000 ebfaba19 e0255899 e59d3024 (e5850004)
> [    6.252273] ---[ end trace 192fd8390b667beb ]---
> [    6.256946] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> 

Take a look at Documentation/devicetree/bindings/gpio/gpio_keys.txt, I
think you need 'linux,input-type = "EV_SW";' for each of the buttons.
Or, the numerical equivalent, <0x05>.

> and as for the git command i tried and what it tells me this is what i get:
> 
> git send-email --to="alanbutty12 at gmail.com" --smtp-server=Gmail
> --no-chain-reply-to --from="alanbutty12 at gmail.com"
> /tmp/patches/*.patch
> 
> 
> error:
> git: 'send-email' is not a git command. See 'git --help'.

sudo apt-get install git-send-email

then, follow the section "Another method, I didn't try it" here:

https://mohammadthalif.wordpress.com/2010/01/02/configuring-git-send-email-to-use-gmail-smtp/

hth,

Jason.
