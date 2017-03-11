From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Mar 2017 17:20:11 -0800
Subject: [PATCH] ARM: dts: imx: add Gateworks Ventana GW5904 support
In-Reply-To: <CAJ+vNU1NcW=y_c-jJBnAaOozrzYJAekd9BEiMdd2=Bpx=Ng79Q@mail.gmail.com>
References: <1489178411-6559-1-git-send-email-tharvey@gateworks.com>
 <04584d61-f1e2-3722-1f13-ff133edc0c22@gmail.com>
 <CAJ+vNU1NcW=y_c-jJBnAaOozrzYJAekd9BEiMdd2=Bpx=Ng79Q@mail.gmail.com>
Message-ID: <b105d1ea-7975-bd21-0aa0-762060ceb62a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2017 05:07 PM, Tim Harvey wrote:
> On Fri, Mar 10, 2017 at 12:43 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>> +     dsa {
>>> +             compatible = "marvell,dsa";
>>> +             #address-cells = <2>;
>>> +             #size-cells = <0>;
>>> +
>>> +             dsa,ethernet = <&fec>;
>>> +             dsa,mii-bus = <&mdio>;
>>> +
>>
>> Please consider using the new binding for DSA switches, see:
>>
>> https://patchwork.kernel.org/patch/9493037/
>>
> 
> Hi Florian,
> 
> I tried the new binding first, but haven't gotten it to work yet. Let
> me make sure I understand what I should be doing.
> 
> This is a MV88E6176 so I first need to add dt support for that to the
> mv88e6xxx driver (which supports the device, just not via dt):
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 03dc886..fd5c716 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -4602,6 +4602,10 @@ static const struct of_device_id mv88e6xxx_of_match[] = {
>                 .data = &mv88e6xxx_table[MV88E6085],
>         },
>         {
> +               .compatible = "marvell,mv88e6176",
> +               .data = &mv88e6xxx_table[MV88E6176],
> +       },
> +       {
>                 .compatible = "marvell,mv88e6190",
>                 .data = &mv88e6xxx_table[MV88E6190],
>         },
> 
> Then I remove the old binding and add the new binding as such:
> 
> &fec {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_enet>;
>         phy-mode = "rgmii-id";
>         status = "okay";

You most likely need to declare a fixed PHY for the FEC to be setting up
the link, speed and duplex?

> 
>         mdio {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 switch0 at 0 {
>                         compatible = "marvell,mv88e6176";

I don't think it's necessary to define a new compatible string, using
the existing marvell,mv88e6085 should be good enough, the driver does
runtime detection of the switch chip.

>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         reg = <0>;
> 
>                         ports {
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
>                                 port at 0 {
>                                         reg = <0>;
>                                         label = "lan0";
>                                 };
> 
>                                 port at 1 {
>                                         reg = <1>;
>                                         label = "lan1";
>                                 };
> 
>                                 port at 2 {
>                                         reg = <2>;
>                                         label = "lan2";
>                                 };
> 
>                                 port at 3 {
>                                         reg = <3>;
>                                         label = "lan3";
>                                 };
> 
>                                 port at 5 {
>                                         reg = <5>;
>                                         label = "cpu";
>                                         ethernet = <&fec>;
>                                         fixed-link {
>                                                 speed = <1000>;
>                                                 full-duplex;
>                                         };
>                                 };
>                         };
>                 };
>         };
> };
> 
> This does give me eth0, lan1, lan2, lan3, lan4 netdevs but when I
> bring up eth0 I crash:

Presumably because the driver lets you initialize with a "phy-mode"
property, but neither a valid "phy-handle" nor a fixed-link node, and
that's clearly a bug here.

> 
> root at ventana:~# ifconfig eth0 up
> [   45.826516] ------------[ cut here ]------------
> [   45.831169] Kernel BUG at c01923cc [verbose debug info unavailable]
> [   45.837461] Internal error: Oops - BUG: 0 [#1] SMP ARM
> [   45.842617] Modules linked in:
> [   45.845692] CPU: 0 PID: 486 Comm: ifconfig Tainted: G        W
>  4.11.0-rc1-00020-g0885e48-dirty #537
> [   45.855265] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   45.861805] task: ee2e55c0 task.stack: eddd2000
> [   45.866348] PC is at mod_timer+0x1e4/0x22c
> [   45.870456] LR is at add_timer+0x20/0x28
> [   45.874391] pc : [<c01923cc>]    lr : [<c0192434>]    psr: 600e0093
> [   45.874391] sp : eddd3c20  ip : eddd3c60  fp : eddd3c5c
> [   45.885878] r10: 00000200  r9 : ee828818  r8 : 00000064
> [   45.891112] r7 : ee802e00  r6 : ffff9d19  r5 : ee802e00  r4 : ee21b350
> [   45.897649] r3 : 00000000  r2 : 00000000  r1 : ffff9d19  r0 : ee21b350
> [   45.904187] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> Segment none
> [   45.911417] Control: 10c5387d  Table: 3dea804a  DAC: 00000051
> [   45.917173] Process ifconfig (pid: 486, stack limit = 0xeddd2210)
> [   45.923275] Stack: (0xeddd3c20 to 0xeddd4000)
> [   45.927647] 3c20: c01257f8 c01256e8 000005e9 c01402fc 00000004
> 00000004 ee802e00 ee21b350
> [   45.935838] 3c40: ee802e00 00000064 ee828818 00000200 eddd3c6c
> eddd3c60 c0192434 c01921f4
> [   45.944029] 3c60: eddd3c94 eddd3c70 c014026c c0192420 00000064
> ee21b330 eddd3c94 600e0013
> [   45.952220] 3c80: ee21b330 00000004 eddd3cbc eddd3c98 c01403d8
> c01401f0 ee21b000 00000000
> [   45.960410] 3ca0: c05f9e7c c05f9e7c 00000008 ee828818 eddd3ccc
> eddd3cc0 c05e71a0 c0140368
> [   45.968600] 3cc0: eddd3cec eddd3cd0 c05e945c c05e7188 eddd3d60
> ee21b000 ee837000 c05f9e7c
> [   45.976791] 3ce0: eddd3d14 eddd3cf0 c05e94c0 c05e9430 00000000
> ee837000 eddd3d23 00000000
> [   45.984981] 3d00: c1649b9c ee828818 eddd3dbc eddd3d18 c05f9e14
> c05e9484 00000000 c05f7d48
> [   45.993171] 3d20: 32000000 30383831 652e3030 72656874 2d74656e
> 00000031 000003e8 000000c8
> [   46.001361] 3d40: c0172424 c0171cf4 000003e8 000000c8 014000c0
> 00000000 c1649b9c ee828814
> [   46.009551] 3d60: 38383132 2e303030 65687465 74656e72 303a312d
> ee800030 eddd3dbc eddd3d88
> [   46.017742] 3d80: c021e458 c09a2f30 eddd3dbc c05fcde0 c05f8cc0
> f11ba000 ee837000 ee828000
> [   46.025931] 3da0: 00000000 f11ba000 ee837000 ee828000 eddd3df4
> eddd3dc0 c05fce40 c05f9d18
> [   46.034122] 3dc0: 00000001 ee83766c eddd3df4 ee837000 00000000
> c0a6a9d4 ee837030 00000000
> [   46.042311] 3de0: bebeaeaa 00000000 eddd3e1c eddd3df8 c078dde0
> c05fcbd0 eddd3e1c ee837000
> [   46.050502] 3e00: ee837000 00000001 00001043 00001002 eddd3e44
> eddd3e20 c078e098 c078dd3c
> [   46.058692] 3e20: ee837000 ee83713c 00001002 ee20d80c 00000000
> bebeaeaa eddd3e6c eddd3e48
> [   46.066881] 3e40: c078e17c c078e014 00000000 eddd3e90 00000000
> ee20d80c bebeaaac bebeaeaa
> [   46.075071] 3e60: eddd3edc eddd3e70 c080895c c078e168 c0e6b180
> bebeaaac 00000020 ee20d80c
> [   46.083261] 3e80: ee20d800 00000014 ee837000 00008914 30687465
> 00000000 00000000 00000000
> [   46.091451] 3ea0: b6f81043 bebeaeaa 0000002c 0001b3b8 b6f81002
> 00008914 ed872920 bebeaaac
> [   46.099642] 3ec0: ed872900 00000004 eddd2000 00000000 eddd3eec
> eddd3ee0 c080b334 c0808230
> [   46.107832] 3ee0: eddd3f0c eddd3ef0 c076bab4 c080b1a4 bebeaaac
> ed872920 edf05140 c023af64
> [   46.116022] 3f00: eddd3f7c eddd3f10 c023a5a4 c076b968 ffffff9c
> eddb6000 fffffffe c0107f44
> [   46.124213] 3f20: eddd2000 00000000 eddd3f4c eddd3f38 c0236b2c
> c021cb88 fffffffe ffffff9c
> [   46.132402] 3f40: eddd3f94 eddd3f50 c02242b8 c0236ad4 c0227ef8
> edf05140 00000004 edf05140
> [   46.140593] 3f60: 00008914 bebeaaac eddd2000 00000000 eddd3fa4
> eddd3f80 c023af64 c023a514
> [   46.148782] 3f80: 0001b8f0 0001b6c8 bebeab74 00000036 c0107f44
> eddd2000 00000000 eddd3fa8
> [   46.156972] 3fa0: c0107da0 c023af34 0001b8f0 0001b6c8 00000004
> 00008914 bebeaaac 00001002
> [   46.165162] 3fc0: 0001b8f0 0001b6c8 bebeab74 00000036 00000000
> 00000000 0001b8f8 00000000
> [   46.173352] 3fe0: 0001b07c bebeaa9c 0000accf b6f17c66 000e0030
> 00000004 00000000 00000000
> [   46.181534] Backtrace:
> [   46.184000] [<c01921e8>] (mod_timer) from [<c0192434>] (add_timer+0x20/0x28)
> [   46.191062]  r10:00000200 r9:ee828818 r8:00000064 r7:ee802e00
> r6:ee21b350 r5:ee802e00
> [   46.198899]  r4:00000004
> [   46.201453] [<c0192414>] (add_timer) from [<c014026c>]
> (__queue_delayed_work+0x88/0x178)
> [   46.209560] [<c01401e4>] (__queue_delayed_work) from [<c01403d8>]
> (queue_delayed_work_on+0x7c/0x84)
> [   46.218615]  r6:00000004 r5:ee21b330 r4:600e0013
> [   46.223254] [<c014035c>] (queue_delayed_work_on) from [<c05e71a0>]
> (phy_start_machine+0x24/0x2c)
> [   46.232051]  r9:ee828818 r8:00000008 r7:c05f9e7c r6:c05f9e7c
> r5:00000000 r4:ee21b000
> [   46.239811] [<c05e717c>] (phy_start_machine) from [<c05e945c>]
> (phy_connect_direct+0x38/0x54)
> [   46.248351] [<c05e9424>] (phy_connect_direct) from [<c05e94c0>]
> (phy_connect+0x48/0x80)
> [   46.256367]  r7:c05f9e7c r6:ee837000 r5:ee21b000 r4:eddd3d60
> [   46.262043] [<c05e9478>] (phy_connect) from [<c05f9e14>]
> (fec_enet_mii_probe+0x108/0x170)
> [   46.270234]  r9:ee828818 r8:c1649b9c r7:00000000 r6:eddd3d23
> r5:ee837000 r4:00000000
> [   46.277991] [<c05f9d0c>] (fec_enet_mii_probe) from [<c05fce40>]
> (fec_enet_open+0x27c/0x344)
> [   46.286351]  r6:ee828000 r5:ee837000 r4:f11ba000
> [   46.290985] [<c05fcbc4>] (fec_enet_open) from [<c078dde0>]
> (__dev_open+0xb0/0x118)
> [   46.298567]  r10:00000000 r9:bebeaeaa r8:00000000 r7:ee837030
> r6:c0a6a9d4 r5:00000000
> [   46.306404]  r4:ee837000
> [   46.308950] [<c078dd30>] (__dev_open) from [<c078e098>]
> (__dev_change_flags+0x90/0x154)
> [   46.316963]  r7:00001002 r6:00001043 r5:00000001 r4:ee837000
> [   46.322635] [<c078e008>] (__dev_change_flags) from [<c078e17c>]
> (dev_change_flags+0x20/0x50)
> [   46.331085]  r9:bebeaeaa r8:00000000 r7:ee20d80c r6:00001002
> r5:ee83713c r4:ee837000
> [   46.338844] [<c078e15c>] (dev_change_flags) from [<c080895c>]
> (devinet_ioctl+0x738/0x838)
> [   46.347033]  r9:bebeaeaa r8:bebeaaac r7:ee20d80c r6:00000000
> r5:eddd3e90 r4:00000000
> [   46.354790] [<c0808224>] (devinet_ioctl) from [<c080b334>]
> (inet_ioctl+0x19c/0x1c8)
> [   46.362459]  r10:00000000 r9:eddd2000 r8:00000004 r7:ed872900
> r6:bebeaaac r5:ed872920
> [   46.370296]  r4:00008914
> [   46.372848] [<c080b198>] (inet_ioctl) from [<c076bab4>]
> (sock_ioctl+0x158/0x32c)
> [   46.380262] [<c076b95c>] (sock_ioctl) from [<c023a5a4>]
> (do_vfs_ioctl+0x9c/0xa20)
> [   46.387756]  r7:c023af64 r6:edf05140 r5:ed872920 r4:bebeaaac
> [   46.393429] [<c023a508>] (do_vfs_ioctl) from [<c023af64>]
> (SyS_ioctl+0x3c/0x64)
> [   46.400751]  r10:00000000 r9:eddd2000 r8:bebeaaac r7:00008914
> r6:edf05140 r5:00000004
> [   46.408589]  r4:edf05140
> [   46.411141] [<c023af28>] (SyS_ioctl) from [<c0107da0>]
> (ret_fast_syscall+0x0/0x1c)
> [   46.418724]  r9:eddd2000 r8:c0107f44 r7:00000036 r6:bebeab74
> r5:0001b6c8 r4:0001b8f0
> [   46.426479] Code: eaffffbd e1a0500a e1a0a005 eaffffcc (e7f001f2)
> [   46.432587] ---[ end trace c923534ad86e0767 ]---
> Segmentation fault
> root at ventana:~# [   67.156856] systemd-journald[202]: Successfully
> sent stream file descriptor to service manager.
> 
> Is there something wrong with my dt node that you see or perhaps
> something else going on here required by the new binding?
> 
> Thanks,
> 
> Tim
> 
>>> +             switch at 0 {
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <0>;
>>> +                     reg = <0 0>; /* MDIO address 0, switch 0 in tree */
>>> +
>>> +                     port at 0 {
>>> +                             reg = <0>;
>>> +                             label = "lan4";
>>> +                     };
>>> +
>>> +                     port at 1 {
>>> +                             reg = <1>;
>>> +                             label = "lan3";
>>> +                     };
>>> +
>>> +                     port at 2 {
>>> +                             reg = <2>;
>>> +                             label = "lan2";
>>> +                     };
>>> +
>>> +                     port at 3 {
>>> +                             reg = <3>;
>>> +                             label = "lan1";
>>> +                     };
>>> +
>>> +                     port at 5 {
>>> +                             reg = <5>;
>>> +                             label = "cpu";
>>> +                             fixed-link {
>>> +                                     speed = <1000>;
>>> +                                     full-duplex;
>>> +                             };
>>> +                     };
>>> +             };
>>> +     };
>>> +};
>> --
>> Florian


-- 
Florian
