From: lsanfil@marvell.com (Lino Sanfilippo)
Date: Mon, 2 Mar 2015 11:01:41 +0100
Subject: [RFC PATCH 0/1] Wrong structure alignment due to compiler attribute
 "section"
Message-ID: <1425290502-2322-1-git-send-email-lsanfil@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

I came across a problem concerning structure alignment on ARM architectures (in
this case the "clock_provider" struct) when structures are placed by means of the
"section" compiler attribute. I noticed that with a certain cross compiler one
byte padding is inserted in between the structures:

<snip> System.map
c074cec0 T __clk_of_table
c074cec0 t __of_table_fixed_factor_clk
c074cec0 T __stop_kprobe_blacklist
c074cf88 t __of_table_fixed_clk
c074d050 t __of_table_gpio_gate_clk
c074d118 t __of_table_mv88f6180_clk
c074d1e0 t __of_table_kirkwood_clk
c074d2a8 t __clk_of_table_sentinel
<snap>

As one can see the difference between the adresses are 200 bytes although a
clock_provider only is 196 bytes in size. 

The problem is that in of_clk_init() the __clk_of_table is used as the base of
an array. Due to the padding the values in all array elements but the first one
are corruped. However with another cross compiler I could not trigger this. So
this issue seems to be compiler/linker dependent. With the attached patch
applied the layout is correct: 

c074ce58 T __clk_of_table
c074ce58 t __of_table_fixed_factor_clk
c074ce58 T __stop_kprobe_blacklist
c074cf1c t __of_table_fixed_clk
c074cfe0 t __of_table_gpio_gate_clk
c074d0a4 t __of_table_mv88f6180_clk
c074d168 t __of_table_kirkwood_clk
c074d22c t __clk_of_table_sentinel

I can trigger the issue with this compiler:
wget http://www.plugcomputer.org/405/us/gplugd/tool-chain/arm-marvell-linux-gnueabi.tar.bz2

Note that this issue popped up some years ago for x86 too:
http://lkml.iu.edu/hypermail/linux/kernel/0706.2/2552.html

I am not sure that this is the right fix though, thats why I sent that as an
RFC.

Regards, 
Lino


Lino Sanfilippo (1):
  ARM: Ensure correct structure alignment when using compiler attribute
    "section"

 include/linux/compiler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.9.1
